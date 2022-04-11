param virtualMachineName1 string
param location string
param adminUsername string
param adminPassword string
param subnetId string

resource vm1 'Microsoft.Compute/virtualMachines@2020-06-01' = {
  name: virtualMachineName1
  location: location
  properties: {
    osProfile: {
      computerName: virtualMachineName1
      adminUsername: adminUsername
      adminPassword: adminPassword
      windowsConfiguration: {
        provisionVMAgent: true
      }
    }
    hardwareProfile: {
      vmSize: 'Standard_A1_v2'
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


// This will be your VM01 NIC
resource nic1 'Microsoft.Network/networkInterfaces@2020-06-01' = {
  name: 'VM1nic'
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          subnet: {
            id: subnetId
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

// Public IP for your VM01
resource pip1 'Microsoft.Network/publicIPAddresses@2020-06-01' = {
  name: 'VM01PIP'
  location: location
  properties: {
    publicIPAllocationMethod: 'Dynamic'
  }
}

// Network Security Group (NSG) for VM01
resource nsg1 'Microsoft.Network/networkSecurityGroups@2020-06-01' = {
  name: 'networkSecurityvnet1'
  location: location
  properties: {
    securityRules: [
      {
        name: 'default-allow-rdp'
        properties: {
          priority: 1000
          sourceAddressPrefix: '*'
          protocol: 'Tcp'
          destinationPortRange: '3389'
          access: 'Allow'
          direction: 'Inbound'
          sourcePortRange: '*'
          destinationAddressPrefix: '*'
        }
      }
    ]
  }
}

resource diagsAccount1 'Microsoft.Storage/storageAccounts@2019-06-01' = {
  name: 'diagstorage1983'
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'Storage'
}
