// 1st VM
param VMname01 string
param VM01admin string
param VM01Pass string
param location string

resource VM01 'Microsoft.Compute/virtualMachines@2020-06-01' = {
  name: 'VM001'
  location: location
  properties: {
    osProfile: {
      computerName: VMname01
      adminUsername: VM01admin
      adminPassword: VM01Pass
      windowsConfiguration: {
        provisionVMAgent: true
      }
    }
    hardwareProfile: {
      vmSize: virtualMachineSize
    }
    storageProfile: {
      imageReference: {
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: '2016-Datacenter'
        version: 'latest'
      }
      osDisk: {
        createOption: 'FromImage'
      }
      dataDisks: []
    }
    networkProfile: {
      networkInterfaces: [
        {
          properties: {
            primary: true
          }
          id: nic1.id
        }
      ]
    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: true
        storageUri: diagsAccount1.properties.primaryEndpoints.blob
      }
    }
  }
}

// NIC config
resource nic1 'Microsoft.Network/networkInterfaces@2020-06-01' = {
  name: 'nic1Name'
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          subnet: {
            id: '${vnet1.id}/subnets/${subnet1Name}'
          }
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: pip1.id
          }
        }
      }
    ]
    networkSecurityGroup: {
      id: nsg1.id
    }
  }
}