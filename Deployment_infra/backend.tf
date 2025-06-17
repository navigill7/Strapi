terraform { 
  cloud { 
    
    organization = "navigill" 

    workspaces { 
      name = "Strapi_project" 
    } 
  } 
}