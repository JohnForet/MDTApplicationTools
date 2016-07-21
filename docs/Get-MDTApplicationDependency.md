---
external help file: MDTApplicationTools-help.xml
online version: 
schema: 2.0.0
---

# Get-MDTApplicationDependency
## SYNOPSIS
{{Fill in the Synopsis}}

## SYNTAX

### GUIDFilter
```
Get-MDTApplicationDependency [-ShareName <Object>] [-DependencyType <Object>] [-Recurse] -GUID <Object>
```

### NameFilter
```
Get-MDTApplicationDependency [-ShareName <Object>] [-DependencyType <Object>] [-Recurse] -Name <Object>
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

### -DependencyType
{{Fill DependencyType Description}}

```yaml
Type: Object
Parameter Sets: (All)
Aliases: 
Accepted values: ReturnParent, ReturnChild

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

### -Recurse
{{Fill Recurse Description}}

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

## INPUTS

### System.Object


## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS

