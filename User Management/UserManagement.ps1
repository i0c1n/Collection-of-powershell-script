function Show-Menu {
    Clear-Host
    Write-Host "*******************************"
    Write-Host "      Active Directory Menu"
    Write-Host "*******************************"
    Write-Host "1. Check the lockout status of an AD account"
    Write-Host "2. Unlock an AD account"
    Write-Host "3. Check if an AD account is enabled or disabled"
    Write-Host "4. Enable an AD account"
    Write-Host "5. Disable an AD account"
    Write-Host "6. Quit"
}

function Get-Choice {
    Show-Menu
    $choice = Read-Host "Enter the number of your choice"
    return $choice
}

function Unlock-ADUser {
    param(
        [string]$username
    )

    $user = Get-ADUser $username -Properties LockedOut

    if ($user) {
        if ($user.LockedOut) {
            $user | Unlock-ADAccount
            Write-Host "The user account $username has been successfully unlocked."
        } else {
            Write-Host "The user account $username is not locked."
        }
    } else {
        Write-Host "The user account $username does not exist in Active Directory."
    }
}

function Enable-ADUser {
    param(
        [string]$username
    )

    $user = Get-ADUser $username -Properties Enabled

    if ($user) {
        if (-not $user.Enabled) {
            $user | Enable-ADAccount
            Write-Host "The user account $username has been successfully enabled."
        } else {
            Write-Host "The user account $username is already enabled."
        }
    } else {
        Write-Host "The user account $username does not exist in Active Directory."
    }
}

function Disable-ADUser {
    param(
        [string]$username
    )

    $user = Get-ADUser $username -Properties Enabled

    if ($user) {
        if ($user.Enabled) {
            $user | Disable-ADAccount
            Write-Host "The user account $username has been successfully disabled."
        } else {
            Write-Host "The user account $username is already disabled."
        }
    } else {
        Write-Host "The user account $username does not exist in Active Directory."
    }
}

function Check-ADUserStatus {
    param(
        [string]$username
    )

    $user = Get-ADUser $username -Properties Enabled

    if ($user) {
        if ($user.Enabled) {
            Write-Host "The user account $username is enabled."
        } else {
            Write-Host "The user account $username is disabled."
        }
    } else {
        Write-Host "The user account $username does not exist in Active Directory."
    }
}

$continue = $true
while ($continue) {
    $choice = Get-Choice
    switch ($choice) {
        '1' {
            Clear-Host
            $username = Read-Host "Enter the username of the account to check"
            $user = Get-ADUser $username -Properties LockedOut
            if ($user) {
                if ($user.LockedOut) {
                    Write-Host "The user account $username is locked."
                } else {
                    Write-Host "The user account $username is not locked."
                }
            } else {
                Write-Host "The user account $username does not exist in Active Directory."
            }
            Pause
        }
        '2' {
            Clear-Host
            $username = Read-Host "Enter the username of the account to unlock"
            Unlock-ADUser -username $username
            Pause
        }
        '3' {
            Clear-Host
            $username = Read-Host "Enter the username of the account to check"
            Check-ADUserStatus -username $username
            Pause
        }
        '4' {
            Clear-Host
            $username = Read-Host "Enter the username of the account to enable"
            Enable-ADUser -username $username
            Pause
        }
        '5' {
            Clear-Host
            $username = Read-Host "Enter the username of the account to disable"
            Disable-ADUser -username $username
            Pause
        }
        '6' {
            $continue = $false
            Write-Host "Goodbye!"
        }
        default {
            Write-Host "Invalid choice. Please select a valid option."
            Pause
        }
    }
}

function Pause {
    Write-Host "Press any key to continue..."
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
}
