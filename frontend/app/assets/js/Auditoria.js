function navigateTo(page) {
					  switch (page) {
						case 'configuracion':
						window.location.href ='Configuracion/ConfiguracionN.html';
						break;
						case 'auditoria-concurrente':
						window.location.href ='Concurrente/Aconcurrente.html';
						break;
						case 'cuentas-medicas':
						window.location.href='Cuentas medicas/AcuentasM.html';
						break;
					  default:
						alert("Estamos trabajando en ello");
					  }            
					
					// OPCIÓN 2: Abrir en nueva pestaña (descomenta para usar)
					// window.open(page + '.html', '_blank');
					
					// OPCIÓN 3: Cambiar URL sin recargar página (descomenta para usar)
					// history.pushState(null, null, page);
					
					// OPCIÓN 4: Navegación con confirmación (descomenta para usar)
					// if (confirm('¿Deseas navegar a ' + page + '?')) {
					//     window.location.href = page + '.html';
					// }
					
					// Alerta temporal para demostrar funcionalidad (eliminar en producción)
					/*alert('Navegando a: ' + page);*/
				}

				document.addEventListener('DOMContentLoaded', function() {
					// Obtener todas las tarjetas del menú
					const cards = document.querySelectorAll('.menu-card');
					
					// Aplicar animación de entrada a cada tarjeta
					cards.forEach((card, index) => {
						// Estado inicial: invisible y desplazada hacia abajo
						card.style.opacity = '0';
						card.style.transform = 'translateY(20px)';
						
						// Aplicar animación con retraso escalonado
						setTimeout(() => {
							// Definir transiciones CSS
							card.style.transition = 'opacity 0.5s, transform 0.5s';
							// Estado final: visible y en posición normal
							card.style.opacity = '1';
							card.style.transform = 'translateY(0)';
						}, index * 200); // Retraso de 200ms entre cada tarjeta
					});
					
					// Opcional: Agregar listener para teclas del teclado
					document.addEventListener('keydown', function(event) {
						// Navegación con teclas numéricas
						switch(event.key) {
							case '1':
								navigateTo('auditoria-calidad');
								break;
							case '2':
								navigateTo('auditoria-concurrente');
								break;
							case '3':
								navigateTo('cuentas-medicas');
								break;
							case 'c':
							case 'C':
								navigateTo('configuracion');
								break;
						}
					});
				});


				function handleImageError(img) {
					// Imagen de respaldo en caso de error
					img.src = 'data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iNTAwIiBoZWlnaHQ9IjMwMCIgdmlld0JveD0iMCAwIDUwMCAzMDAiIGZpbGw9Im5vbmUiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyI+CjxyZWN0IHdpZHRoPSI1MDAiIGhlaWdodD0iMzAwIiBmaWxsPSIjRjNGNEY2Ii8+Cjx0ZXh0IHg9IjI1MCIgeT0iMTUwIiB0ZXh0LWFuY2hvcj0ibWlkZGxlIiBmaWxsPSIjOUI5QkEzIiBmb250LWZhbWlseT0iQXJpYWwiIGZvbnQtc2l6ZT0iMTgiPkltYWdlbiBubyBkaXNwb25pYmxlPC90ZXh0Pgo8L3N2Zz4K';
					console.log('Error cargando imagen, usando imagen de respaldo');
				}


				function toggleTheme() {
					const body = document.body;
					body.classList.toggle('dark-theme');
					
					// Guardar preferencia en localStorage
					const isDark = body.classList.contains('dark-theme');
					localStorage.setItem('darkTheme', isDark);
				}

				function loadSavedTheme() {
					const savedTheme = localStorage.getItem('darkTheme');
					if (savedTheme === 'true') {
						document.body.classList.add('dark-theme');
					}
				}

				// Cargar tema guardado al cargar la página
				loadSavedTheme();
