Function Import-MDTModule {
    $MDTModuleInstallLocation = "C:\Program Files\Microsoft Deployment Toolkit\Bin\MicrosoftDeploymentToolkit.psd1"
    if (!(Get-Module MicrosoftDeploymentToolkit)) {
        if (Test-Path $MDTModuleInstallLocation) {
            Import-Module $MDTModuleInstallLocation
        } else {
            Write-Error "MDT module not working. Microsoft Deployment Toolkit may need to be installed."
        }
    }
    $return = Get-Module MicrosoftDeploymentToolkit
    return $return
}

Function Get-MDTDrive {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]    
        $Name
    )
    PROCESS{
        if(Import-MDTModule) {
            $drive = Get-PSDrive -Name $Name -PSProvider MDTProvider
            return $drive
        }
    }
}

Function Set-MDTDrive {
    [cmdletbinding(
        SupportsShouldProcess=$true
    )]
    param(
        [Parameter(Mandatory=$true)]
        $Name,
        [Parameter(Mandatory=$true)]
        $Path,
        [Parameter()]
        [switch]$Force
    )
    BEGIN {
        $mdtdrive = Get-MDTDrive -Name $Name -ErrorAction:SilentlyContinue
        if (Import-MDTModule) {
            if ($mdtdrive) {
                Write-Verbose "$Name already exists"
                if ($Force) {
                    if ($PSCmdlet.ShouldProcess($env:COMPUTERNAME,"Creating MDT drive $Name with path $Path")) {
                        Write-Verbose "Force switch specified. Overwriting drive $Name"
                        New-PSDrive -Name $Name -PSProvider MDTProvider -Root $Path -NetworkPath $Path -Scope Global
                    }
                }
            } elseif (!($mdtdrive)) {
                if ($PSCmdlet.ShouldProcess($env:COMPUTERNAME,"Creating MDT drive $Name with path $Path")) {
                    Write-Verbose "Creating new drive: $Name : $Path"
                    New-PSDrive -Name $Name -PSProvider MDTProvider -Root $Path -NetworkPath $Path -Scope Global
                }
            }
        }
    }
}

Function Get-MDTApplication {
    [cmdletbinding()]
    param(
        [Parameter(Mandatory=$true)]
        [Parameter(ParameterSetName='NoFilter')]
        [Parameter(ParameterSetName='NameFilter')]
        [Parameter(ParameterSetName='GUIDFilter')]
        $ShareName,
        [Parameter(ParameterSetName='NoFilter')]
        [Parameter(ParameterSetName='NameFilter')]
        [Parameter(ParameterSetName='GUIDFilter')]
        $Location,
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   ParameterSetName='NameFilter')]
        $Name,
        [Parameter(
                   Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   ParameterSetName='GUIDFilter')]
        $GUID
    )
    BEGIN {
        $mdtdriveworking = Get-MDTDrive -Name $ShareName
        if ($mdtdriveworking) {
            if ($null -eq $location) {
                $getchilditemquery = Get-ChildItem -Path $ShareName`:\Applications -Recurse | Where-Object {$_.NodeType -eq "Application"}
            } else {
                $getchilditemquery = Get-ChildItem -Path $ShareName`:\Applications\$location -Recurse | Where-Object {$_.NodeType -eq "Application"}
            }
        }
    }
    PROCESS {
        if ($mdtdriveworking) {
            switch ($PSCmdlet.ParameterSetName) {
                "NameFilter" {
                    $appobject = $getchilditemquery | Where-Object {$_.Name -like $Name}
                    Write-Output $appobject
                }
                "GUIDFilter" {
                    if($GUID -notmatch "{*}") {
                        $GUID = ("{" + $GUID + "}")
                    }
                    $appobject = $getchilditemquery | Where-Object {$_.GUID -like $GUID}
                    Write-Output $appobject
                }
                "NoFilter" {
                    Write-Output $getchilditemquery
                }
            }
        }
    }
}

