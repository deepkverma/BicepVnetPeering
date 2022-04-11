@description('Specifies the location for resources.')
param RGlocation string
param vm1pass string
param vm1admin string
param vm1name string


// Below is the cmdlt to deploy from Azure CLI
//az deployment sub create --name rgDeployment --template-file .\main.bicep --location WestUS

targetScope = 'subscription'
resource rg 'Microsoft.Resources/resourceGroups@2021-01-01' = {
  name: 'BicepVnetpeering'
  location: RGlocation
}

// Deploying VNet1 account using module
module Vnet1 './vnet1.bicep' = {
  name: 'Vnet1deployment'
  scope: rg    // Deployed in the scope of resource group we created above
 params: {
   vnet1location: 'eastus'
 }
  
}

// Deploying VNet2 account using module
module Vnet2 './vnet2.bicep' = {
  name: 'Vnet2deployment'
  scope: rg    // Deployed in the scope of resource group we created above
 
  params: {
    vnet2location: 'eastus'
  }
  
}

//Deploy VM01 to Vnet1, this is the module call to VM1 creation

module VM1 './VM1.bicep' = {
  scope: rg
  name:  'VM1'
  params: {
    adminPassword: vm1pass
    adminUsername: vm1admin
    location: 'eastus'
    virtualMachineName1: vm1name
    subnetId: Vnet1.outputs.subnetId
  }
}

