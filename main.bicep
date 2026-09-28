
var location = resourceGroup().location


resource storageAccount 'Microsoft.Storage/storageAccounts@2023-05-01' = {
  name: 'toystg${uniqueString(resourceGroup().id)}'
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
  }
}

// 2. App Service Plan
resource appServicePlan 'Microsoft.Web/serverfarms@2024-04-01' = {
  name: 'toy-product-launch-plan-starter'
  location: location
  sku: {
    name: 'F1'
  }
}

// 3. Web App
resource appServiceApp 'Microsoft.Web/sites@2024-04-01' = {
  name: 'toylaunch-${uniqueString(resourceGroup().id)}'
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
  }
}
