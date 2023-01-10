# Import du module ActiveDirectory 
# https://learn.microsoft.com/en-us/powershell/module/activedirectory/?view=windowsserver2022-ps
Import-Module ActiveDirectory

$CSVFile = "C:\Users\Administrateur\Documents\editUtilisateurs.csv"

$users = Import-Csv -Path $CSVFile -Delimiter ";" -Encoding UTF8 -Header "Username", "NewFirstName", "NewLastName", "NewUsername"

Foreach($user in $users) {
    $Username= $user.Username
    $NewFirstName= $user.NewFirstName
    $NewLastName= $user.NewLastName
    $NewUsername= $user.NewUsername

    if (Get-ADUser -Filter {SamAccountName -eq $Username}) {
        try {
            Set-ADUser -Identity (Get-ADUser -Filter {SamAccountName -eq $Username}) -GivenName $NewFirstName -Surname $NewLastName -SamAccountName $NewUsername
            Write-Host "$Username a bien ete modifie"
        }
        catch {
            Write-Host "Une erreur s'est produite lors de la modification de $Username"
        }
    }
    else {
        Write-Host "Il n'y a pas d'utilisateur $Username"
    }
}
