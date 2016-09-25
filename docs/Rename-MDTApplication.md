---
external help file: MDTApplicationTools-help.xml
online version: https://github.com/JohnForet/MDTApplicationTools/blob/master/docs/Rename-MDTApplication.md
schema: 2.0.0
---

# Rename-MDTApplication
## SYNOPSIS
Renames an MDT application.

## SYNTAX

### GUIDFilter
```
Rename-MDTApplication [-ShareName <Object>] -GUID <Object> [-NewName <Object>] [-RenameSource] [-Force]
 [-WhatIf] [-Confirm]
```

### NameFilter
```
Rename-MDTApplication [-ShareName <Object>] -Name <Object> [-NewName <Object>] [-RenameSource] [-Force]
 [-WhatIf] [-Confirm]
```

## DESCRIPTION
The Rename-MDTApplication function renames an MDT application, optionally also renaming the source directory if the applications source files have been imported into MDT. Applications to be renamed can be specified by either their Name or their GUID.

## EXAMPLES

### Example 1: Rename an application
```
PS C:\> Rename-MDTApplication -ShareName MDTProduction -Name "APP1" -NewName "APP2"
```

Renames APP1 to APP2(changes the "Name" and "ShortName" attributes)
### Example 2: Rename an application, also renaming it's source directory
```
PS C:\> Rename-MDTApplication -ShareName MDTProduction -Name "APP1" -NewName "APP2" -RenameSource
```

Renames APP1 to APP2, also changing the source directory name from APP1 to APP2(changes the "Name", "ShortName", "Source", and "WorkingDirectory" attributes, also renaming the source directory itself)
### Example 3: Rename an application, also renaming it's source directory
```
PS C:\> Rename-MDTApplication -ShareName MDTProduction -Name "APP1" -NewName "APP2" -Force
```

Renames APP1 to APP2, with the Force parameter disabling the check to see if the application to be renamed exists in the MDT share, and also the check to see if the New Name is already in use by another MDT application. Use with caution.

## PARAMETERS

### -Confirm
The confirm preference. If left alone, will prompt you before modifying each application. If set to $false, it just goes through.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: $true
Accept pipeline input: False
Accept wildcard characters: False
```

### -Force
If specified, disables the checks to verify that 1: the app to be renamed exists and 2: that new name isn't already in use. Use carefully.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: $false
Accept pipeline input: False
Accept wildcard characters: False
```

### -GUID
Specifies the GUID of an application to query the MDT share for. Alternate to Name Parameter.

```yaml
Type: Object
Parameter Sets: GUIDFilter
Aliases:

Required: True
Position: Named
Default value:
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Name
Specifies the Name of an application to query the MDT share for. Alternate to GUID Parameter.

```yaml
Type: Object
Parameter Sets: NameFilter
Aliases:

Required: True
Position: Named
Default value:
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -NewName
Specifies what the new name of the application will be once renamed. Rename-MDTApplication will check the existing applications to make sure there are no duplicates before making any changes.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value:
Accept pipeline input: False
Accept wildcard characters: False
```

### -RenameSource
If specified, will also rename the actual application source folder inside of the MDT share. This parameter will only process if the application has it's source files located within the MDT share(the three MDT app types are "apps with source files", "apps with sources on network or elsewhere", and "app bundles". this parameter only processes the first of these three).

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: $false
Accept pipeline input: False
Accept wildcard characters: False
```

### -ShareName
Specifies the name of the MDT share to query. In order to query by name, the MDT share must be mounted using either New-PSDrive or Set-MDTDrive. Here are some examples that should get you up and running:

`PS C:\>New-PSDrive -Name MDTProduction -PSProvider MDTProvider -Root "\\FILESERVER\MDTProduction$" -NetworkPath "\\FILESERVER\MDTProduction$" -Scope Global`

or

`PS C:\>Set-MDTDrive -Name MDTProduction -Path "\\FILESERVER\MDTProduction$"`

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value:
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
If specified, will output what changes the command will make without making them.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value:
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

### System.Object


## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS
