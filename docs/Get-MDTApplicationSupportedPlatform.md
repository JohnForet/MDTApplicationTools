---
external help file: MDTApplicationTools-help.xml
online version: https://github.com/JohnForet/MDTApplicationTools/blob/master/docs/Get-MDTApplicationSupportedPlatform.md
schema: 2.0.0
---

# Get-MDTApplicationSupportedPlatform
## SYNOPSIS
Gets the SupportedPlatform attribute of or more MDT applications

## SYNTAX

### GUIDFilter
```
Get-MDTApplicationSupportedPlatform [-ShareName <Object>] -GUID <Object> -SupportedPlatformSet <Object>
```

### NameFilter
```
Get-MDTApplicationSupportedPlatform [-ShareName <Object>] -Name <Object> -SupportedPlatformSet <Object>
```

### NoFilter
```
Get-MDTApplicationSupportedPlatform [-ShareName <Object>] -SupportedPlatformSet <Object>
```

## DESCRIPTION
The Get-MDTApplicationSupportedPlatform function can either return the SupportedPlatform attribute of a queried application(via the name or GUID) parameter, return it for all applications, or return just applications that have it set(or not).

## EXAMPLES

### Example 1: Get all applications where the SupportedPlatform attribute is set(to anything)
```
PS C:\> Get-MDTApplicationSupportedPlatform -ShareName TESTSHARE -SupportedPlatformSet Yes
```

Returns all applications where SupportedPlatform is set.
### Example 2: Get all applications where the SupportedPlatform attribute is NOT set.
```
PS C:\> Get-MDTApplicationSupportedPlatform -ShareName TESTSHARE -SupportedPlatformSet No
```

Returns all applications where SupportedPlatform is NOT set.
### Example 3: Get SupportedPlatform attribute of specific application.
```
PS C:\> Get-MDTApplicationSupportedPlatform -ShareName TESTSHARE -Name "Install - Google Chrome -x64" -SupportedPlatformSet All
```

Returns the queried application along with it's SupportedPlatform attribute

## PARAMETERS

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

### -SupportedPlatformSet
Specifies in the query whether to return just Applications that have it set(Yes), just Applications that do NOT have it set(No), or to return Applications that both states(All).

```yaml
Type: Object
Parameter Sets: (All)
Aliases:
Accepted values: Yes, No, All

Required: True
Position: Named
Default value: All
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

### System.Object


## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS
