@description('Azure region for all resources.')
param location string = 'canadaeast'

@description('Globally unique name of the App Service web app.')
param webAppName string = 'CodeRocketProd'

var appServicePlanName = '${webAppName}-plan'

resource appServicePlan 'Microsoft.Web/serverfarms@2024-11-01' = {
  name: appServicePlanName
  location: location
  kind: 'app'
  sku: {
    name: 'S1'
    tier: 'Standard'
    capacity: 1
  }
  properties: {
    reserved: false
  }
}

resource webApp 'Microsoft.Web/sites@2024-11-01' = {
  name: webAppName
  location: location
  kind: 'app'
  properties: {
    serverFarmId: appServicePlan.id
    siteConfig: {
      netFrameworkVersion: 'v10.0'
    }
  }
}

output webAppName string = webApp.name
output webAppUrl string = 'https://${webApp.properties.defaultHostName}'
