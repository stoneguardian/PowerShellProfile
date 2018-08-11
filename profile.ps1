Set-StrictMode -Version Latest

$PromptColors = @{
    PS = @{
        $true = @{ 
            Foreground = $Host.UI.RawUI.ForegroundColor
            Background = 'DarkBlue'
        }
        $false = @{
            Foreground = $Host.UI.RawUI.ForegroundColor
            Background = 'DarkRed'
        }
    }

    Path = @{
        Foreground = 'Green'
        Background = $Host.UI.RawUI.BackgroundColor
    }

    Computer = @{
        Foreground = 'DarkGreen'
        Background = $Host.UI.RawUI.BackgroundColor
    }

    Debug = @{
        Foreground = 'Black'
        Background = 'Yellow'
    }
}

function prompt()
{
    $PSColors = $PromptColors['PS'][$?]

    # First line
    #Write-Host "$($env:USERNAME)@$($env:COMPUTERNAME)" -BackgroundColor $PromptColors.Computer.Background -ForegroundColor $PromptColors.Computer.Foreground -NoNewline

    $currentLocation = Get-Location
    Write-Host "$($currentLocation) " -BackgroundColor $PromptColors.Path.Background -ForegroundColor $PromptColors.Path.Foreground -NoNewline

    Write-Host ""
    # Second line
    Write-Host " PS " -BackgroundColor $PSColors.Background -ForegroundColor $PSColors.Foreground -NoNewline

    if($null -ne (Get-ChildItem Variable:\ | Where-Object { $_.Name -eq 'PSDebugContext' }))
    {
        Write-Host " DBG " -BackgroundColor $PromptColors.Debug.Background -ForegroundColor $PromptColors.Debug.Foreground -NoNewline
    }
    
    # Second line
    if($NestedPromptLevel -gt 0)
    {
        Write-Host " >>" -ForegroundColor $Host.UI.RawUI.ForegroundColor -NoNewline
    }
    else
    {
        Write-Host " >" -ForegroundColor $Host.UI.RawUI.ForegroundColor -NoNewline
    }  

    " " # Write-Output
}