# Import du module ActiveDirectory 
# https://learn.microsoft.com/en-us/powershell/module/activedirectory/?view=windowsserver2022-ps
Import-Module ActiveDirectory

$UtilisateurUsername = $args[0] 

# On vérifie l'existence d'un utilisateur 
if (Get-ADUser -Filter {SamAccountName -eq $UtilisateurUsername} -SearchBase "OU=utilisateurs,DC=l2-2,DC=lab")
{
    # Si l'utilisateur existe
    Unlock-ADAccount $UtilisateurUsername
    Write-Output "L'utilisateur $UtilisateurUsername a été débloqué"
}
else
{
    # Si l'utilisateur n'existe pas
    Write-Warning "L'utilisateur $UtilisateurUsername n'existe pas"
}
