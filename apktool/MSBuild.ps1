[CmdletBinding()]
param()

Trace-VstsEnteringInvocation $MyInvocation
try {
    # Get the inputs.
    [string]$apktoolAction = Get-VstsInput -Name ApktoolAction
    [string]$inputFolder = Get-VstsInput -Name InputFolder
    [string]$outputFolder = Get-VstsInput -Name OutputFolder
    [string]$apkfile = Get-VstsInput -Name Apkfile
    
    Write-Verbose "Entering script MSBuild.ps1"
    Write-Verbose "apktoolAction = $apktoolAction"
    Write-Verbose "inputFolder = $inputFolder"
    Write-Verbose "outputFolder = $outputFolder"
    Write-Verbose "apkfile = $apkfile"

    $scriptLocation = Split-Path -Parent $PSCommandPath;
    Write-Verbose "script path = $scriptLocation"
    $apkToolPath = "$PSScriptRoot\apktool.bat"
    Write-Verbose "apktool path = $apkToolPath"
    $apkToolArgs = "decode `"$apkfile`" "
    Write-Verbose "apktool args = $apkToolArgs"

    Invoke-VstsTool -FileName $apkToolPath -Arguments $apkToolArgs

} finally {
    Trace-VstsLeavingInvocation $MyInvocation
}

# $nugetRestore = Convert-String $restoreNugetPackages Boolean
# Write-Verbose "nugetRestore (converted) = $nugetRestore"
# $logEvents = Convert-String $logProjectEvents Boolean
# Write-Verbose "logEvents (converted) = $logEvents"
# $noTimelineLogger = !$logEvents
# Write-Verbose "noTimelineLogger = $noTimelineLogger"
# $cleanBuild = Convert-String $clean Boolean
# Write-Verbose "clean (converted) = $cleanBuild"

# # check for solution pattern
# if ($solution.Contains("*") -or $solution.Contains("?"))
# {
#     Write-Verbose "Pattern found in solution parameter. Calling Find-Files."
#     Write-Verbose "Find-Files -SearchPattern $solution"
#     $solutionFiles = Find-Files -SearchPattern $solution
#     Write-Verbose "solutionFiles = $solutionFiles"
# }
# else
# {
#     Write-Verbose "No Pattern found in solution parameter."
#     $solutionFiles = ,$solution
# }

# if (!$solutionFiles)
# {
#     throw (Get-LocalizedString -Key "No solution was found using search pattern '{0}'." -ArgumentList $solution)
# }

# $args = $msbuildArguments;
# if ($platform)
# {
#     Write-Verbose "adding platform: $platform"
#     $args = "$args /p:platform=`"$platform`""
# }

# if ($configuration)
# {
#     Write-Verbose "adding configuration: $configuration"
#     $args = "$args /p:configuration=`"$configuration`""
# }

# Write-Verbose "args = $args"

# # Default the msbuildLocationMethod if not specified. The input msbuildLocationMethod
# # was added to the definition after the input msbuildLocation.
# if ("$msbuildLocationMethod".ToUpperInvariant() -ne 'LOCATION' -and "$msbuildLocationMethod".ToUpperInvariant() -ne 'VERSION')
# {
#     # Infer the msbuildLocationMethod based on the whether msbuildLocation is specified.
#     if ($msbuildLocation)
#     {
#         $msbuildLocationMethod = 'location'
#     }
#     else
#     {
#         $msbuildLocationMethod = 'version'
#     }

#     Write-Verbose "Defaulted msbuildLocationMethod to: $msbuildLocationMethod"
# }

# # Default to 'version' if the user chose 'location' but didn't specify a location.
# if ("$msbuildLocationMethod".ToUpperInvariant() -eq 'LOCATION' -and !$msbuildLocation)
# {
#     Write-Verbose 'Location not specified. Using version instead.'
#     $msbuildLocationMethod = 'version'
# }

# if ("$msbuildLocationMethod".ToUpperInvariant() -eq 'VERSION')
# {
#     # Look for a specific version of MSBuild.
#     if ($msbuildVersion -and "$msbuildVersion".ToUpperInvariant() -ne 'LATEST')
#     {
#         Write-Verbose "Searching for MSBuild version: $msbuildVersion"
#         $msbuildLocation = Get-MSBuildLocation -Version $msbuildVersion -Architecture $msbuildArchitecture

#         # Warn if not found.
#         if (!$msbuildLocation)
#         {
#             Write-Warning (Get-LocalizedString -Key 'Unable to find MSBuild: Version = {0}, Architecture = {1}. Looking for the latest version.' -ArgumentList $msbuildVersion, $msbuildArchitecture)
#         }
#     }

#     # Look for the latest version of MSBuild.
#     if (!$msbuildLocation)
#     {
#         Write-Verbose 'Searching for latest MSBuild version.'
#         $msbuildLocation = Get-MSBuildLocation -Version '' -Architecture $msbuildArchitecture

#         # Throw if not found.
#         if (!$msbuildLocation)
#         {
#             throw (Get-LocalizedString -Key 'MSBuild not found: Version = {0}, Architecture = {1}. Try a different version/architecture combination, specify a location, or install the appropriate MSBuild version/architecture.' -ArgumentList $msbuildVersion, $msbuildArchitecture)
#         }
#     }

#     Write-Verbose "msbuildLocation = $msbuildLocation"
# }

# if ($cleanBuild)
# {
#     foreach ($sf in $solutionFiles)  
#     {
#         Invoke-MSBuild $sf -Targets Clean -LogFile "$sf-clean.log" -ToolLocation $msBuildLocation -CommandLineArgs $args -NoTimelineLogger:$noTimelineLogger
#     }
# }

# $nugetPath = Get-ToolPath -Name 'NuGet.exe'
# if (-not $nugetPath -and $nugetRestore)
# {
#     Write-Warning (Get-LocalizedString -Key "Unable to locate {0}. Package restore will not be performed for the solutions" -ArgumentList 'nuget.exe')
# }

# foreach ($sf in $solutionFiles)
# {
#     if ($nugetPath -and $nugetRestore)
#     {
#         $slnFolder = $(Get-ItemProperty -Path $sf -Name 'DirectoryName').DirectoryName

#         Write-Verbose "Searching for nuget package configuration files using pattern $slnFolder\**\packages.config"
#         $pkgConfig = Find-Files -SearchPattern "$slnFolder\**\packages.config"
#         if ($pkgConfig)
#         {
#             Write-Verbose "Running nuget package restore for $slnFolder"
#             Invoke-Tool -Path $nugetPath -Arguments "restore `"$sf`" -NonInteractive" -WorkingFolder $slnFolder
#         }
#         else
#         {
#             Write-Verbose "No nuget package configuration files found for $sf"
#         }
#     }

#     Invoke-MSBuild $sf -LogFile "$sf.log" -ToolLocation $msBuildLocation -CommandLineArgs $args  -NoTimelineLogger:$noTimelineLogger
# }

# Write-Verbose "Leaving script MSBuild.ps1"
