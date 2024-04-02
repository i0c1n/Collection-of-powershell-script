function ShowMenu {
    Write-Host "*****************************"
    Write-Host "Configuration Menu"
    Write-Host "*****************************"
    Write-Host "1. O365 Connection"
    Write-Host "2. Check Users' Phone Number"
    Write-Host "3. Users Configuration"
    Write-Host "4. Reset User"
    Write-Host "5. Get User Details"
    Write-Host ""
}

function ExecuteAction {
    param(
        [ScriptBlock]$Action
    )
    & $Action
}

function GetUserDetails {
    $userName = Read-Host "Enter the user name"
    Get-CsOnlineUser -Identity $userName | Format-List DisplayName,UserPrincipalName,AssignedPlan,FeatureTypes,LineUri,OnlineVoiceRoutingPolicy,TeamsCallingPolicy,TenantDialPlan,Company,Department,Title
}

ShowMenu

while ($true) {
    $choice = Read-Host "Enter your choice number (1-5), 'm' to show menu, 'q' to quit, or 'c' to clear the console"

    if ($choice -eq "q") {
        Write-Host "`nGoodbye!"
        exit
    }

    if ($choice -eq "m") {
        ShowMenu
        continue
    }

    if ($choice -eq "c") {
        Clear-Host
        ShowMenu
        continue
    }

    switch ($choice) {
        "1" {
            Write-Host "`nYou chose option 1: O365 Connection"
            ExecuteAction { Connect-MicrosoftTeams }
        }
        "2" {
            Write-Host "`nYou chose option 2: Check Users' Phone Number"
            $phone_number = Read-Host "Please enter the user's phone number"
            Get-CsOnlineUser | Where-Object { $_.LineURI -eq "tel:+" + $phone_number } | foreach {
                $user = $_
                Write-Host "User Display Name: $($user.DisplayName)"
                Write-Host "User Principal Name: $($user.UserPrincipalName)"
                Write-Host "Line URI: $($user.LineURI)"
            }
        }
        "3" {
            Write-Host "`nYou chose option 3: Users Configuration"
            $userName = Read-Host "Enter the user name"
            $phoneNumber = Read-Host "Enter the phone number"
            Set-CsPhoneNumberAssignment -Identity $userName -PhoneNumber $phoneNumber -PhoneNumberType DirectRouting
            Write-Host "Phone number updated for $($userName): $($phoneNumber)"
            Grant-CsTeamsCallingPolicy -Identity $userName -PolicyName AllowCalling
            Write-Host "Teams calling policy granted for $userName"
            Grant-CsTenantDialPlan -Identity $userName -PolicyName BMH
            Write-Host "Tenant dial plan granted for $userName"
            Grant-CsOnlineVoiceRoutingPolicy -Identity $userName -PolicyName BMH-Cos3
            Write-Host "Online voice routing policy granted for $userName"
        }
        "4" {
            Write-Host "`nYou chose option 4: Reset User"
            $userName = Read-Host "Enter the user name"
            Remove-CsPhoneNumberAssignment -Identity $userName -RemoveAll
            Write-Host "The account $userName has been successfully reset"
        }
        "5" {
            Write-Host "`nYou chose option 5: Get User Details"
            GetUserDetails
        }
        default {
            Write-Host "`nInvalid choice. Please enter a number between 1 and 5, 'm' to show menu, 'q' to quit, or 'c' to clear the console."
        }
    }

    Start-Sleep -Milliseconds 500
}
