// 2nd VM

param location string
param VM02name string
param admin02Username string
param admin02pass string

resource VM02 'Microsoft.Compute/virtualMachines@2020-06-01' = {
  name: 'VM002'
  location: location
  properties: {
    osProfile: {
      computerName: VM02name
      adminUsername: admin02Username
      adminPassword: admin02pass
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
          id: nic2.id
        }
      ]
    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: true
        storageUri: diagsAccount2.properties.primaryEndpoints.blob
      }
    }
  }
}
