---
external help file: MDTApplicationTools-help.xml
online version: https://github.com/JohnForet/MDTApplicationTools/blob/master/docs/Get-MDTApplicationDependency.md
schema: 2.0.0
---

# Get-MDTApplicationDependency
## SYNOPSIS
Gets the application dependencies of or more MDT applications

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
The Get-MDTApplicationDependency function either returns all the applications that the application is dependent upon(applications that need to be installed before installing the queried application), or applications upon which the queried application is a dependency. It can go back either just one application, or can recurse the entire depth of the dependency tree.

## EXAMPLES

### Example 1: Get any direct parent dependencies of an app
```
PS C:\> Get-MDTApplicationDependency -ShareName MDTProduction -Name "Install - Java Development Kit - x64"
```

Returns only applications that will be installed **directly before** the Java JDK is installed.
### Example 2: Get any direct child dependencies of an app
```
PS C:\> Get-MDTApplicationDependency -ShareName MDTProduction -Name "Install - Java Development Kit - x64" -DependencyType ReturnChild
```

Returns only applications that will install the Java JDK **directly after** they themselves are installed
### Example 3: Get **all** parent dependencies of an app
```
PS C:\> Get-MDTApplicationDependency -ShareName MDTProduction -Name "Install - Java Development Kit - x64" -Recurse
```

Returns all applications that need to be installed **before** the Java JDK is installed.
### Example 4: Get **all** child dependencies of an app
```
PS C:\> Get-MDTApplicationDependency -ShareName MDTProduction -Name "Install - Java Development Kit - x64" -Recurse -DependencyType ReturnChild
```

Returns all applications that will be installed **after** the Java JDK is installed

## PARAMETERS

### -DependencyType
Specifies whether to return the parent dependencies of the queried application(applications that need to be installed before installing the queried application), or to return the child dependencies of the queried application(applications where the queried application needs to be installed first). Possible options are ReturnParent and ReturnChild. Default value is ReturnParent.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:
Accepted values: ReturnParent, ReturnChild

Required: False
Position: Named
Default value: ReturnParent
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

### -Recurse
If specified recurses the dependency tree until it reaches the last dependency. If not, only finds dependencies that are one depth away.

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

## INPUTS

### System.Object


## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS
