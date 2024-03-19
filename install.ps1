Clear-Host
Write-Output "MY WORK WINDOWS APPS"

$apps = @(
    @{name = "JesseDuffield.lazygit" },
    @{name = "CoreyButler.NVMforWindows" },
    @{name = "GoLang.Go" },
    @{name = "Docker.DockerDesktop" },
    @{name = "Neovim.Neovim" },
    @{name = "BurntSushi.ripgrep.MSVC" },
    @{name = "VSCodium.VSCodium" },
    @{name = "Postman.Postman" }
    @{name = "MongoDB.Compass.Full" },
    @{name = "emqx.mqttx" },
    @{name = "Microsoft.VisualStudio.2022.Community" },
    @{name = "Microsoft.AzureDataStudio" },
    @{name = "Apache.DirectoryStudio" },
    @{name = "AdoptOpenJDK.OpenJDK.11" },
    @{name = "Mozilla.Firefox" },
    @{name = "Mozilla.Thunderbird" },
    @{name = "SlackTechnologies.Slack" }
);

$CONTINUE = Read-Host -Prompt 'Would you like to continue with the install? (y,n)'
if ($CONTINUE -eq 'y' || $CONTINUE -eq 'Y') {
  Write-Output "Starting..."
} else {
  Write-Output "This script will now exit, no changes were made to your system."
  exit
}

Write-Output "Installing apps, this may take a while..."
Foreach ($app in $apps) {
    $listApp = winget list --exact -q $app.name
    if (![String]::Join("", $listApp).Contains($app.name)) {
        Write-host "Installing: " $app.name
        winget install -e -h --accept-source-agreements --accept-package-agreements --id $app.name
    }
    else {
        Write-host "Skipping: " $app.name " (already installed)"
    }
}

Write-Output "Coping profile file..."
cp config\profile.ps1 $PROFILE.CurrentUserAllHosts

Write-Output "Coping .gitconfig file..."
cp config\.gitconfig $HOME\.gitconfig

Write-Output "Setting up nvm..."
$nvm_cmd = "$HOME\AppData\Roaming\nvm\nvm.exe"
& $nvm_cmd install lts
& $nvm_cmd use lts

Write-Output "Setting up neovim..."
git clone git@github.com:julihermes/Neovim-Config.git $HOME\AppData\Local\nvim

Write-Output "Script had completed!"
