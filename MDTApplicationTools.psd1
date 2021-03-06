@{

# Script module or binary module file associated with this manifest.
RootModule = '.\MDTApplicationTools.psm1'

# Version number of this module.
ModuleVersion = '1.0.8'

# ID used to uniquely identify this module
GUID = 'd166e393-9bd3-4986-83ac-15f3cbb76a86'

# Author of this module
Author = 'John Foret'

# Company or vendor of this module
CompanyName = 'John Foret'

# Copyright statement for this module
Copyright = '(c) 2016 John Foret. All rights reserved.'

# Description of the functionality provided by this module
Description = 'PowerShell module designed to add extended functionality to the querying and manipulation of MDT Applications'

# Format files (.ps1xml) to be loaded when importing this module
FormatsToProcess = '.\MDTApplicationTools.format.ps1xml'

# Functions to export from this module
FunctionsToExport = 'Set-MDTDrive','Get-MDTApplication','Get-MDTApplicationDependency','Get-MDTApplicationSupportedPlatform','Set-MDTApplicationSupportedPlatform','Find-MDTApplicationContent','Rename-MDTApplication'

# Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
PrivateData = @{

    PSData = @{

        # Tags applied to this module. These help with module discovery in online galleries.
        Tags = @('MDT', 'MicrosoftDeploymentToolkit')

        # A URL to the main website for this project.
        ProjectUri = 'https://github.com/JohnForet/MDTApplicationTools'

    } # End of PSData hashtable

} # End of PrivateData hashtable

}

