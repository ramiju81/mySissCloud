function toggleSubmenu(submenuId, linkElement) {
  event.preventDefault();
  event.stopPropagation();
  const submenu = document.getElementById(submenuId);
  submenu.classList.toggle('active');
  const icon = linkElement.querySelector('svg');
  if (icon) icon.classList.toggle('rotate-180');
}

function setActiveMenu() {
  const currentPath = window.location.pathname.split('/').pop();
  document.querySelectorAll('.nav-link[href]').forEach((link) => {
    const linkPath = link.getAttribute('href').split('/').pop();
    link.classList.toggle('active', linkPath === currentPath);
  });
}

async function loadUsers() {
  const resp = await window.mySissApi.get('/security/users');
  const tbody = document.getElementById('usersBody');
  tbody.innerHTML = '';
  (resp.data || []).forEach((u) => {
    const tr = document.createElement('tr');
    tr.innerHTML = `<td>${u.id_user}</td><td>${u.username}</td><td>${u.rol || ''}</td><td>${u.id_cliente || ''}</td><td>${u.status}</td>`;
    tbody.appendChild(tr);
  });
}

async function loadRoles() {
  const resp = await window.mySissApi.get('/security/roles');
  const tbody = document.getElementById('rolesBody');
  const roleSelect = document.getElementById('userRolId');
  tbody.innerHTML = '';
  roleSelect.innerHTML = '<option value="">(sin rol)</option>';
  (resp.data || []).forEach((r) => {
    const tr = document.createElement('tr');
    tr.innerHTML = `<td>${r.id_rol}</td><td>${r.rol}</td><td>${r.status}</td>`;
    tbody.appendChild(tr);
    const op = document.createElement('option');
    op.value = r.id_rol;
    op.textContent = `${r.id_rol} - ${r.rol}`;
    roleSelect.appendChild(op);
  });
}

async function loadClients() {
  const resp = await window.mySissApi.get('/security/catalog/clients');
  const clientSelect = document.getElementById('userClienteId');
  clientSelect.innerHTML = '<option value="">(sin cliente)</option>';
  (resp.data || []).forEach((c) => {
    const op = document.createElement('option');
    op.value = c.id_cliente;
    op.textContent = `${c.id_cliente} - ${c.nombre}`;
    clientSelect.appendChild(op);
  });
}

async function saveUser(evt) {
  evt.preventDefault();
  const id = Number(document.getElementById('userId').value || 0);
  const payload = {
    username: document.getElementById('username').value.trim(),
    nombre: document.getElementById('nombre').value.trim(),
    apellido: document.getElementById('apellido').value.trim(),
    password: document.getElementById('password').value,
    id_cliente: Number(document.getElementById('userClienteId').value || 0),
    id_rol: Number(document.getElementById('userRolId').value || 0)
  };
  if (id > 0) {
    await window.mySissApi.put(`/security/users/${id}`, payload);
  } else {
    await window.mySissApi.post('/security/users', payload);
  }
  evt.target.reset();
  await loadUsers();
}

async function saveRole(evt) {
  evt.preventDefault();
  const id = Number(document.getElementById('roleId').value || 0);
  const payload = { rol: document.getElementById('roleName').value.trim() };
  if (id > 0) {
    await window.mySissApi.put(`/security/roles/${id}`, payload);
  } else {
    await window.mySissApi.post('/security/roles', payload);
  }
  evt.target.reset();
  await loadRoles();
}

async function loadPermissions() {
  const roleId = Number(document.getElementById('permissionsRoleId').value || 0);
  if (!roleId) return;
  const resp = await window.mySissApi.get(`/security/roles/${roleId}/permissions`);
  const list = document.getElementById('permissionsList');
  list.value = JSON.stringify(resp.data || [], null, 2);
}

async function savePermissions(evt) {
  evt.preventDefault();
  const roleId = Number(document.getElementById('permissionsRoleId').value || 0);
  if (!roleId) return;
  const raw = document.getElementById('permissionsList').value.trim();
  const permissions = raw ? JSON.parse(raw) : [];
  await window.mySissApi.put(`/security/roles/${roleId}/permissions`, { permissions });
  await loadPermissions();
}

async function initSecurityAdmin() {
  setActiveMenu();
  document.getElementById('userForm').addEventListener('submit', saveUser);
  document.getElementById('roleForm').addEventListener('submit', saveRole);
  document.getElementById('permissionsForm').addEventListener('submit', savePermissions);
  document.getElementById('permissionsRoleId').addEventListener('change', loadPermissions);
  await loadRoles();
  await loadClients();
  await loadUsers();
}

document.addEventListener('DOMContentLoaded', initSecurityAdmin);
