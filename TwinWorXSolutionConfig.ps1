
param(
      [string]$iothubname,
      [string]$iothubs_iotHubSasKey,
      [string]$s_iotHubSasKeyName,
      [string]$ConsumerGroup,
      [string]$eventhubname,
      [string]$eventHubConnectionString,
	  [string]$blobstrgconstring,
      [string]$postgreHost,
      [string]$postgreUserName,
      [string]$postgrePassword,
      [string]$vmIP,
	  [string]$vmName,
      [string]$digitalTwinHostUrl,
      [string]$digitalTwinHostName,
      [string]$subscriptionId,
      [string]$resourceGroupName,
      [string]$pgServerName
       
  )


#-------------End-------------------------
#########--restart pg server

$response = Invoke-WebRequest -Uri 'http://169.254.169.254/metadata/identity/oauth2/token?api-version=2018-02-01&resource=https%3A%2F%2Fmanagement.azure.com%2F' -Method GET -UseBasicParsing -Headers @{Metadata="true"}

$content = $response.Content | ConvertFrom-Json

$token = $content.access_token
$btoken="Bearer $token"

$Header = @{
    'Content-type' = 'application/json'
     Authorization =$btoken
}
$uri='https://management.azure.com/subscriptions/'+$subscriptionId+'/resourceGroups/'+$resourceGroupName+'/providers/Microsoft.DBforPostgreSQL/servers/'+$pgServerName+'/restart?api-version=2017-12-01'


Invoke-WebRequest $uri  -Headers $Header -Method 'POST'

Start-Sleep -s 120

#################

#-------------------Variable Declare and Initilize----------------------------
$loginUsername='twxadmin'
$loginPassword='Izt@1234'
#$userEmail=''
#$userPassword=''
$iotHubConString='HostName='+$iothubname+'.azure-devices.net;SharedAccessKeyName='+$s_iotHubSasKeyName+';SharedAccessKey='+$iothubs_iotHubSasKey+''
#$deviceId='IoTDevice01'
$ConfigurationPortalUrl='http://'+$vmIP
$ApiGatewayUrl='http://'+$vmIP+':1007'
$TwinWorXServiceRegisteryPath = 'C:\TwinWorX-Solution\Microservices\TwinWorXServiceRegistery\appsettings.json'
$TwinWorXDataResourceMangaerPath = 'C:\TwinWorX-Solution\Microservices\TwinWorXDataResourceManager\appsettings.json'
$TwinWorXDataAccessServicePath = 'C:\TwinWorX-Solution\Microservices\TwinWorXDataAccessService\appsettings.json'
$TwinWorxDataAlarmingServicePath = 'C:\TwinWorX-Solution\Microservices\TwinWorxDataAlarmingService\appsettings.json'
$TwinWorXHistoricalDataAccessServicePath = 'C:\TwinWorX-Solution\Microservices\TwinWorXHistoricalDataAccessService\appsettings.json'
$TwinWorXAlarmingLoggerServicePath = 'C:\TwinWorX-Solution\Microservices\TwinWorXAlarmingLoggerService\appsettings.json'
$TwinWorXApiGatewayPath = 'C:\TwinWorX-Solution\Microservices\TwinWorXApiGateway\appsettings.json'
$TwinWorXDTPath = 'C:\TwinWorX-Solution\Microservices\TwinWorXDT\appsettings.json'
$TwinWorXPFServicePath = 'C:\TwinWorX-Solution\Microservices\TwinWorXPlatformServiceBus\appsettings.json'
$TwinWorXLoggingServicePath = 'C:\TwinWorX-Solution\Microservices\TwinWorXLoggingService\appsettings.json'
$TwinWorXUserManagementPath = 'C:\TwinWorX-Solution\Microservices\TwinWorXUserManagement\appsettings.json'
$TwinWorXFDD = 'C:\TwinWorX-Solution\Microservices\TwinWorXFDD\appsettings.json'
$TwinWorXAdvanceAlarmingService = 'C:\TwinWorX-Solution\Microservices\TwinWorxAdvanceAlarmingService\appsettings.json'
$TwinWorXSchedulerService = 'C:\TwinWorX-Solution\Microservices\TwinWorXSchedulerService\appsettings.json'
$TwinWorXADTService = 'C:\TwinWorX-Solution\Microservices\TwinWorxADTService\appsettings.json'
$TwinWorXVariableManagementService = 'C:\TwinWorX-Solution\Microservices\TwinWorXVariableManagementService\appsettings.json'
$TwinWorXCommandingService = 'C:\TwinWorX-Solution\Microservices\TwinWorXCommandingService\appsettings.json'
$ConfigurationPortal='C:\TwinWorX-Solution\ConfigurationPortal\appsettings.json'
$ConfigurationPortalSettings='C:\TwinWorX-Solution\ConfigurationPortal\portalConfigurationSettings.json'
$TwinWorXSchedulerExecution ='C:\TwinWorX-Solution\Utilities\TwinWorXSchedulerExecution\appsettings.json'
$TwinWorXHistorianArchiveWinService='C:\TwinWorX-Solution\WindowServices\TwinWorXHistorianArchiveWinService\appsettings.json'
#-------------------------------------Change appsetting-------------------------------
#-------------------------------------TwinWorXServiceRegistery------------------------
(Get-Content $TwinWorXServiceRegisteryPath).replace('{host}',$postgreHost) | Set-Content $TwinWorXServiceRegisteryPath
(Get-Content $TwinWorXServiceRegisteryPath).replace('{username}',$postgreUserName) | Set-Content $TwinWorXServiceRegisteryPath
(Get-Content $TwinWorXServiceRegisteryPath).replace('{password}',$postgrePassword) | Set-Content $TwinWorXServiceRegisteryPath

#-------------------------------------TwinWorXDataAccessService------------------------
(Get-Content $TwinWorXDataAccessServicePath).replace('{constring}',$iotHubConString) | Set-Content $TwinWorXDataAccessServicePath 
(Get-Content $TwinWorXDataAccessServicePath).replace('{deviceid}',$deviceId) | Set-Content $TwinWorXDataAccessServicePath

#-------------------------------------TwinWorxDataAlarmingService------------------------
(Get-Content $TwinWorxDataAlarmingServicePath).replace('{host}',$postgreHost) | Set-Content $TwinWorxDataAlarmingServicePath
(Get-Content $TwinWorxDataAlarmingServicePath).replace('{username}',$postgreUserName) | Set-Content $TwinWorxDataAlarmingServicePath
(Get-Content $TwinWorxDataAlarmingServicePath).replace('{password}',$postgrePassword) | Set-Content $TwinWorxDataAlarmingServicePath
(Get-Content $TwinWorxDataAlarmingServicePath).replace('{to}',$userEmail) | Set-Content $TwinWorxDataAlarmingServicePath
(Get-Content $TwinWorxDataAlarmingServicePath).replace('{useremail}',$userEmail) | Set-Content $TwinWorxDataAlarmingServicePath
(Get-Content $TwinWorxDataAlarmingServicePath).replace('{emailpassword}',$userPassword) | Set-Content $TwinWorxDataAlarmingServicePath

#-------------------------------------TwinWorXHistoricalDataAccessService------------------------
(Get-Content $TwinWorXHistoricalDataAccessServicePath).replace('{host}',$postgreHost) | Set-Content $TwinWorXHistoricalDataAccessServicePath
(Get-Content $TwinWorXHistoricalDataAccessServicePath).replace('{username}',$postgreUserName) | Set-Content $TwinWorXHistoricalDataAccessServicePath
(Get-Content $TwinWorXHistoricalDataAccessServicePath).replace('{password}',$postgrePassword) | Set-Content $TwinWorXHistoricalDataAccessServicePath
(Get-Content $TwinWorXHistoricalDataAccessServicePath).replace('{blobstrgconstring}',$blobstrgconstring) | Set-Content $TwinWorXHistoricalDataAccessServicePath
(Get-Content $TwinWorXHistoricalDataAccessServicePath).replace('{twxusername}',$loginUsername) | Set-Content $TwinWorXHistoricalDataAccessServicePath
(Get-Content $TwinWorXHistoricalDataAccessServicePath).replace('{twxpassword}',$loginPassword) | Set-Content $TwinWorXHistoricalDataAccessServicePath

#-------------------------------------TwinWorXAlarmingLoggerService------------------------
(Get-Content $TwinWorXAlarmingLoggerServicePath).replace('{host}',$postgreHost) | Set-Content $TwinWorXAlarmingLoggerServicePath
(Get-Content $TwinWorXAlarmingLoggerServicePath).replace('{username}',$postgreUserName) | Set-Content $TwinWorXAlarmingLoggerServicePath
(Get-Content $TwinWorXAlarmingLoggerServicePath).replace('{password}',$postgrePassword) | Set-Content $TwinWorXAlarmingLoggerServicePath

#-------------------------------------TwinWorXApiGateway-------------------------
(Get-Content $TwinWorXApiGatewayPath).replace('{useremail}',$userEmail) | Set-Content $TwinWorXApiGatewayPath
(Get-Content $TwinWorXApiGatewayPath).replace('{emailpassword}',$userPassword) | Set-Content $TwinWorXApiGatewayPath
(Get-Content $TwinWorXApiGatewayPath).replace('{clienturl}',$ConfigurationPortalUrl) | Set-Content $TwinWorXApiGatewayPath
(Get-Content $TwinWorXApiGatewayPath).replace('{host}',$postgreHost) | Set-Content $TwinWorXApiGatewayPath
(Get-Content $TwinWorXApiGatewayPath).replace('{username}',$postgreUserName) | Set-Content $TwinWorXApiGatewayPath
(Get-Content $TwinWorXApiGatewayPath).replace('{password}',$postgrePassword) | Set-Content $TwinWorXApiGatewayPath

#-------------------------------------TwinWorXDT----------------------------------------------------
(Get-Content $TwinWorXDTPath).replace('{cgp}',$ConsumerGroup) | Set-Content $TwinWorXDTPath
(Get-Content $TwinWorXDTPath).replace('{eventhubconstring}',$eventHubConnectionString) | Set-Content $TwinWorXDTPath
(Get-Content $TwinWorXDTPath).replace('{eventhubname}',$eventhubname) | Set-Content $TwinWorXDTPath
(Get-Content $TwinWorXDTPath).replace('{blobstrgconstring}',$blobstrgconstring) | Set-Content $TwinWorXDTPath

(Get-Content $TwinWorXDTPath).replace('{host}',$postgreHost) | Set-Content $TwinWorXDTPath
(Get-Content $TwinWorXDTPath).replace('{username}',$postgreUserName) | Set-Content $TwinWorXDTPath
(Get-Content $TwinWorXDTPath).replace('{password}',$postgrePassword) | Set-Content $TwinWorXDTPath

#-------------------------------------TwinWorXLoggingService----------------------------------------------------
(Get-Content $TwinWorXLoggingServicePath).replace('{host}',$postgreHost) | Set-Content $TwinWorXLoggingServicePath
(Get-Content $TwinWorXLoggingServicePath).replace('{username}',$postgreUserName) | Set-Content $TwinWorXLoggingServicePath
(Get-Content $TwinWorXLoggingServicePath).replace('{password}',$postgrePassword) | Set-Content $TwinWorXLoggingServicePath

(Get-Content $TwinWorXLoggingServicePath).replace('{blobstrgconstring}',$blobstrgconstring) | Set-Content $TwinWorXLoggingServicePath

