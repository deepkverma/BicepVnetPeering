// This will build VNET2.
param vnet2location string
resource vnet2 'Microsoft.Network/virtualNetworks@2020-06-01' = {
  name: 'vnet2'
  location: vnet2location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '20.20.0.0/16'
      ]
    }
    subnets: [
      {
        name: 'vnet2subnet3'
        properties: {
          addressPrefix: '20.20.0.0/24'
          
        }
      }
      {
        name: 'vnet2subnet4'
        properties: {
          addressPrefix: '20.20.1.0/24'
        }
      }
    ]
  }
}
