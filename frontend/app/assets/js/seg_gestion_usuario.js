// Esta función ahora solo manejará el cierre de otros menús cuando se abre uno nuevo
function toggleSubmenu(submenuId, linkElement) {
    event.preventDefault();
    event.stopPropagation();
    
    const submenu = document.getElementById(submenuId);
    const isOpening = !submenu.classList.contains('active');
    
    // Alternar el submenú clickeado
    submenu.classList.toggle('active');
    
    // Alternar la flecha
    const icon = linkElement.querySelector('svg');
    if (icon) {
        icon.classList.toggle('rotate-180');
    }
}

// Función para expandir todos los menús y submenús
 function expandAllMenus() {
    // Expandir todos los submenús principales
    document.querySelectorAll('.menu-item > .submenu').forEach(menu => {
        menu.classList.add('active');
        const parentLink = menu.previousElementSibling;
        if (parentLink && parentLink.querySelector('svg')) {
            parentLink.querySelector('svg').classList.add('rotate-180');
        }
    });
    
    // Expandir todos los submenús dentro de módulos
    document.querySelectorAll('#modulos-submenu .submenu').forEach(menu => {
        menu.classList.add('active');
        const parentLink = menu.previousElementSibling;
        if (parentLink && parentLink.querySelector('svg')) {
            parentLink.querySelector('svg').classList.add('rotate-180');
        }
    });
}

function setActiveMenu() {
    const currentPath = window.location.pathname.split('/').pop();
    
    document.querySelectorAll('.nav-link[href]').forEach(link => {
        const linkPath = link.getAttribute('href').split('/').pop();
        if (linkPath === currentPath) {
            link.classList.add('active');
        } else {
            link.classList.remove('active');
        }
    });
}

// Al cargar la página
document.addEventListener('DOMContentLoaded', function() {
//    expandAllMenus(); // Expandir todos los menús al cargar
    setActiveMenu();  // Marcar el menú activo
});
	document.getElementById("devClearBtn").onclick = function() {
		localStorage.clear(); // Borra todo el localStorage
		alert("LocalStorage limpiado ✅");
	};
