@echo off
set tmpps1=%temp%\test.ps1

echo function Check-Admin { >%tmpps1%
echo $currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent()) >>%tmpps1%
echo $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator) >>%tmpps1%
echo } >>%tmpps1%
echo if ((Check-Admin) -eq $false)  { >>%tmpps1%
echo     if ($elevated){ >>%tmpps1%
echo         # could not elevate, quit >>%tmpps1%
echo     }else { >>%tmpps1%
echo         Start-Process powershell.exe -Verb RunAs -ArgumentList ('-noprofile -noexit -ExecutionPolicy UnRestricted -file "{0}" -elevated' -f ($myinvocation.MyCommand.Definition)) >>%tmpps1%
echo     } >>%tmpps1%
echo     exit >>%tmpps1%
echo } >>%tmpps1%
echo echo "updating hosts ..." >>%tmpps1%
echo $systemroot=$env:SystemRoot >>%tmpps1%
echo $hostpath=$systemroot+"\System32\drivers\etc" >>%tmpps1%
echo $hostfile=$hostpath+"\hosts" >>%tmpps1%
echo $hostgithub="https://raw.githubusercontent.com/racaljk/hosts/master/hosts" >>%tmpps1%
echo $hosttmpfile="C:"+$env:HOMEPATH+"\hosts" >>%tmpps1%
echo $client=new-object System.Net.WebClient >>%tmpps1%
echo $client.DownloadFile("$hostgithub","$hosttmpfile") >>%tmpps1%
echo if (test-path "$hostfile") { >>%tmpps1%
echo 	Remove-Item $hostfile >>%tmpps1%
echo } >>%tmpps1%
echo Copy-Item $hosttmpfile $hostpath >>%tmpps1%
echo Remove-Item $hosttmpfile >>%tmpps1%
echo echo "successfully updated hosts" >>%tmpps1%

powershell -ExecutionPolicy unrestricted -File %tmpps1%
