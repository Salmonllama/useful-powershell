# More information can be found in the below link:
# https://learn.microsoft.com/en-us/azure/active-directory/develop/howto-create-self-signed-certificate

$certName = "{certificate-name}"

$certificate = New-SelfSignedCertificate -Subject "CN=$certName" -CertStoreLocation "Cert:\CurrentUser\My" -KeyExportPolicy Exportable -KeySpec Signature -KeyLength 2048 -KeyAlgorithm RSA -HashAlgorithm SHA256

Export-Certificate -Cert $certificate -FilePath "C:\File\Path\Here\$certName.crt"

# The below is for exporting the private key

$certPassword = ConvertTo-SecureString -String "{password}" -Force -AsPlainText

Export-PfxCertificate -Cert $certificate -FilePath "C:\File\Path\Here\$certname.pfx" -Password $certPassword

# Delete the cert from the keystore

Get-ChildItem -Path "Cert:\CurrentUser\My" | Where-Object {$_.Subject -Match "$certName"} | Select-Object Thumbprint, FriendlyName

# Copy the thumbprint

Remove-Item -Path Cert:\CurrentUser\My\{certificate-thumbprint} -DeleteKey