$chocolateyOneGet = "Chocolatey-OneGet"
# If import failed, chocolatey.dll is locked and is necessary to reload powershell
Import-PackageProvider $chocolateyOneGet -force

Describe "Imported module" {
    $provider = Get-PackageProvider -Name $chocolateyOneGet

    It "is loaded as PackageProvider" {
        $provider | Should -Not -be $null
    }

    It "supports '.nupkg' file extension" {
        $extensions = $provider.features["file-extensions"]
        $extensions | Should -Contain ".nupkg"
    }

    It "supports 'http', 'https' and 'file' repository location types" {
        $extensions = $provider.features["uri-schemes"]
        $extensions | Should -Be "http https file"
    }
}

Describe "Added packages source" {
    $expectedSourceName = "Chocolatey-TestScriptRoot"
    $expectedCertificateSource = "Chocolatey-CertificateTestScriptRoot"

    BeforeAll { 
        Invoke-Expression "choco source remove -n=$expectedSourceName"
        Invoke-Expression "choco source remove -n=$expectedCertificateSource"
    }

    AfterAll {
        Invoke-Expression "choco source remove -n=$expectedSourceName"
        Invoke-Expression "choco source remove -n=$expectedCertificateSource"
    }
    
    $userPassword = "UserPassword" | ConvertTo-SecureString -AsPlainText -Force
    $credentials = new-object -typename System.Management.Automation.PSCredential -argumentlist "UserName", $userPassword

    Register-PackageSource -ProviderName $chocolateyOneGet -Name $expectedSourceName -Location $PSScriptRoot `
                        -Priority 10 -BypassProxy -AllowSelfService -VisibleToAdminsOnly `
                        -Credential $credentials

    Register-PackageSource -ProviderName $chocolateyOneGet -Name $expectedCertificateSource -Location $PSScriptRoot `
                        -Certificate "testCertificate" -CertificatePassword "testCertificatePassword"

    $registeredSource = choco source list | Where-Object { $_.Contains($expectedSourceName)}

    It "is saved in choco" {
        $registeredSource | Should -Not -Be $Null
    }

    It "saves Priority" {
        $registeredSource | Should -Match "Priority 10"
    }

    It "saves BypassProxy" {
        $registeredSource | Should -Match "Bypass Proxy - True"
    }

    It "saves AllowSelfService" {
        $registeredSource | Should -Match "Self-Service - True"
    }

    # Requires business edition
    It "saves VisibleToAdminsOnly" -Skip {
        $registeredSource | Should -Match "Admin Only - True"
    }

    # TODO how to test the user name was used or certificate was used properly?
    It "saves user credential properties" {
        $registeredSource | Should -Match "(Authenticated)"
    }

    It "saves user certificate properties" {
        $certificateSource = choco source list | Where-Object { $_.Contains($expectedCertificateSource)}
        $certificateSource | Should -Match "(Authenticated)"
    }
}