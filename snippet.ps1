$vms = Get-VM
foreach($vm in $vms)
{
$vm | Select @{N='Host';E={$vm.VMhost.Name}},@{N='VMName';E={$vm.Name}},@{N='Datastore';E={$vm.ExtensionData.Datastore.GetValue(0).Value}},@{N='UsedSpaceGB';E={$vm.UsedSpaceGB}},@{N='ProvisionedSpaceGB';E={$vm.ProvisionedSpaceGB}},@{N='PowerState';E={$vm.PowerState}}
(Get-VIEvent -Entity $vm | Sort-Object -Property CreatedTime -Descending | Where-Object { $_.Gettype().Name -eq "VmPoweredOffEvent" }).CreatedTime
(Get-VIEvent -Entity $vm | Sort-Object -Property CreatedTime -Descending | Where-Object { $_.Gettype().Name -eq "VmPoweredOnEvent" }).CreatedTime
}