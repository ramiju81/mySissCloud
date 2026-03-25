# mySissCloud - Script de Administración
# Facilita las tareas comunes de desarrollo y administración

param(
    [Parameter(Position=0)]
    [ValidateSet('start', 'stop', 'restart', 'init', 'compile', 'logs', 'shell', 'status', 'help')]
    [string]$Command = 'help'
)

$ErrorActionPreference = "Stop"

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  mySissCloud - Administración" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

function Show-Help {
    Write-Host "Comandos disponibles:" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "  start        " -NoNewline -ForegroundColor Green
    Write-Host "Iniciar el contenedor Docker"
    Write-Host "  stop         " -NoNewline -ForegroundColor Green
    Write-Host "Detener el contenedor Docker"
    Write-Host "  restart      " -NoNewline -ForegroundColor Green
    Write-Host "Reiniciar el contenedor Docker"
    Write-Host "  init         " -NoNewline -ForegroundColor Green
    Write-Host "Inicializar/Reinicializar base de datos completa"
    Write-Host "  compile      " -NoNewline -ForegroundColor Green
    Write-Host "Solo compilar clases (sin tocar BD)"
    Write-Host "  logs         " -NoNewline -ForegroundColor Green
    Write-Host "Ver logs del contenedor"
    Write-Host "  shell        " -NoNewline -ForegroundColor Green
    Write-Host "Abrir shell IRIS interactivo"
    Write-Host "  status       " -NoNewline -ForegroundColor Green
    Write-Host "Ver estado del sistema"
    Write-Host "  help         " -NoNewline -ForegroundColor Green
    Write-Host "Mostrar esta ayuda"
    Write-Host ""
    Write-Host "Ejemplos:" -ForegroundColor Yellow
    Write-Host "  .\manage.ps1 start" -ForegroundColor Gray
    Write-Host "  .\manage.ps1 init" -ForegroundColor Gray
    Write-Host "  .\manage.ps1 logs" -ForegroundColor Gray
    Write-Host ""
}

function Start-Container {
    Write-Host "► Iniciando contenedor..." -ForegroundColor Green
    docker-compose up -d
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✓ Contenedor iniciado correctamente" -ForegroundColor Green
        Write-Host ""
        Write-Host "URLs disponibles:" -ForegroundColor Cyan
        Write-Host "  - Portal IRIS:     http://localhost:52773/csp/sys/UtilHome.csp" -ForegroundColor Gray
        Write-Host "  - mySissCloud:     http://localhost:52773/csp/mySissCloud/mysiss_cloud.html" -ForegroundColor Gray
        Write-Host "  - Login:           http://localhost:52773/csp/mySissCloud/WebServiceLogin.html" -ForegroundColor Gray
        Write-Host "  - API Ping:        http://localhost:52773/csp/mySissCloud/api/ping" -ForegroundColor Gray
    } else {
        Write-Host "✗ Error al iniciar contenedor" -ForegroundColor Red
        exit 1
    }
}

function Stop-Container {
    Write-Host "► Deteniendo contenedor..." -ForegroundColor Yellow
    docker-compose down
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✓ Contenedor detenido" -ForegroundColor Green
    } else {
        Write-Host "✗ Error al detener contenedor" -ForegroundColor Red
        exit 1
    }
}

function Restart-Container {
    Write-Host "► Reiniciando contenedor..." -ForegroundColor Yellow
    docker-compose restart
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✓ Contenedor reiniciado" -ForegroundColor Green
    } else {
        Write-Host "✗ Error al reiniciar contenedor" -ForegroundColor Red
        exit 1
    }
}

function Initialize-Database {
    Write-Host "► Inicializando base de datos completa..." -ForegroundColor Green
    Write-Host "  Esto eliminará todos los datos existentes y creará la estructura desde cero" -ForegroundColor Yellow
    Write-Host ""
    
    $confirm = Read-Host "¿Está seguro? (s/n)"
    if ($confirm -ne 's' -and $confirm -ne 'S') {
        Write-Host "Operación cancelada" -ForegroundColor Yellow
        return
    }
    
    Get-Content .\scripts\init.osc | docker exec -i iris-mysisscloud iris session IRIS
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host ""
        Write-Host "✓ Base de datos inicializada correctamente" -ForegroundColor Green
        Write-Host ""
        Write-Host "Credenciales de acceso:" -ForegroundColor Cyan
        Write-Host "  Usuario:    admin" -ForegroundColor Gray
        Write-Host "  Contraseña: admin123" -ForegroundColor Gray
        Write-Host "  Rol:        SuperUsuario" -ForegroundColor Gray
    } else {
        Write-Host "✗ Error al inicializar base de datos" -ForegroundColor Red
        exit 1
    }
}

