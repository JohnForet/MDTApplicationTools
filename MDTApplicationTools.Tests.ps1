Import-Module “C:\Program Files\Microsoft Deployment Toolkit\Bin\MicrosoftDeploymentToolkit.psd1”

$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$mdtdrivename = "TESTSHARE"
$mdtpath = "$here\$mdtdrivename"
$apppath  = $mdtdrivename + ":\Applications"

#creates test environment
New-Item -Path $mdtpath -ItemType directory
new-PSDrive -Name $mdtdrivename -PSProvider "MDTProvider" -Root $mdtpath -Description "MDT Test Share"  -Verbose | add-MDTPersistentDrive -Verbose
import-MDTApplication -path $apppath -enable "True" -Name "TESTAPP1" -ShortName "TESTAPP1" -Version "" -Publisher "" -Language "" -CommandLine "REPLACEME" -WorkingDirectory "" -NoSource -Verbose
$testapp1guid = Get-ItemPropertyValue -Path $apppath\TESTAPP1 -Name guid
import-MDTApplication -path $apppath -enable "True" -Name "TESTAPP2" -ShortName "TESTAPP2" -Version "" -Publisher "" -Language "" -CommandLine "REPLACEME" -WorkingDirectory "" -NoSource -Verbose -Dependency @($testapp1guid)
$testapp2guid = Get-ItemPropertyValue -Path $apppath\TESTAPP2 -Name guid
New-Item "$here\TESTAPP3" -ItemType Directory
New-Item "$here\TESTAPP3\install.cmd" -ItemType File -Value "pause"
import-MDTApplication -path $apppath -enable "True" -Name "TESTAPP3" -ShortName "TESTAPP3" -Version "" -Publisher "" -Language "" -CommandLine "install.cmd" -WorkingDirectory ".\Applications\TESTAPP3" -ApplicationSourcePath "$here\TESTAPP3" -DestinationFolder "TESTAPP3" -Move -Verbose
import-MDTApplication -path $apppath -enable "True" -Name "APPBUNDLE1" -ShortName "APPBUNDLE1" -Version "" -Publisher "" -Language "" -Bundle -Verbose

Import-Module $here\MDTApplicationTools.psd1

<#Describe "Import-MDTModule" {
    It "returns true if mdt module is installed" {
        Mock Get-Module {$true}
        Mock Test-Path {$true}
        Import-MDTModule
        {Import-MDTModule} | Should Not Throw
    }
    It "returns false if mdt module is not installed" {
        Mock Get-Module {$true}
        Import-MDTModule
        {Import-MDTModule} | Should Throw

    }

}#>

Describe "Get-MDTDrive" {
    It "returns mdtdrive object if installed" {
        (Get-MDTDrive -Name $mdtdrivename).Name | Should Be $mdtdrivename
    }
    It "does not error out if drive is found" {
        {Get-MDTDrive -Name $mdtdrivename -ErrorAction Stop} | Should Not Throw
    }
    It "throws error if no drive found" {
        {Get-MDTDrive -Name FAKE -ErrorAction Stop} | Should Throw
    }
}

Describe "Get-MDTApplication" {
    It "returns the application when searched by name" {
        (Get-MDTApplication -Name TESTAPP1 -ShareName $mdtdrivename).Name | Should Be TESTAPP1
    }
    It "returns the application when searched by GUID" {
        (Get-MDTApplication -GUID $testapp2guid -ShareName $mdtdrivename).Name | Should Be TESTAPP2
    }
<#    It "returns all applications when no app is specified" {
        (Get-MDTApplication -ShareName $mdtdrivename) | Should Be ('APPBUNDLE1','TESTAPP1','TESTAPP2')
    }#>
    It "throws an error when drive does not exist" {
        {Get-MDTApplication -ShareName NOTASHARE -ErrorAction Stop} | Should Throw
    }
}

Describe "Get-MDTApplicationDependency" {
    It "returns the applications dependencies when searched by name" {
        (Get-MDTApplicationDependency -Name TESTAPP2 -ShareName $mdtdrivename).Name | Should Be TESTAPP1
    }
    It "returns the applications dependencies when searched by GUID" {
        (Get-MDTApplicationDependency -GUID $testapp2guid -ShareName $mdtdrivename).Name | Should Be TESTAPP1
    }
    It "throws an error when no app is specified" {
        {Get-MDTApplicationDependency -ShareName $mdtdrivename} | Should Throw
    }
}


#removes test environment
Remove-MDTPersistentDrive -Name $mdtdrivename -Verbose
Remove-PSDrive -Name $mdtdrivename
Remove-Item -Path $mdtpath -Recurse -Force