Function Get-MDTApplicationDependency {
    [cmdletbinding()]
    param(
        [Parameter(Mandatory=$true)]
        [Parameter(ParameterSetName='NameFilter')]
        [Parameter(ParameterSetName='GUIDFilter')]
        $ShareName,
        [Parameter(ParameterSetName='NameFilter')]
        [Parameter(ParameterSetName='GUIDFilter')]
        [ValidateSet("ReturnParent","ReturnChild")]
        $DependencyType = "ReturnParent",
        [Parameter(ParameterSetName='NameFilter')]
        [Parameter(ParameterSetName='GUIDFilter')]
        [switch]$Recurse,
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   ParameterSetName='NameFilter')]
        $Name,
        [Parameter(
                   Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   ParameterSetName='GUIDFilter')]
        $GUID
    )
    BEGIN {
        switch ($PSCmdlet.ParameterSetName) {
            "NameFilter" {
                $sourceapp = Get-MDTApplication -ShareName $ShareName -Name $Name
            }
            "GUIDFilter" {
                if($GUID -notmatch "{*}") {
                    $GUID = ("{" + $GUID + "}")
                }
                $sourceapp = Get-MDTApplication -ShareName $ShareName -GUID $GUID
            }
        }
        if ($DependencyType -eq "ReturnChild") {
            $allapplications = Get-MDTApplication -ShareName $ShareName
        }
    }
    PROCESS {
        switch ($DependencyType) {
            "ReturnParent" {
                foreach ($app in $sourceapp.dependency) {
                    $appobject = Get-MDTApplication -ShareName $ShareName -GUID $app | Add-Member NoteProperty ParentDependency($sourceapp.Name) -PassThru
                    $appobject.PSObject.TypeNames.Insert(0,'Microsoft.BDD.PSSnapIn.MDTObject.MDTApplicationTools.ApplicationDependency.ParentDependency')
                    Write-Output $appobject
                    if ($Recurse -and $appobject.dependency) {
                        Get-MDTApplicationDependency -ShareName $ShareName -GUID $app -DependencyType ReturnParent -Recurse
                    }
                }
            }
            "ReturnChild" {
                foreach ($app in $allapplications) {
                    if ($app.Dependency -contains $sourceapp.guid) {
                        $appobject = Get-MDTApplication -ShareName $ShareName -GUID $app.guid | Add-Member NoteProperty ChildDependency($sourceapp.Name) -PassThru
                        $appobject.PSObject.TypeNames.Insert(0,'Microsoft.BDD.PSSnapIn.MDTObject.MDTApplicationTools.ApplicationDependency.ChildDependency')
                        Write-Output $appobject
                        if ($Recurse -and $appobject.dependency) {
                            Get-MDTApplicationDependency -ShareName $ShareName -GUID $app.guid -DependencyType ReturnChild -Recurse
                        }
                    }
                }
            }
        }
    }
}

