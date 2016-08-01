---
external help file: MDTApplicationTools-help.xml
online version: https://github.com/JohnForet/MDTApplicationTools/blob/master/docs/Set-MDTApplicationSupportedPlatform.md
schema: 2.0.0
---

# Set-MDTApplicationSupportedPlatform
## SYNOPSIS
Sets the SupportedPlatform attribute of or more MDT applications

## SYNTAX

### GUIDFilter
```
Set-MDTApplicationSupportedPlatform [-ShareName <Object>] -GUID <Object> [-SetSupportedPlatformTo <Object>]
 [-WhatIf] [-Confirm]
```

### NameFilter
```
Set-MDTApplicationSupportedPlatform [-ShareName <Object>] -Name <Object> [-SetSupportedPlatformTo <Object>]
 [-WhatIf] [-Confirm]
```

### NoFilter
```
Set-MDTApplicationSupportedPlatform [-ShareName <Object>] [-SetSupportedPlatformTo <Object>] [-WhatIf]
 [-Confirm]
```

## DESCRIPTION
The Set-MDTApplicationSupportedPlatform function sets the SupportedPlatform attribute on one or more MDT applications. It can either set the attribute to Null, or can set it to one of the predefined OS's. The OS restriction types are a bit more granular when setting this attribute via MDT's GUI, so due to the complexity behind scripting each one, broader "catch-all" types are used. At the moment this tool also disregards any previous settings of the attribute, so any previous settings will be overwritten with the new data specified by the command.

## EXAMPLES

### Example 1: Remove OS restriction for ALL applications in MDT Share
```
PS C:\> Set-MDTApplicationSupportedPlatform -ShareName MDTProduction -SetSupportedPlatformTo Null
```

Removes the OS restriction for ALL applications in MDTProduction (add a -confirm:$false on the end to remove prompts for each application)
### Example 2: Set ALL applications in share to Windows 7
```
PS C:\> Set-MDTApplicationSupportedPlatform -ShareName MDTProduction -SetSupportedPlatformTo Windows7Only
```

Set OS restriction for ALL applications in MDTProduction to Windows 7(add a -confirm:$false on the end to remove prompts for each application)
### Example 3: Set one application to windows 10
```
PS C:\> Set-MDTApplicationSupportedPlatform -ShareName MDTProduction -Name "Install - Java Runtime Environment -x86" -SetSupportedPlatformTo Windows10Only
```

Set OS restriction for "Install - Java Runtime Environment -x86" in MDTProduction to Windows 10

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
Accept wildcard characters: True
```

### -Name
Specifies the name of an application to search the MDT share for. If typed explicitly (i.e. "Install - Adobe Flash Player - x64"), will only return applications that have that exact name. The parameter also supports wildcards though, so typing something like "\*adobe\*" would return all the applications that have adobe in their name.

```yaml
Type: Object
Parameter Sets: NameFilter
Aliases:

Required: True
Position: Named
Default value:
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: True
```

### -SetSupportedPlatformTo
Specifies what OS restriction to apply to the application(or to remove the restriction by selecting Null). The OS restriction types are a bit more granular when setting this attribute via MDT's GUI, so due to the complexity behind scripting each one, broader "catch-all" types are used. At the moment this tool also disregards any previous settings of the attribute, so any previous settings will be overwritten with the new data specified here.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:
Accepted values: Null, Windows7Only, Windows8Only, Windows8.1Only, Windows10Only

Required: False
Position: Named
Default value:
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

Required: False
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
