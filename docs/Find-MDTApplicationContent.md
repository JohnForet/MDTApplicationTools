---
external help file: MDTApplicationTools-help.xml
online version: https://github.com/JohnForet/MDTApplicationTools/blob/master/docs/Find-MDTApplicationContent.md
schema: 2.0.0
---

# Find-MDTApplicationContent
## SYNOPSIS
Searches MDT shares for applications whose content contain specified text.

## SYNTAX

```
Find-MDTApplicationContent [-ShareName] <Object> [[-String] <Object>] [-ParseScript]
```

## DESCRIPTION
The Find-MDTApplicationContent function retrieves MDT applications from the specified MDT share that contain the string specified. It can query either just the CommandLine attribute of the application, or it can also query the install scripts themselves if the ParseScript switch is specified.

## EXAMPLES

### Example 1
```
PS C:\> Find-MDTApplicationContent -ShareName MDTProduction -string "setup.exe /s"
```

This command searches the MDT share MDTProduction, and returns any applications where the "CommandLine" attribute matches "setup.exe /s" exactly.

### Example 2
```
PS C:\> Find-MDTApplicationContent -ShareName MDTProduction -string *.bat*
```

This command searches the MDT share MDTProduction, and returns any applications that call a .bat file in their "CommandLine" attribute
### Example 3
```
PS C:\> Find-MDTApplicationContent -ShareName MDTProduction -string "C:\Program Files\*" -ParseScript
```

This command searches the MDT share MDTProduction, and returns any applications that call a .bat file in their "CommandLine" attribute

## PARAMETERS

### -ParseScript
**IF NOT** specified, the only part of the apps that are searched are the "CommandLine" attribute, which is the initial command that gets launched at install time to install the app(it can reference either an executable or an install script path). **IF** specified, the script will actually go through the applications working directory, and parse through any install scripts to see if they contain the specified string. It searches the following files:

".bat",".cmd",".vbs",".wsf",".ps1",".psm1",".psd1"

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

Required: True
Position: 0
Default value:
Accept pipeline input: False
Accept wildcard characters: False
```

### -String
Specifies the string to search for in MDT applications. If typed explicitly (i.e. "setup.exe /s"), it will only return applications that have that exact name. The parameter also supports wildcards though, so typing something like \*powershell.exe\* would return all the applications that have powershell.exe in their commandline or install script(depending on whether the ParseScript parameter was used).

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value:
Accept pipeline input: False
Accept wildcard characters: True
```

## INPUTS

### None


## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS
