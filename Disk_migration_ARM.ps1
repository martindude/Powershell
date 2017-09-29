#Provide the subscription Id of the subscription where managed disk exists
$sourceSubscriptionId='e7cb5307-03f2-4f3e-98bf-799d484d8a30'

#Provide the name of your resource group where managed disk exists
$sourceResourceGroupName='RG-EU'
$managedDiskName='srv-win-01_OsDisk_1_c61ada1bd1964658a291acf5aa5d0905'

#Set the context to the subscription Id where Managed Disk exists
Select-AzureRmSubscription -SubscriptionId $sourceSubscriptionId

#Get the source managed disk
$managedDisk= Get-AzureRMDisk -ResourceGroupName $sourceResourceGroupName -DiskName $managedDiskName

#Provide the subscription Id of the subscription where managed disk will be copied to
#If managed disk is copied to the same subscription then you can skip this step
$targetSubscriptionId='e7cb5307-03f2-4f3e-98bf-799d484d8a30'

#Name of the resource group where snapshot will be copied to
$targetResourceGroupName='RG'

#Set the context to the subscription Id where managed disk will be copied to
#If snapshot is copied to the same subscription then you can skip this step
Select-AzureRmSubscription -SubscriptionId $targetSubscriptionId

$diskConfig = New-AzureRmDiskConfig -SourceResourceId $managedDisk.Id -Location $managedDisk.Location -CreateOption Copy 

#Create a new managed disk in the target subscription and resource group
New-AzureRmDisk -Disk $diskConfig -DiskName $managedDiskName -ResourceGroupName $targetResourceGroupName