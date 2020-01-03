[CmdletBinding()]
param()

Trace-VstsEnteringInvocation $MyInvocation
try {
    # Get the inputs.
    [string]$apkfile = Get-VstsInput -Name Apkfile
    [string]$outputApkfile = Get-VstsInput -Name OutputApkfile
    [string]$keyStorePath = Get-VstsInput -Name KeyStorePath
    [string]$keyStorePass = Get-VstsInput -Name KeyStorePass
    [string]$keyStoreAlias = Get-VstsInput -Name KeyStoreAlias
    
    Write-Verbose "Entering script MSBuild.ps1"
    Write-Verbose "apkfile = $apkfile"
    Write-Verbose "outputApkfile = $outputApkfile"
    Write-Verbose "keyStorePath = $keyStorePath"
    Write-Verbose "keyStorePass = $keyStorePass"
    Write-Verbose "keyStoreAlia = $keyStoreAlias"


    $jarSignPath = "jarsigner"
    Write-Verbose "jarsign path = $jarSignPath"

    $zipAlignPath = "$env:ANDROID_HOME/tools/zipalign.exe"
    Write-Verbose "zipalign path = $zipAlignPath"


    $outputFolder = Split-Path -Parent $outputApkfile;
    Write-Verbose "outputFolder = $outputFolder"
    $signedApk = "$outputFolder\signedApk.apk"
    Write-Verbose "signedApk = $signedApk"

    $jarSignArgs = "-keystore `"$keyStorePath`" -storepass $keyStorePass -keypass $keyStorePass -verbose -sigalg MD5withRSA -digestalg SHA1 -signedjar `"$signedApk`" `"$apkFile`" $keyStoreAlias"
    Write-Verbose "jarsign Args = $jarSignArgs"
    Invoke-VstsTool -FileName $jarSignPath -Arguments $jarSignArgs

    Invoke-VstsTool -FileName $jarSignPath -Arguments "-verify -verbose -certs $signedApk"

    $zipAlignArgs = "-f -v 4 `"$signedApk`" `"$outputApkfile`""
    Write-Verbose "zipalign Args = $zipAlignArgs"
    Invoke-VstsTool -FileName $zipAlignPath -Arguments $zipAlignArgs

} finally {
    Trace-VstsLeavingInvocation $MyInvocation
}
