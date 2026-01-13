# Configurable Variables
$PASSWORD_FOR_USERS = "Password1"
$NUMBER_OF_ACCOUNTS_TO_CREATE = 1000
$OU_NAME = "_USERS"


Import-Module ActiveDirectory

Function Generate-Random-Name {
    $consonants = @('b','c','d','f','g','h','j','k','l','m','n','p','q','r','s','t','v','w','x','z')
    $vowels = @('a','e','i','o','u','y')
    $nameLength = Get-Random -Minimum 3 -Maximum 7
    $name = ""

    for ($i = 0; $i -lt $nameLength; $i++) {
        if ($i % 2 -eq 0) {
            $name += $consonants | Get-Random
        } else {
            $name += $vowels | Get-Random
        }
    }
    return $name
}

# Get domain DN
$domainDN = (Get-ADDomain).DistinguishedName
$ouPath = "OU=$OU_NAME,$domainDN"

# Create OU if it doesn't exist
if (-not (Get-ADOrganizationalUnit -Filter "Name -eq '$OU_NAME'" -ErrorAction SilentlyContinue)) {
    New-ADOrganizationalUnit `
        -Name $OU_NAME `
        -Path $domainDN `
        -ProtectedFromAccidentalDeletion $false
}

$password = ConvertTo-SecureString $PASSWORD_FOR_USERS -AsPlainText -Force

for ($count = 1; $count -le $NUMBER_OF_ACCOUNTS_TO_CREATE; $count++) {

    $firstName = Generate-Random-Name
    $lastName  = Generate-Random-Name
    $username  = "$firstName.$lastName"

    Write-Host "Creating user: $username" -ForegroundColor Cyan

    New-ADUser `
        -SamAccountName $username `
        -UserPrincipalName "$username@$((Get-ADDomain).DnsRoot)" `
        -GivenName $firstName `
        -Surname $lastName `
        -DisplayName $username `
        -Name $username `
        -EmployeeID $username `
        -AccountPassword $password `
        -PasswordNeverExpires $true `
        -Path $ouPath `
        -Enabled $true
}
