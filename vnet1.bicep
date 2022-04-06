
// This will build VNET1.
param vnet1location string

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
        name: 'vnet1subnet1'
        properties: {
          addressPrefix: '10.10.0.0/24'
          networkSecurityGroup: {
            id: nsg1.id
          }
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
