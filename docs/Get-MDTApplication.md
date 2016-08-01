---
external help file: MDTApplicationTools-help.xml
online version: https://github.com/JohnForet/MDTApplicationTools/blob/master/docs/Get-MDTApplication.md
schema: 2.0.0
---

# Get-MDTApplication
## SYNOPSIS
Gets one or more MDT applications

## SYNTAX

### GUIDFilter
```
Get-MDTApplication [-ShareName <Object>] [-Location <Object>] -GUID <Object>
```

### NameFilter
```
Get-MDTApplication [-ShareName <Object>] [-Location <Object>] -Name <Object>
```

### NoFilter
```
Get-MDTApplication [-ShareName <Object>] [-Location <Object>]
```

## DESCRIPTION
The Get-MDTApplication function retrieves MDT applications from the specified MDT share. It can be used to either retrieve all the applications at once, or just by the applications Name or GUID of the wanted application.

## EXAMPLES

### Example 1: Get all applications
```
PS C:\>Get-MDTApplication -ShareName MDTProduction
```

This command returns all applications from the MDT share.
### Example 2: Get only applications in a certain directory
```
PS C:\>Get-MDTApplication -ShareName MDTProduction -Location "APPBUNDLES"
```

This command returns all applications from the MDT share that are located in a folder called "APPBUNDLES" (located under the Applications root folder).
### Example 3: Get application by name
```
PS C:\>Get-MDTApplication -ShareName MDTProduction -Name "Install - Java 8 - x64"
```

This command returns the application with the name "Install - Java 8 - x64" from the MDT share.
### Example 4: Use wildcards to search for applications
```
PS C:\>Get-MDTApplication -ShareName MDTProduction -Name *java*
```

This command returns any applications that have the word java somewhere in their name from the MDT share.
### Example 5: Get application by GUID
```
PS C:\>Get-MDTApplication -ShareName MDTProduction -GUID "{4deefc41-71c2-4f59-bcf7-89fd4629a025}"
```

This command returns the application with the GUID "4deefc41-71c2-4f59-bcf7-89fd4629a025" from the MDT share.

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

### -Location
Specifies that the query be restricted to a folder located within the Applications folder. Specifying "Install\Broken" for example would restrict the search to the folder "Applications\Install\Broken" in the MDT share.

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

## INPUTS

### System.Object


## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS
