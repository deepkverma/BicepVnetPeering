@description('Specifies the location for resources.')
param RGlocation string
param vnetlocation string
// Below is the cmdlt to deploy from Azure CLI
//az deployment sub create --name rgDeployment --template-file .\main.bicep --location WestUS

targetScope = 'subscription'
resource rg 'Microsoft.Resources/resourceGroups@2021-01-01' = {
  name: 'BicepRG'
  location: RGlocation
}

// Deploying VNet account using module
module Vnet './vnet.bicep' = {
  name: 'Vnetdeployment'
  scope: rg    // Deployed in the scope of resource group we created above
 
  params: {
    Vnetlocation: vnetlocation
  }
}

//Deploying VM using module
 /*module VM 'Winvm.bicep' = {

 name: 'VMdeployment'
 scope: rg
 params: {
   VMadm: 
   WindowsOS: 
   VMPass: 
 }
} */
