(function () {
  const byId = (id) => document.getElementById(id);

  async function ensureAccess() {
    await window.mySissModuleGuard.requireModuleAccess('webservice');
  }

  async function loadClients(selectId) {
    const sel = byId(selectId);
    if (!sel) return;
    const resp = await window.mySissApi.get('/security/catalog/clients');
    sel.innerHTML = '<option value="">Seleccione cliente</option>';
    (resp.data || []).forEach((c) => {
      const o = document.createElement('option');
      o.value = c.id_cliente;
      o.textContent = `${c.id_cliente} - ${c.nombre || ''}`;
      sel.appendChild(o);
    });
  }

  async function loadIntegrations(selectId) {
    const sel = byId(selectId);
    if (!sel) return;
    const resp = await window.mySissApi.get('/ws/integrations');
    sel.innerHTML = '<option value="">Seleccione integración</option>';
    (resp.data || []).forEach((it) => {
      const o = document.createElement('option');
      o.value = it.id_integracion;
      o.textContent = `${it.id_integracion} - ${it.nombre || ''}`;
      sel.appendChild(o);
    });
  }

  async function initMaster() {
    const tbody = byId('wsMasterBody');
    if (!tbody) return;
    const resp = await window.mySissApi.get('/ws/integrations');
    tbody.innerHTML = '';
    (resp.data || []).forEach((it) => {
      const tr = document.createElement('tr');
      tr.innerHTML = `<td>${it.id_integracion}</td><td>${it.nombre || ''}</td><td>${it.metodo_http || ''}</td><td>${it.url_base || ''}${it.endpoint || ''}</td><td>${it.activo ? 'Activo' : 'Inactivo'}</td><td><a href="mySissWSIntegracion.html?id=${it.id_integracion}">Editar</a> | <a href="mySissWSEjecucion.html?id=${it.id_integracion}">Ejecutar</a></td>`;
      tbody.appendChild(tr);
    });
  }

  function currentQueryId() {
    const p = new URLSearchParams(window.location.search);
    return Number(p.get('id') || 0);
  }

  async function initIntegracion() {
    const form = byId('integrationForm');
    if (!form) return;
    await loadClients('integrationClient');
    const id = currentQueryId();
    if (id > 0) {
      const det = await window.mySissApi.get(`/ws/integrations/${id}`);
      const d = det.data || {};
      byId('integrationId').value = d.id_integracion || '';
      byId('nombre').value = d.nombre || '';
      byId('descripcion').value = d.descripcion || '';
      byId('metodo_http').value = d.metodo_http || 'GET';
      byId('url_base').value = d.url_base || '';
      byId('endpoint').value = d.endpoint || '';
      byId('tipo_autenticacion').value = d.tipo_autenticacion || 'NONE';
      byId('headers').value = d.headers || '';
      byId('body_template').value = d.body_template || '';
      byId('timeout').value = d.timeout || 30;
      byId('activo').checked = Number(d.activo || 0) === 1;
    }

    form.addEventListener('submit', async (evt) => {
      evt.preventDefault();
      const payload = {
        nombre: byId('nombre').value,
        descripcion: byId('descripcion').value,
        metodo_http: byId('metodo_http').value,
        url_base: byId('url_base').value,
        endpoint: byId('endpoint').value,
        tipo_autenticacion: byId('tipo_autenticacion').value,
        headers: byId('headers').value,
        body_template: byId('body_template').value,
        timeout: Number(byId('timeout').value || 30),
        activo: byId('activo').checked ? 1 : 0
      };
      const idVal = Number(byId('integrationId').value || 0);
      if (idVal > 0) {
        await window.mySissApi.put(`/ws/integrations/${idVal}`, payload);
      } else {
        const created = await window.mySissApi.post('/ws/integrations', payload);
        byId('integrationId').value = (created.data && created.data.id_integracion) || '';
      }

      const clientId = Number(byId('integrationClient').value || 0);
      if (clientId > 0) {
        const integrationId = Number(byId('integrationId').value || 0);
        await window.mySissApi.put(`/ws/clients/${clientId}/integrations`, {
          items: [{ id_integracion: integrationId, activo: byId('activo').checked ? 1 : 0, configuracion: '' }]
        });
      }

      byId('integrationResult').textContent = 'Integración guardada correctamente.';
    });
  }

  async function loadLogsForExecution() {
    const select = byId('execIntegration');
    const logsBody = byId('logsBody');
    if (!select || !logsBody) return;
    const id = Number(select.value || 0);
    if (id <= 0) {
      logsBody.innerHTML = '';
      return;
    }
    const resp = await window.mySissApi.get(`/ws/logs/integration/${id}`);
    logsBody.innerHTML = '';
    (resp.data || []).slice(0, 20).forEach((l) => {
      const tr = document.createElement('tr');
      tr.innerHTML = `<td>${l.id_log}</td><td>${l.fecha_ejecucion || ''}</td><td>${l.estado || ''}</td><td>${l.codigo_http || ''}</td><td>${l.mensaje || ''}</td>`;
      logsBody.appendChild(tr);
    });
  }

  async function initEjecucion() {
    const form = byId('executionForm');
    if (!form) return;
    await loadClients('execClient');
    await loadIntegrations('execIntegration');
    const id = currentQueryId();
    if (id > 0) {
      byId('execIntegration').value = String(id);
    }
    await loadLogsForExecution();
    byId('execIntegration').addEventListener('change', loadLogsForExecution);

    form.addEventListener('submit', async (evt) => {
      evt.preventDefault();
      const payload = {
        id_integracion: Number(byId('execIntegration').value || 0),
        id_cliente: Number(byId('execClient').value || 0),
        body: byId('execBody').value,
        modulo_origen: 'webservice'
      };
      const resp = await window.mySissApi.post('/ws/execute', payload);
      byId('execResult').textContent = JSON.stringify((resp.data || {}), null, 2);
      await loadLogsForExecution();
    });
  }

  async function init() {
    try {
      await ensureAccess();
      await initMaster();
      await initIntegracion();
      await initEjecucion();
    } catch (e) {
      const box = byId('wsError');
      if (box) box.textContent = (e.payload && e.payload.error) || e.message || 'Error cargando módulo WebService';
    }
  }

  window.addEventListener('DOMContentLoaded', init);
})();