Function Get-MDTApplicationSupportedPlatform {
    [cmdletbinding()]
    param(
        [Parameter(Mandatory=$true)]
        [Parameter(ParameterSetName='NoFilter')]
        [Parameter(ParameterSetName='NameFilter')]
        [Parameter(ParameterSetName='GUIDFilter')]
        $ShareName,
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   ParameterSetName='NameFilter')]
        $Name,
        [Parameter(
                   Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   ParameterSetName='GUIDFilter')]
        $GUID,
        [ValidateSet("Yes", "No", "All")]
        $SupportedPlatformSet = "All"
    )
    PROCESS {
        switch ($PSCmdlet.ParameterSetName) {
            "NoFilter" {
                $basequery = Get-MDTApplication -ShareName $ShareName
                switch ($SupportedPlatformSet) {
                    "Yes" {$appobject = $basequery | Where-Object {$_.SupportedPlatform -like "*"}}
                    "No" {$appobject = $basequery | Where-Object {[string]$_.SupportedPlatform -like ""}}
                    "All" {$appobject = $basequery}
                }
                $appobject.PSObject.TypeNames.Insert(0,'Microsoft.BDD.PSSnapIn.MDTObject.MDTApplicationTools.SupportedPlatform')
                Write-Output $appobject
            }
            "NameFilter" {
                $basequery = Get-MDTApplication -ShareName $ShareName -Name $Name 
                switch ($SupportedPlatformSet) {
                    "Yes" {$appobject = $basequery | Where-Object {$_.SupportedPlatform -like "*"}}
                    "No" {$appobject = $basequery | Where-Object {[string]$_.SupportedPlatform -like ""}}
                    "All" {$appobject = $basequery}
                }
                $appobject.PSObject.TypeNames.Insert(0,'Microsoft.BDD.PSSnapIn.MDTObject.MDTApplicationTools.SupportedPlatform')
                Write-Output $appobject
            }
            "GUIDFilter" {
                if($GUID -notmatch "{*}") {
                    $GUID = ("{" + $GUID + "}")
                }
                $basequery = Get-MDTApplication -ShareName $ShareName -GUID $GUID
                switch ($SupportedPlatformSet) {
                    "Yes" {$appobject = $basequery | Where-Object {$_.SupportedPlatform -like "*"}}
                    "No" {$appobject = $basequery | Where-Object {[string]$_.SupportedPlatform -like ""}}
                    "All" {$appobject = $basequery}
                }
                $appobject.PSObject.TypeNames.Insert(0,'Microsoft.BDD.PSSnapIn.MDTObject.MDTApplicationTools.SupportedPlatform')
                Write-Output $appobject
            }
        }
    }
}

Function Set-MDTApplicationSupportedPlatform {
    [cmdletbinding(
        SupportsShouldProcess=$true,
        ConfirmImpact="High"
    )]
    param(
        [Parameter(Mandatory=$true)]
        [Parameter(ParameterSetName='NoFilter')]
        [Parameter(ParameterSetName='NameFilter')]
        [Parameter(ParameterSetName='GUIDFilter')]
        $ShareName,
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   ParameterSetName='NameFilter')]
        $Name,
        [Parameter(
                   Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   ParameterSetName='GUIDFilter')]
        $GUID,
        [Parameter(Mandatory=$true)]
        [Parameter(ParameterSetName='NoFilter')]
        [Parameter(ParameterSetName='NameFilter')]
        [Parameter(ParameterSetName='GUIDFilter')]
        [ValidateSet("Null", "Windows7Only", "Windows8Only", "Windows8.1Only", "Windows10Only")]
        $SetSupportedPlatformTo
    )
    BEGIN {
        Switch ($SetSupportedPlatformTo) {
            "Null" {$code = @()}
            "Windows7Only" {$code = @('All x86 Windows 7 Client', 'All x64 Windows 7 Client')}
            "Windows8Only" {$code = @('All x86 Windows 8 Client', 'All x64 Windows 8 Client')}
            "Windows8.1Only" {$code = @('All x86 Windows 8.1 Client', 'All x64 Windows 8.1 Client') }
            "Windows10Only" {$code = @('All x86 Windows 10 Client', 'All x64 Windows 10 Client') }
        }
    }
    PROCESS {
        switch ($PSCmdlet.ParameterSetName) {
            "NoFilter" {
                $app = Get-MDTApplication -ShareName $ShareName
                if ($PSCmdlet.ShouldProcess($ShareName,"Setting Supported Platform to $SetSupportedPlatformTo on all applications")) {
                    $appobject = $app | ForEach-Object  {Set-ItemProperty -Path ([string]$_.PsPath -replace 'MicrosoftDeploymentToolkit\\MDTProvider::',"") -Name SupportedPlatform -Value $code}
                    $appobject.PSObject.TypeNames.Insert(0,'Microsoft.BDD.PSSnapIn.MDTObject.MDTApplicationTools.SupportedPlatform')
                    Write-Output $appobject
                }
            }
            "NameFilter" {
                $app = Get-MDTApplication -ShareName $ShareName -Name $Name
                $appname = $app.Name
                if ($PSCmdlet.ShouldProcess($ShareName,"Setting Supported Platform to $SetSupportedPlatformTo on $appname")) {
                    $appobject = $app | ForEach-Object {Set-ItemProperty -Path ([string]$_.PsPath -replace 'MicrosoftDeploymentToolkit\\MDTProvider::',"") -Name SupportedPlatform -Value $code}
                    $appobject.PSObject.TypeNames.Insert(0,'Microsoft.BDD.PSSnapIn.MDTObject.MDTApplicationTools.SupportedPlatform')
                    Write-Output $appobject
                }
            }
            "GUIDFilter" {
                if($GUID -notmatch "{*}") {
                    $GUID = ("{" + $GUID + "}")
                }
                $app = Get-MDTApplication -ShareName $ShareName -GUID $GUID
                $appname = $app.Name
                if ($PSCmdlet.ShouldProcess($ShareName,"Setting Supported Platform to $SetSupportedPlatformTo on $appname")) {
                    $appobject = $app | ForEach-Object  {Set-ItemProperty -Path ([string]$_.PsPath -replace 'MicrosoftDeploymentToolkit\\MDTProvider::',"") -Name SupportedPlatform -Value $code}
                    $appobject.PSObject.TypeNames.Insert(0,'Microsoft.BDD.PSSnapIn.MDTObject.MDTApplicationTools.SupportedPlatform')
                    Write-Output $appobject
                }
            }
        }
    }
}

