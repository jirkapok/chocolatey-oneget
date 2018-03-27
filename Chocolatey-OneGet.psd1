#
# Module manifest for module 'Chocolatey-OneGet'
#

@{

    RootModule = 'Chocolatey-OneGet.psm1'
    ModuleVersion = '1.0'
    GUID = 'a628941d-1047-4fa2-917f-5c7e9fdb9189'
    Author = 'Chocolatey'
    CompanyName = 'Chocolatey'
    Copyright = '(c) 2018 Chocolatey'
    Description = 'The Official provider for Chocolatey packages that manages packages from https://www.chocolatey.org.'
    PowerShellVersion = '5.0'
    DotNetFrameworkVersion = '4.0'
    CLRVersion = '4.0'
    RequiredModules = @('PackageManagement')
    RequiredAssemblies = @("chocolatey.dll")

    # Script files (.ps1) that are run in the caller's environment prior to importing this module.
    # ScriptsToProcess = @()

    FunctionsToExport = @("Get-PackageProviderName", "Initialize-Provider", "Add-PackageSource")

    # Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
    CmdletsToExport = @()

    # Variables to export from this module
    # VariablesToExport = '*'
    #AliasesToExport = @()

    # List of all files packaged with this module
    # FileList = @()

    HelpInfoURI = 'https://github.com/chocolatey/chocolatey-oneget'

    PrivateData = @{

        "PackageManagementProviders" = 'MyAlbum.psm1'

        PSData = @{

            Tags = @("PackageManagement","Provider")
            LicenseUri = 'https://github.com/chocolatey/chocolatey-oneget/blob/master/LICENSE'
            ProjectUri = 'https://github.com/chocolatey/chocolatey-oneget'
            ExternalModuleDependencies = @('PackageManagement')
            # IconUri = ''
            # ReleaseNotes = ''
        }
  }
}