#-------------------------------------TwinWorXUserManagement----------------------------------------------------
(Get-Content $TwinWorXUserManagementPath).replace('{host}',$postgreHost) | Set-Content $TwinWorXUserManagementPath
(Get-Content $TwinWorXUserManagementPath).replace('{username}',$postgreUserName) | Set-Content $TwinWorXUserManagementPath
(Get-Content $TwinWorXUserManagementPath).replace('{password}',$postgrePassword) | Set-Content $TwinWorXUserManagementPath

#-------------------------------------TwinWorXFDD---------------------------------------------
(Get-Content $TwinWorXFDD).replace('{username}',$loginUsername) | Set-Content $TwinWorXFDD
(Get-Content $TwinWorXFDD).replace('{password}',$loginPassword) | Set-Content $TwinWorXFDD

#-------------------------------------TwinWorxAdvanceAlarmingService-------------------------------
(Get-Content $TwinWorXAdvanceAlarmingService).replace('{host}',$postgreHost) | Set-Content $TwinWorXAdvanceAlarmingService
(Get-Content $TwinWorXAdvanceAlarmingService).replace('{username}',$postgreUserName) | Set-Content $TwinWorXAdvanceAlarmingService
(Get-Content $TwinWorXAdvanceAlarmingService).replace('{password}',$postgrePassword) | Set-Content $TwinWorXAdvanceAlarmingService
(Get-Content $TwinWorXAdvanceAlarmingService).replace('{to}',$userEmail) | Set-Content $TwinWorXAdvanceAlarmingService
(Get-Content $TwinWorXAdvanceAlarmingService).replace('{useremail}',$userEmail) | Set-Content $TwinWorXAdvanceAlarmingService
(Get-Content $TwinWorXAdvanceAlarmingService).replace('{emailpassword}',$userPassword) | Set-Content $TwinWorXAdvanceAlarmingService
(Get-Content $TwinWorXAdvanceAlarmingService).replace('{twxusername}',$loginUsername) | Set-Content $TwinWorXAdvanceAlarmingService
(Get-Content $TwinWorXAdvanceAlarmingService).replace('{twxpassword}',$loginPassword) | Set-Content $TwinWorXAdvanceAlarmingService

#-------------------------------------TwinWorXSchedulerService-------------------------------
(Get-Content $TwinWorXSchedulerService).replace('{host}',$postgreHost) | Set-Content $TwinWorXSchedulerService
(Get-Content $TwinWorXSchedulerService).replace('{username}',$postgreUserName) | Set-Content $TwinWorXSchedulerService
(Get-Content $TwinWorXSchedulerService).replace('{password}',$postgrePassword) | Set-Content $TwinWorXSchedulerService

(Get-Content $TwinWorXSchedulerService).replace('{clienturl}',$ConfigurationPortalUrl) | Set-Content $TwinWorXSchedulerService

#-------------------------------------TwinWorXADTService-------------------------------
(Get-Content $TwinWorXADTService).replace('{hosturl}',$digitalTwinHostUrl) | Set-Content $TwinWorXADTService
(Get-Content $TwinWorXADTService).replace('{hostname}',$digitalTwinHostName) | Set-Content $TwinWorXADTService

(Get-Content $TwinWorXADTService).replace('{host}',$postgreHost) | Set-Content $TwinWorXADTService
(Get-Content $TwinWorXADTService).replace('{username}',$postgreUserName) | Set-Content $TwinWorXADTService
(Get-Content $TwinWorXADTService).replace('{password}',$postgrePassword) | Set-Content $TwinWorXADTService

#-------------------------------------TwinWorXVariableManagementService-------------------------------
(Get-Content $TwinWorXVariableManagementService).replace('{host}',$postgreHost) | Set-Content $TwinWorXVariableManagementService
(Get-Content $TwinWorXVariableManagementService).replace('{username}',$postgreUserName) | Set-Content $TwinWorXVariableManagementService
(Get-Content $TwinWorXVariableManagementService).replace('{password}',$postgrePassword) | Set-Content $TwinWorXVariableManagementService