Function Find-MDTApplicationContent {
    [cmdletbinding()]
    param(
        [Parameter(Mandatory=$true)]
        $ShareName,
        $String,
        [switch]$ParseScript

    )
    BEGIN {
        $apps = Get-MDTApplication -ShareName $ShareName
        $filetypes = @(".bat",".cmd",".vbs",".wsf",".ps1",".psm1",".psd1")
        $sharepath = (Get-PSDrive -Name $ShareName).Root
    }
    PROCESS {
        if($ParseScript) {
            foreach ($app in $apps) {   #goes through all apps in share
                if ($app.Source -notlike $null) {   #makes sure app has files to search for
                    $apppath = ($app.Source.ToString()).substring(1)
                    $apppath = "$sharepath$apppath"
                    if (Test-Path $apppath) {   #makes sure apppath exists
                        $appcontents = Get-ChildItem -Path $apppath #gets list of files in $apppath
                        foreach ($item in $appcontents) {   #goes through each item in $apppath
                            $itemfound = $false
                            $lineobj = @()
                            foreach ($filetype in $filetypes) {
                                if ($item -like "*$filetype*") {    #selects only items with filetype defined in $filetypes
                                    $itemcontent = Get-Content -Path $item.FullName #gets content of item
                                    foreach ($line in $itemcontent) {   #goes through each line in item content,
                                        if ($line -like $String) {  #and outputs if string matches
                                            $itemfound = $true
                                            $line  = $line.ReadCount.ToString() + ': ' + $line.Trim()   #prepends the line number to the beginning of the found string
                                            $lineobj += $line
                                        }
                                    }
                                    if ($itemfound) {
                                        $app.PSObject.TypeNames.Insert(0,'Microsoft.BDD.PSSnapIn.MDTObject.MDTApplicationTools.ApplicationContent.ParseScript')
                                        $app = $app | Add-Member NoteProperty Script($item) -PassThru| Add-Member NoteProperty LinesFound($lineobj) -PassThru
                                        Write-Output $app
                                    }
                                }
                            }
                        }
                    }
                }
            }
        } else {
            $app = Get-MDTApplication -ShareName $ShareName | Where-Object {$_.CommandLine -like "$String"}
            $app.PSObject.TypeNames.Insert(0,'Microsoft.BDD.PSSnapIn.MDTObject.MDTApplicationTools.ApplicationContent.InstallCmd')
            Write-Output $app

        }
    }
}

