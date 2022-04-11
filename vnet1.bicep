
// This will build VNET1.
param vnet1location string
var subnetName = 'main-subnet'


resource vnet1 'Microsoft.Network/virtualNetworks@2020-06-01' = {
  name: 'vnet1'
  location: vnet1location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.10.0.0/16'
      ]
    }
    subnets: [
      {
        name: subnetName
        properties: {
          addressPrefix: '10.10.0.0/24'
          
        }
      }
      
      {
        name: 'vnet1subnet2'
        properties: {
          addressPrefix: '10.10.1.0/24'
        }
      }
    ]
  }
}

output subnetId string = '${vnet1.id}/subnets/${subnetName}'



