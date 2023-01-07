# Import du module ActiveDirectory 
# https://learn.microsoft.com/en-us/powershell/module/activedirectory/?view=windowsserver2022-ps
Import-Module ActiveDirectory

$CSVFile = "Utilisateurs.csv"
$CSVData = Import-CSV -Path $CSVFile -Delimiter ";" -Encoding UTF8

Write-Host "Création des utilisateurs"
Write-Host "-------------------------"
Write-Host ""
Write-Host "Fichier CSV : $CSVFile"

Foreach($Utilisateur in $CSVData){
    $UtilisateurUsername = $Utilisateur.Prenom + "." + $Utilisateur.Nom
    $UtilisateurPrenom = $Utilisateur.Prenom
    $UtilisateurNom = $Utilisateur.Nom
    $UtilisateurPassword = "Password123!"

   # On vérifie l'existence d'un utilisateur 
   if (Get-ADUser -Filter {SamAccountName -eq $UtilisateurUsername})
   {
      # Si l'utilisateur existe
      Write-Warning "L'identifiant $UtilisateurUsername existe déjà dans l'AD"
   }
   else
   {
     # Si l'utilisateur n'existe pas
             New-ADUser -Name "$UtilisateurNom $UtilisateurPrenom" `
                    -DisplayName "$UtilisateurNom $UtilisateurPrenom" `
                    -DisplayName "$UtilisateurNom $UtilisateurPrenom" `
                    -GivenName $UtilisateurPrenom `
                    -Surname $UtilisateurNom `
                    -SamAccountName $UtilisateurUsername `
                    -Path "OU=utilisateurs,DC=L2-2,DC=lab" `
                    -AccountPassword(ConvertTo-SecureString $UtilisateurPassword -AsPlainText -Force) `
                    -ChangePasswordAtLogon $true `
                    -PasswordNeverExpires $true `
                    -Enabled $true

        Write-Output "Création de l'utilisateur : $UtilisateurUsername ($UtilisateurNom $UtilisateurPrenom)"
   }
}
