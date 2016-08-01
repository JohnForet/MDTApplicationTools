---
external help file: MDTApplicationTools-help.xml
online version: https://github.com/JohnForet/MDTApplicationTools/blob/master/docs/Set-MDTDrive.md
schema: 2.0.0
---

# Set-MDTDrive
## SYNOPSIS
Creates an MDT drive.

## SYNTAX

```
Set-MDTDrive [-Name] <Object> [-Path] <Object> [-Force] [-WhatIf] [-Confirm]
```

## DESCRIPTION
The Set-MDTDrive function creates an MDT drive using the MDTProvider for powershell. This function is actually just a wrapper for New-PSDrive with the MDTProvider. For example this:

`PS C:\>Set-MDTDrive -Name MDTProduction -Path "\\FILESERVER\MDTProduction$"`

 is actually the same command as this:

`PS C:\>New-PSDrive -Name MDTProduction -PSProvider MDTProvider -Root "\\FILESERVER\MDTProduction$" -NetworkPath "\\FILESERVER\MDTProduction$" -Scope Global`

## EXAMPLES

### Example 1: Create an MDT drive
```
PS C:\> Set-MDTDrive -Name MDTProduction -Path "\\FILESERVER\MDTProduction$"
```

Creates an MDT Drive with a name of `MDTProduction` and a path of `"\\FILESERVER\MDTProduction$"`
### Example 2: Create an MDT drive, overwriting previous drives
```
PS C:\> Set-MDTDrive -Name MDTProduction -Path "\\FILESERVER\MDTProduction$" -Force
```

Creates an MDT Drive with a name of `MDTProduction` and a path of `"\\FILESERVER\MDTProduction$"`, overwriting any previous drives with the name `MDTProduction`.
### Example 3: Shows what will happen if the command is run
```
PS C:\> Set-MDTDrive -Name MDTProduction -Path "\\FILESERVER\MDTProduction$" -WhatIf
```

Shows what will happen if you try to create an MDT Drive with a name of `MDTProduction` and a path of `"\\FILESERVER\MDTProduction$"`
## PARAMETERS

### -Confirm
The confirm preference. If left alone, will just let the command run as normal. If $true is specified, will prompt you before creating the drive.


```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value:
Accept pipeline input: False
Accept wildcard characters: False
```

### -Force
If specified, will create MDT drive even if one with same name already exists(in case one wants to create a drive of the same name with a different path)

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value:
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
Specifies what name you would like to give to the drive you want to create. This is the share name you'll reference later on when querying the share.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value:
Accept pipeline input: False
Accept wildcard characters: False
```

### -Path
{{Fill Path Description}}

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
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

### None


## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS
