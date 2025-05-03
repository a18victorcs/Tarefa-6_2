# Descripción: Aplica medidas básicas de hardening a una instalación de WordPress

# Ruta de donde está instalado WordPress
$WPDir = "c:\xampp\htdocs\wordpress"
$wpConfig = Join-Path $WPDir "wp-config.php"
$htaccess = Join-Path $WPDir ".htaccess"

Write-Output "[+] Configurando wp-config.php..."
if (-not (Select-String -Path $wpConfig -Pattern "DISALLOW_FILE_EDIT" -Quiet)){
    Add-Content -Path $wpConfig -Value "`r`ndefine('DISALLOW_FILE_EDIT', true);"
    Write-Output "DISALLOW_FILE_EDIT añadido a wp-config.php"
} else {
    Write-Output "La configuración ya existe en wp-config.php"
}

Write-Output "Añaadiendo reglas de seguridad a .htaccess..."
$rules = @"
<Files wp-config.php>
    Order allow,deny
    Deny from all
</Files>

<Files readme.html>
    Order allow,deny
    Deny from all
</Files>

<Files xmlrpc.php>
    Order deny,allow
    Deny from all
</Files>
"@
Add-Content -Path $htaccess -Value $rules

Write-Output "Hardening básico completado."