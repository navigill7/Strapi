import json
import boto3

ecs = boto3.client('ecs')
ec2 = boto3.client('ec2')

def lambda_handler(event, context):
    print("🔍 Starting ECS Cleanup Lambda")

    clusters = ecs.list_clusters()['clusterArns']
    print(f"📦 Found ECS Clusters: {clusters}")

    for cluster in clusters:
        print(f"\n➡️ Checking cluster: {cluster}")

        # Cleanup stopped tasks
        stopped_tasks = ecs.list_tasks(cluster=cluster, desiredStatus='STOPPED')['taskArns']
        if not stopped_tasks:
            print("✅ No stopped tasks found.")
        else:
            print(f"🧹 Found stopped tasks: {stopped_tasks}")
            for task in stopped_tasks:
                try:
                    print(f"Deleting stopped task: {task}")
                    ecs.stop_task(cluster=cluster, task=task)
                except Exception as e:
                    print(f"❌ Error deleting task {task}: {str(e)}")

        # Cleanup unused services
        services = ecs.list_services(cluster=cluster)['serviceArns']
        if not services:
            print("✅ No services found.")
        else:
            print(f"🔎 Found services: {services}")
            described_services = ecs.describe_services(cluster=cluster, services=services)['services']
            for service in described_services:
                if service['runningCount'] == 0 and service['pendingCount'] == 0:
                    try:
                        print(f"🗑️ Deleting service: {service['serviceName']}")
                        ecs.delete_service(cluster=cluster, service=service['serviceName'], force=True)
                    except Exception as e:
                        print(f"❌ Error deleting service {service['serviceName']}: {str(e)}")
                else:
                    print(f"⏭️ Skipping service (in use): {service['serviceName']}")

    # Cleanup unused ENIs
    enis = ec2.describe_network_interfaces(Filters=[
        {'Name': 'status', 'Values': ['available']}
    ])['NetworkInterfaces']

    if not enis:
        print("✅ No available ENIs found.")
    else:
        print(f"🔌 Found available ENIs: {[eni['NetworkInterfaceId'] for eni in enis]}")
        for eni in enis:
            eni_id = eni['NetworkInterfaceId']
            try:
                print(f"🗑️ Deleting ENI: {eni_id}")
                ec2.delete_network_interface(NetworkInterfaceId=eni_id)
            except Exception as e:
                print(f"❌ Error deleting ENI {eni_id}: {str(e)}")

    print("\n✅ ECS cleanup function completed.")

    return {
        'statusCode': 200,
        'body': json.dumps('ECS cleanup completed!')
    }
