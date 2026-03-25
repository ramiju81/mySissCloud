#!/bin/bash
# ============================================================
# mySissCloud - Script de administración (bash)
# Equivalente al manage.ps1 pero ejecutable en Linux/Mac/WSL
# Uso: bash manage.sh [start|stop|restart|init|compile|logs|shell|status|help]
# ============================================================

COMANDO="${1:-help}"
CONTAINER="iris-mysisscloud"

echo "========================================"
echo "  mySissCloud - Administración"
echo "========================================"
echo ""

show_help() {
    echo "Comandos disponibles:"
    echo ""
    echo "  start    - Iniciar el contenedor Docker"
    echo "  stop     - Detener el contenedor Docker"
    echo "  restart  - Reiniciar el contenedor Docker"
    echo "  init     - Inicializar/Reinicializar base de datos completa"
    echo "  compile  - Solo compilar clases (sin tocar BD)"
    echo "  logs     - Ver logs del contenedor"
    echo "  shell    - Abrir shell IRIS interactivo"
    echo "  status   - Ver estado del sistema"
    echo "  help     - Mostrar esta ayuda"
    echo ""
    echo "Ejemplos:"
    echo "  bash manage.sh start"
    echo "  bash manage.sh init"
    echo "  bash manage.sh logs"
    echo ""
}

start_container() {
    echo "► Iniciando contenedor..."
    docker-compose up -d
    if [ $? -eq 0 ]; then
        echo "✓ Contenedor iniciado correctamente"
        echo ""
        echo "URLs disponibles:"
        echo "  - Portal IRIS:  http://localhost:52773/csp/sys/UtilHome.csp"
        echo "  - Login:        http://localhost:52773/csp/mySissCloud/mySiss_Cloud_Login.html"
        echo "  - Dashboard:    http://localhost:52773/csp/mySissCloud/mysiss_cloud.html"
        echo "  - API Ping:     http://localhost:52773/csp/mySissCloud/api/ping"
    else
        echo "✗ Error al iniciar contenedor"
        exit 1
    fi
}

stop_container() {
    echo "► Deteniendo contenedor..."
    docker-compose down
    if [ $? -eq 0 ]; then
        echo "✓ Contenedor detenido"
    else
        echo "✗ Error al detener contenedor"
        exit 1
    fi
}

restart_container() {
    echo "► Reiniciando contenedor..."
    docker-compose restart
    if [ $? -eq 0 ]; then
        echo "✓ Contenedor reiniciado"
    else
        echo "✗ Error al reiniciar contenedor"
        exit 1
    fi
}

init_database() {
    echo "► Inicializando base de datos completa..."
    echo "  ADVERTENCIA: Esto recreará todas las tablas"
    echo ""
    read -p "¿Está seguro? (s/n): " confirm
    if [ "$confirm" != "s" ] && [ "$confirm" != "S" ]; then
        echo "Operación cancelada"
        return
    fi

    cat ./scripts/init.osc | docker exec -i "$CONTAINER" iris session IRIS

    if [ $? -eq 0 ]; then
        echo ""
        echo "✓ Base de datos inicializada correctamente"
        echo ""
        echo "Credenciales de acceso:"
        echo "  IRIS Usuario:    ABAP"
        echo "  IRIS Password:   ABAPMYSISS"
        echo "  App Login:       ABAP"
        echo "  App Password:    Admin2025*"
    else
        echo "✗ Error al inicializar base de datos"
        exit 1
    fi
}

compile_classes() {
    echo "► Compilando clases..."
    cat ./scripts/compile.osc | docker exec -i "$CONTAINER" iris session IRIS
    if [ $? -eq 0 ]; then
        echo "✓ Compilación completada"
    else
        echo "✗ Error en compilación"
        exit 1
    fi
}

show_logs() {
    echo "► Mostrando logs (Ctrl+C para salir)..."
    echo ""
    docker logs -f "$CONTAINER"
}

open_shell() {
    echo "► Abriendo shell IRIS..."
    echo "  Namespace: CNET"
    echo "  Escriba 'halt' para salir"
    echo ""
    docker exec -it "$CONTAINER" iris session IRIS -U CNET
}

show_status() {
    echo "► Estado del sistema:"
    echo ""

    # Docker
    echo "Docker:"
    STATUS=$(docker ps --filter "name=$CONTAINER" --format "{{.Status}}" 2>/dev/null)
    if [ -n "$STATUS" ]; then
        echo "  ✓ Contenedor corriendo: $STATUS"
    else
        echo "  ✗ Contenedor no está corriendo"
    fi
    echo ""

    # API
    echo "API REST:"
    HTTP=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:52773/csp/mySissCloud/api/ping 2>/dev/null)
    if [ "$HTTP" = "200" ]; then
        echo "  ✓ API respondiendo (HTTP 200)"
    else
        echo "  ✗ API no responde (HTTP $HTTP)"
    fi
    echo ""

    echo "URLs de acceso:"
    echo "  - Portal IRIS:  http://localhost:52773/csp/sys/UtilHome.csp"
    echo "  - Login:        http://localhost:52773/csp/mySissCloud/mySiss_Cloud_Login.html"
    echo "  - Dashboard:    http://localhost:52773/csp/mySissCloud/mysiss_cloud.html"
    echo "  - API Ping:     http://localhost:52773/csp/mySissCloud/api/ping"
}

case "$COMANDO" in
    start)   start_container ;;
    stop)    stop_container ;;
    restart) restart_container ;;
    init)    init_database ;;
    compile) compile_classes ;;
    logs)    show_logs ;;
    shell)   open_shell ;;
    status)  show_status ;;
    help|*)  show_help ;;
esac

echo ""
echo "========================================"