function Rename-MDTApplication {
    [cmdletbinding(
        SupportsShouldProcess=$true,
        ConfirmImpact="High"
    )]
    param(
        [Parameter(Mandatory=$true)]
        [Parameter(ParameterSetName='NameFilter')]
        [Parameter(ParameterSetName='GUIDFilter')]
        $ShareName,
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   ParameterSetName='NameFilter')]
        $Name,
        [Parameter(
                   Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   ParameterSetName='GUIDFilter')]
        $GUID,
        [Parameter(Mandatory=$true)]
        [Parameter(ParameterSetName='NameFilter')]
        [Parameter(ParameterSetName='GUIDFilter')]
        $NewName,
        [Parameter(ParameterSetName='NameFilter')]
        [Parameter(ParameterSetName='GUIDFilter')]
        [switch]$RenameSource,
        [Parameter(ParameterSetName='NameFilter')]
        [Parameter(ParameterSetName='GUIDFilter')]
        [switch]$Force
    )
    PROCESS {
        $prevappcheck = Get-MDTApplication -ShareName $ShareName -Name $NewName
        if(!$prevappcheck -or $Force) {
            switch ($PSCmdlet.ParameterSetName) {
                "NameFilter" {
                    $app = Get-MDTApplication -ShareName $ShareName -Name $Name
                }
                "GUIDFilter" {
                    if($GUID -notmatch "{*}") {
                        $GUID = ("{" + $GUID + "}")
                    }
                    $app = Get-MDTApplication -ShareName $ShareName -GUID $GUID
                }
            }
            if($app -or $Force){
                $appname = $app.Name                                                               #variable needed to display name in shouldprocess statements
                $apppath = ([string]$app.PsPath -split "::")[1]                                    #path used for set-itemproperty statements
                if ($app.CommandLine -notlike "") {
                    if ($app.Source -notlike "") {
                        $apptype =  "APPSOURCE"
                    } else {
                        $apptype = "APPNOSOURCE"
                    }
                } else {
                    $apptype = "APPBUNDLE"
                }
                if ($RenameSource -eq $false -or $apptype -eq "APPBUNDLE" -or $apptype -eq "APPNOSOURCE") {
                    if ($PSCmdlet.ShouldProcess($ShareName,"Renaming $appname to $NewName")) {
                        Set-ItemProperty -Path $apppath -Name ShortName -Value $NewName
                        Set-ItemProperty -Path $apppath -Name Name -Value $NewName
                    }
                } else {
                    $mdtdriveroot = Get-PSDrive -Name $ShareName | Select-Object -ExpandProperty Root
                    $origfullpath = $mdtdriveroot + $app.Source.TrimStart(".")
                    $oldsourcename = $app.Source.split("\") | Select-Object -Last 1
                    $newsourcepath = $app.Source.Replace($oldsourcename,$NewName)                   #path used when changing source path property
                    if ($PSCmdlet.ShouldProcess($ShareName,"Renaming $appname to $NewName, and renaming source directory from $oldsourcename to $NewName")) {
                        try {
                            Rename-Item -Path $origfullpath -NewName $NewName -ErrorAction Stop
                            Set-ItemProperty -Path $apppath -Name Source -Value $newsourcepath
                            Set-ItemProperty -Path $apppath -Name WorkingDirectory -Value $newsourcepath
                            Set-ItemProperty -Path $apppath -Name ShortName -Value $NewName
                            Set-ItemProperty -Path $apppath -Name Name -Value $NewName
                        } catch {
                            Write-Error "issue renaming directory. no changes have been made."
                        }
                    }
                }
            } else {
                switch ($PSCmdlet.ParameterSetName) {
                    "NameFilter" {
                        Write-Error "no app with Name $Name exists"
                    }
                    "GUIDFilter" {
                        if($GUID -notmatch "{*}") {
                            $GUID = ("{" + $GUID + "}")
                        }
                        Write-Error "no app with GUID $GUID exists"
                    }
                }
            }
        } else {
            Write-Error "An app with the name $NewName already exists"
        }
    }
}