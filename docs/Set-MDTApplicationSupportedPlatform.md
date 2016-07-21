---
external help file: MDTApplicationTools-help.xml
online version: 
schema: 2.0.0
---

# Set-MDTApplicationSupportedPlatform
## SYNOPSIS
{{Fill in the Synopsis}}

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
{{Fill in the Description}}

## EXAMPLES

### Example 1
```
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -Confirm
{{Fill Confirm Description}}

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

### -GUID
{{Fill GUID Description}}

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
{{Fill Name Description}}

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

### -SetSupportedPlatformTo
{{Fill SetSupportedPlatformTo Description}}

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
{{Fill ShareName Description}}

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
{{Fill WhatIf Description}}

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

