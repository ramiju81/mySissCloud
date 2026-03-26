(function () {
  const byId = (id) => document.getElementById(id);

  async function loadHealth() {
    const data = await window.mySissApi.get('/system/health');
    byId('healthStatus').textContent = data.status;
    byId('healthEngine').textContent = (data.database && data.database.engine) || '-';
    byId('healthMessage').textContent = (data.database && data.database.message) || '-';
  }

  async function loadConfig() {
    const resp = await window.mySissApi.get('/system/config');
    const cfg = resp.data || {};
    byId('environment').value = cfg.environment || 'local';
    byId('database_engine').value = cfg.database_engine || 'iris';
    byId('backend_base_url').value = cfg.backend_base_url || '';
    byId('frontend_base_url').value = cfg.frontend_base_url || '';
    byId('webapp_base_path').value = cfg.webapp_base_path || '';
    byId('database_host').value = cfg.database_host || '';
    byId('database_port').value = cfg.database_port || '';
    byId('database_name').value = cfg.database_name || '';
    byId('database_namespace').value = cfg.database_namespace || '';
  }

  async function saveConfig(evt) {
    evt.preventDefault();
    const payload = {
      environment: byId('environment').value,
      database_engine: byId('database_engine').value,
      backend_base_url: byId('backend_base_url').value,
      frontend_base_url: byId('frontend_base_url').value,
      webapp_base_path: byId('webapp_base_path').value,
      database_host: byId('database_host').value,
      database_port: Number(byId('database_port').value || 0),
      database_name: byId('database_name').value,
      database_namespace: byId('database_namespace').value
    };
    await window.mySissApi.put('/system/config', payload);
    await loadHealth();
    byId('configResult').textContent = 'Configuración guardada.';
  }

  async function loadClients() {
    const resp = await window.mySissApi.get('/ms/clients');
    const tbody = byId('clientsBody');
    tbody.innerHTML = '';
    (resp.data || []).forEach((c) => {
      const tr = document.createElement('tr');
      tr.innerHTML = `<td>${c.id_cliente}</td><td>${c.nombre || ''}</td><td>${c.email || ''}</td><td>${c.activo ? 'Activo' : 'Inactivo'}</td>`;
      tbody.appendChild(tr);
    });
  }

  async function loadModulesCatalog() {
    const resp = await window.mySissApi.get('/ms/modules/catalog');
    byId('moduleCatalogCount').textContent = (resp.data || []).length;
  }

  async function init() {
    byId('configForm').addEventListener('submit', saveConfig);
    await loadHealth();
    await loadConfig();
    await loadClients();
    await loadModulesCatalog();
  }

  window.addEventListener('DOMContentLoaded', init);
})();