function Compile-Classes {
    Write-Host "► Compilando clases..." -ForegroundColor Green
    Get-Content .\scripts\compile.osc | docker exec -i iris-mysisscloud iris session IRIS
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✓ Compilación completada" -ForegroundColor Green
    } else {
        Write-Host "✗ Error en compilación" -ForegroundColor Red
        exit 1
    }
}

function Show-Logs {
    Write-Host "► Mostrando logs (Ctrl+C para salir)..." -ForegroundColor Cyan
    Write-Host ""
    docker logs -f iris-mysisscloud
}

function Open-Shell {
    Write-Host "► Abriendo shell IRIS..." -ForegroundColor Cyan
    Write-Host "  Namespace: CNET" -ForegroundColor Gray
    Write-Host "  Escriba 'halt' para salir" -ForegroundColor Gray
    Write-Host ""
    docker exec -it iris-mysisscloud iris session IRIS -U CNET
}

function Show-Status {
    Write-Host "► Estado del sistema:" -ForegroundColor Cyan
    Write-Host ""
    
    # Docker status
    Write-Host "Docker:" -ForegroundColor Yellow
    $container = docker ps --filter "name=iris-mysisscloud" --format "{{.Status}}"
    if ($container) {
        Write-Host "  ✓ Contenedor corriendo: $container" -ForegroundColor Green
    } else {
        Write-Host "  ✗ Contenedor no está corriendo" -ForegroundColor Red
    }
    Write-Host ""
    
    # Archivos HTML
    Write-Host "Archivos HTML:" -ForegroundColor Yellow
    docker exec iris-mysisscloud bash -c "ls -lh /usr/irissys/csp/mySissCloud/*.html 2>/dev/null | wc -l" 2>$null | ForEach-Object {
        if ($_ -gt 0) {
            Write-Host "  ✓ Encontrados: $_ archivos HTML" -ForegroundColor Green
        } else {
            Write-Host "  ✗ No se encontraron archivos HTML" -ForegroundColor Red
        }
    }
    Write-Host ""
    
    # Clases compiladas
    Write-Host "Clases ObjectScript:" -ForegroundColor Yellow
    docker exec iris-mysisscloud bash -c "ls -lh /opt/irisapp/src/mySiss/*/*.cls 2>/dev/null | wc -l" 2>$null | ForEach-Object {
        if ($_ -gt 0) {
            Write-Host "  ✓ Encontradas: $_ clases" -ForegroundColor Green
        } else {
            Write-Host "  ✗ No se encontraron clases" -ForegroundColor Red
        }
    }
    Write-Host ""
    
    # Test API
    Write-Host "API REST:" -ForegroundColor Yellow
    try {
        $response = Invoke-WebRequest -Uri "http://localhost:52773/csp/mySissCloud/api/ping" -UseBasicParsing -TimeoutSec 5
        if ($response.StatusCode -eq 200) {
            Write-Host "  ✓ API respondiendo correctamente" -ForegroundColor Green
            $json = $response.Content | ConvertFrom-Json
            Write-Host "    Servicio: $($json.service)" -ForegroundColor Gray
            Write-Host "    Versión: $($json.version)" -ForegroundColor Gray
        }
    } catch {
        Write-Host "  ✗ API no responde" -ForegroundColor Red
    }
    Write-Host ""
    
    Write-Host "URLs de acceso:" -ForegroundColor Yellow
    Write-Host "  - Portal IRIS:     http://localhost:52773/csp/sys/UtilHome.csp" -ForegroundColor Gray
    Write-Host "  - mySissCloud:     http://localhost:52773/csp/mySissCloud/mysiss_cloud.html" -ForegroundColor Gray
    Write-Host "  - Login:           http://localhost:52773/csp/mySissCloud/WebServiceLogin.html" -ForegroundColor Gray
    Write-Host "  - API Ping:        http://localhost:52773/csp/mySissCloud/api/ping" -ForegroundColor Gray
}

# Ejecutar comando
switch ($Command) {
    'start'    { Start-Container }
    'stop'     { Stop-Container }
    'restart'  { Restart-Container }
    'init'     { Initialize-Database }
    'compile'  { Compile-Classes }
    'logs'     { Show-Logs }
    'shell'    { Open-Shell }
    'status'   { Show-Status }
    'help'     { Show-Help }
    default    { Show-Help }
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
