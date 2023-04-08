# Challenge 1 - A 3-tier environment.

Here I am creating a 3-tier application architecture using WebApp, Function App and Azure SQL as below.

1. Direct public access to Web App which is our front-end.
2. App Services will be Vnet integrated which will allow App Services to access resources within the vnet.
3. A Backend Function App which is blocked from direct public access.
4. Access to Azure SQL is restricted via service endpoint.


Modules Folder contains modules which have the terraform resource blocks for the resources to be provisioned.

InfraDeployment Folder contains master_module.tf file that will call the modules in terraform plan and apply stage.

Pipelines contains the YAML pipelines for automating the entire deployment.