#-------------------------------------TwinWorXCommandingService-------------------------------
(Get-Content $TwinWorXCommandingService).replace('{host}',$postgreHost) | Set-Content $TwinWorXCommandingService
(Get-Content $TwinWorXCommandingService).replace('{username}',$postgreUserName) | Set-Content $TwinWorXCommandingService
(Get-Content $TwinWorXCommandingService).replace('{password}',$postgrePassword) | Set-Content $TwinWorXCommandingService

#---------------------------------------ConfigurationPortal------------------------------------------------
(Get-Content $ConfigurationPortal).replace('{vmname}',$vmName) | Set-Content $ConfigurationPortal

(Get-Content $ConfigurationPortalSettings).replace('{vmname}',$vmName) | Set-Content $ConfigurationPortalSettings
(Get-Content $ConfigurationPortalSettings).replace('{apigatewayurl}',$ApiGatewayUrl) | Set-Content $ConfigurationPortalSettings

#---------------------------------------TwinWorXSchedulerExecution-----------------------------
(Get-Content $TwinWorXSchedulerExecution).replace('{username}',$loginUsername) | Set-Content $TwinWorXSchedulerExecution
(Get-Content $TwinWorXSchedulerExecution).replace('{password}',$loginPassword) | Set-Content $TwinWorXSchedulerExecution

#---------------------------------------TwinWorXHistorianArchiveWinService-----------------------------
(Get-Content $TwinWorXHistorianArchiveWinService).replace('{host}',$postgreHost) | Set-Content $TwinWorXHistorianArchiveWinService
(Get-Content $TwinWorXHistorianArchiveWinService).replace('{username}',$postgreUserName) | Set-Content $TwinWorXHistorianArchiveWinService
(Get-Content $TwinWorXHistorianArchiveWinService).replace('{password}',$postgrePassword) | Set-Content $TwinWorXHistorianArchiveWinService

(Get-Content $TwinWorXHistorianArchiveWinService).replace('{blobstrgconstring}',$blobstrgconstring) | Set-Content $TwinWorXHistorianArchiveWinService

#------------------------------------------------------------------------------
 Start-Sleep -s 5

 $exePath = "C:\TwinWorX-Solution\Utilities\TwinWorXCryptography\TwinWorXCryptography.exe"
 $arguments = "encrypt"

 #Start-Process -FilePath $exePath -ArgumentList $arguments -Wait

 # Start the process with redirected input
 $processStartInfo = New-Object System.Diagnostics.ProcessStartInfo
 $processStartInfo.FileName = $exePath
 $processStartInfo.Arguments = $arguments
 $processStartInfo.UseShellExecute = $false
 $processStartInfo.RedirectStandardInput = $true
 $processStartInfo.RedirectStandardOutput = $true
 $processStartInfo.RedirectStandardError = $true
 $processStartInfo.CreateNoWindow = $true
 
 $process = New-Object System.Diagnostics.Process
 $process.StartInfo = $processStartInfo
 
 $process.Start() | Out-Null
 
 # Send Enter key to the standard input stream
 $process.StandardInput.WriteLine("`r")
 
 # Wait for the process to complete
 $process.WaitForExit()
 
 # Close the process
 $process.Close()
#---------------------------------------------Firewall-----------------------------------------------------
Import-Module NetSecurity
New-NetFirewallRule -DisplayName "twxcustomRule" -Direction Inbound -LocalPort Any -Protocol TCP -Action Allow

#-----------------------------------------Start Service-------------------------------------------
Start-Service -Name "W3SVC"
Start-Service -Name "WAS"
Start-Service -Name "MSSQL`$SQLEXPRESS"

# Specify the service name
$serviceName = "TwinWorXSrcManager"

# Get the service
$service = Get-Service -Name $serviceName

$service.ExecuteCommand(128)
Start-Service -Name "TwinWorXHistorianArchiveWinService"
#------------------------------------------------------------------------------




