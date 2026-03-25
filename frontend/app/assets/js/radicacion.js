// Inicializar EmailJS
    (function(){
      emailjs.init("rtkxWaEjprYrEklX4");
    })();

    // Datos de preliquidaciones integrados directamente
    const preliquidaciones = [
      { estado: "Inicial", orden: "", profesional: "López Mario", contrato: "CON000010", caso: "50042", CUPS: "890216", desc_servicio: "CONSULTA DE PRIMERA VEZ POR ESPECIALISTA EN SALUD FAMILIAR Y COMUNITARIA", fecha: "24/04/2025", hora: "09:30 a.m.", aseguradora: "Coomeva EPS", especialidad: "Medicina Interna",  total: 180000, Sociedad: "" },
      { estado: "Inicial", orden: "", profesional: "López Mario", contrato: "CON000010", caso: "50042", CUPS: "890402", desc_servicio: "INTERCONSULTA POR OTRAS ESPECIALIDADES MEDICAS", fecha: "24/04/2025", hora: "09:30 a.m.", aseguradora: "Coomeva EPS", especialidad: "Medicina Interna",  total: 180000, Sociedad: "" },
      { estado: "Inicial", orden: "", profesional: "Orjuela Muñoz Sofia Patricia", contrato: "CON00004", caso: "50043", CUPS: "937101", desc_servicio: "TERAPIA FONOAUDIOLOGICA PARA PROBLEMAS EVOLUTIVOS Y ADQUIRIDOS DEL LENGUAJE ORAL Y ESCRITO", fecha: "24/04/2025", hora: "09:30 a.m.", aseguradora: "SURA EPS", especialidad: "Fonoaudiología", total: 210000, Sociedad: "Terapistas Asociados" },
      { estado: "Inicial", orden: "", profesional: "Orjuela Muñoz Sofia Patricia", contrato: "CON00004", caso: "50043", CUPS: "937101", desc_servicio: "TERAPIA FONOAUDIOLOGICA PARA PROBLEMAS EVOLUTIVOS Y ADQUIRIDOS DEL LENGUAJE ORAL Y ESCRITO", fecha: "24/04/2025", hora: "09:30 a.m.", aseguradora: "SURA EPS", especialidad: "Fonoaudiología", total: 210000, Sociedad: "Terapistas Asociados" },
      { estado: "Inicial", orden: "", profesional: "Orjuela Muñoz Sofia Patricia", contrato: "CON00004", caso: "50044", CUPS: "937101", desc_servicio: "TERAPIA FONOAUDIOLOGICA PARA PROBLEMAS EVOLUTIVOS Y ADQUIRIDOS DEL LENGUAJE ORAL Y ESCRITO", fecha: "25/04/2025", hora: "09:30 a.m.", aseguradora: "Comfenalco", especialidad: "Fonoaudiología", total: 210000, Sociedad: "Terapistas Asociados" },
      { estado: "Inicial", orden: "", profesional: "Orjuela Muñoz Sofia Patricia", contrato: "CON00004", caso: "50044", CUPS: "937101", desc_servicio: "TERAPIA FONOAUDIOLOGICA PARA PROBLEMAS EVOLUTIVOS Y ADQUIRIDOS DEL LENGUAJE ORAL Y ESCRITO", fecha: "25/04/2025", hora: "09:30 a.m.", aseguradora: "Comfenalco", especialidad: "Fonoaudiología", total: 210000, Sociedad: "Terapistas Asociados" },
      { estado: "Inicial", orden: "027", profesional: "Ramirez Julian", contrato: "CON000027", caso: "50045", CUPS: "870005", desc_servicio: "RADIOGRAFIA DE MASTOIDES COMPARATIVAS", fecha: "26/04/2025", hora: "09:30 a.m.", aseguradora: "Nueva EPS", especialidad: "Radiología", total: 270000, Sociedad: "Radiologos Asociados" },
      { estado: "Inicial", orden: "027", profesional: "Ramirez Julian", contrato: "CON000022", caso: "50008", CUPS: "890202", desc_servicio: "CONSULTA DE PRIMERA VEZ POR OTRAS ESPECIALIDADES MEDICAS", fecha: "6/04/2025", hora: "09:30 a.m.", aseguradora: "Nueva EPS", especialidad: "Medicina Interna",  total: 180000, Sociedad: "" },
      { estado: "Inicial", orden: "", profesional: "Ramirez Julian", contrato: "CON000018", caso: "50009", CUPS: "890201", desc_servicio: "CONSULTA DE PRIMERA VEZ POR MEDICINA GENERAL", fecha: "7/04/2025", hora: "08:30 a.m.", aseguradora: "Nueva EPS", especialidad: "Medicina Interna", total: 200000, Sociedad: "" },
      { estado: "Inicial", orden: "", profesional: "Palacio Yeny", contrato: "CON000001", caso: "50012", CUPS: "890202", desc_servicio: "CONSULTA DE PRIMERA VEZ POR OTRAS ESPECIALIDADES MEDICAS", fecha: "9/04/2025", hora: "10:00 a.m.", aseguradora: "SURA EPS", especialidad: "Cardiología", total: 220000, Sociedad: "Cardiologos Asociados" },
      { estado: "Inicial", orden: "", profesional: "Palacio Yeny", contrato: "CON000002", caso: "50013", CUPS: "510301", desc_servicio: "DRENAJE BILIAR VIA PERCUTANEA Y COLOCACION DE DISPOSITIVO", fecha: "10/04/2025", hora: "11:00 a.m.", aseguradora: "SURA EPS", especialidad: "Cardiología", total: 350000, Sociedad: "Cardiologos Asociados" },
      { estado: "Inicial", orden: "", profesional: "López Mario", contrato: "CON000012", caso: "50014", CUPS: "881302", desc_servicio: "ECOGRAFIA DE ABDOMEN TOTAL", fecha: "11/04/2025", hora: "12:00 m.", aseguradora: "Coomeva EPS", especialidad: "Radiología", total: 300000, Sociedad: "Radiologos Asociados" },
      { estado: "Inicial", orden: "", profesional: "López Mario", contrato: "CON000012", caso: "50015", CUPS: "870005", desc_servicio: "RADIOGRAFIA DE MASTOIDES COMPARATIVAS", fecha: "12/04/2025", hora: "01:00 p.m.", aseguradora: "Coomeva EPS", especialidad: "Radiología", total: 250000, Sociedad: "Radiologos Asociados" },
      { estado: "Inicial", orden: "", profesional: "Reyes Camila", contrato: "CON000045", caso: "50016", CUPS: "890207", desc_servicio: "Terapia física", fecha: "13/04/2025", hora: "08:00 a.m.", aseguradora: "SURA EPS", especialidad: "Fisioterapia",  total: 180000, Sociedad: "Terapistas Asociados" },
      { estado: "Inicial", orden: "", profesional: "Reyes Camila", contrato: "CON000045", caso: "50017", CUPS: "890208", desc_servicio: "Terapia ocupacional", fecha: "14/04/2025", hora: "09:00 a.m.", aseguradora: "SURA EPS", especialidad: "Fisioterapia", total: 190000, Sociedad: "Terapistas Asociados" },
      { estado: "Inicial", orden: "", profesional: "Ortega Juan", contrato: "CON000033", caso: "50018", CUPS: "890201", desc_servicio: "CONSULTA DE PRIMERA VEZ POR MEDICINA GENERAL", fecha: "15/04/2025", hora: "10:00 a.m.", aseguradora: "Nueva EPS", especialidad: "Medicina Interna",  total: 180000, Sociedad: "" },
      { estado: "Inicial", orden: "", profesional: "Ortega Juan", contrato: "CON000033", caso: "50019", CUPS: "345002", desc_servicio: "TORACENTESIS DE DRENAJE O DESCOMPRESIVA", fecha: "16/04/2025", hora: "11:00 a.m.", aseguradora: "Coomeva EPS", especialidad: "Medicina Interna", total: 100000, Sociedad: "" },
      { estado: "Inicial", orden: "", profesional: "Orjuela Muñoz Sofia Patricia", contrato: "CON00004", caso: "50020", CUPS: "890201", desc_servicio: "CONSULTA DE PRIMERA VEZ POR MEDICINA GENERAL", fecha: "17/04/2025", hora: "08:30 a.m.", aseguradora: "Nueva EPS", especialidad: "Medicina General", total: 190000, Sociedad: "" },
      { estado: "Inicial", orden: "", profesional: "Orjuela Muñoz Sofia Patricia", contrato: "CON00004", caso: "50021", CUPS: "937101", desc_servicio: "TERAPIA FONOAUDIOLOGICA PARA PROBLEMAS EVOLUTIVOS Y ADQUIRIDOS DEL LENGUAJE ORAL Y ESCRITO", fecha: "18/04/2025", hora: "09:00 a.m.", aseguradora: "SURA EPS", especialidad: "Fonoaudiología", total: 210000, Sociedad: "Terapistas Asociados" },
      { estado: "Inicial", orden: "", profesional: "Palacio Yeny", contrato: "CON000001", caso: "50022", CUPS: "890201", desc_servicio: "CONSULTA DE PRIMERA VEZ POR MEDICINA GENERAL", fecha: "19/04/2025", hora: "10:00 a.m.", aseguradora: "Comfenalco", especialidad: "Medicina Interna", total: 150000, Sociedad: "" },
      { estado: "Inicial", orden: "", profesional: "Palacio Yeny", contrato: "CON000002", caso: "50023", CUPS: "939403", desc_servicio: "TERAPIA RESPIRATORIA INTEGRAL", fecha: "20/04/2025", hora: "11:00 a.m.", aseguradora: "Coomeva EPS", especialidad: "Fisioterapia", total: 200000, Sociedad: "Terapistas Asociados" },
      { estado: "Inicial", orden: "", profesional: "López Mario", contrato: "CON000010", caso: "50024", CUPS: "890202", desc_servicio: "CONSULTA DE PRIMERA VEZ POR OTRAS ESPECIALIDADES MEDICAS", fecha: "21/04/2025", hora: "12:00 m.", aseguradora: "SURA EPS", especialidad: "Cardiología", total: 220000, Sociedad: "Cardiologos Asociados" },
      { estado: "Inicial", orden: "", profesional: "López Mario", contrato: "CON000010", caso: "50025", CUPS: "890402", desc_servicio: "INTERCONSULTA POR OTRAS ESPECIALIDADES MEDICAS", fecha: "22/04/2025", hora: "01:00 p.m.", aseguradora: "Nueva EPS", especialidad: "Medicina Interna",  total: 180000, Sociedad: "" },
      { estado: "Inicial", orden: "", profesional: "Reyes Camila", contrato: "CON000045", caso: "50026", CUPS: "890216", desc_servicio: "Terapia física", fecha: "23/04/2025", hora: "08:00 a.m.", aseguradora: "SURA EPS", especialidad: "Fisioterapia", total: 200000, Sociedad: "Terapistas Asociados" },
      { estado: "Inicial", orden: "", profesional: "Reyes Camila", contrato: "CON000045", caso: "50027", CUPS: "890217", desc_servicio: "Terapia ocupacional", fecha: "23/04/2025", hora: "09:00 a.m.", aseguradora: "SURA EPS", especialidad: "Fisioterapia", total: 190000, Sociedad: "Terapistas Asociados" },
      { estado: "Inicial", orden: "027", profesional: "Ramirez Julian", contrato: "CON000022", caso: "50028", CUPS: "890202", desc_servicio: "CONSULTA DE PRIMERA VEZ POR OTRAS ESPECIALIDADES MEDICAS", fecha: "23/04/2025", hora: "10:00 a.m.", aseguradora: "Nueva EPS", especialidad: "Medicina Interna",  total: 180000, Sociedad: "" },
      { estado: "Inicial", orden: "027", profesional: "Ramirez Julian", contrato: "CON000027", caso: "50029", CUPS: "870005", desc_servicio: "RADIOGRAFIA DE MASTOIDES COMPARATIVAS", fecha: "23/04/2025", hora: "11:00 a.m.", aseguradora: "Coomeva EPS", especialidad: "Radiología", total: 270000, Sociedad: "Radiologos Asociados" },
      { estado: "Inicial", orden: "", profesional: "Palacio Yeny", contrato: "CON000002", caso: "50030", CUPS: "510301", desc_servicio: "DRENAJE BILIAR VIA PERCUTANEA Y COLOCACION DE DISPOSITIVO", fecha: "23/04/2025", hora: "01:00 p.m.", aseguradora: "SURA EPS", especialidad: "Cirugía Ambulatoria", total: 400000, Sociedad: "Anestesia center group" },
      { estado: "Inicial", orden: "", profesional: "Palacio Yeny", contrato: "CON000001", caso: "50031", CUPS: "890202", desc_servicio: "CONSULTA DE PRIMERA VEZ POR OTRAS ESPECIALIDADES MEDICAS", fecha: "23/04/2025", hora: "02:00 p.m.", aseguradora: "Coomeva EPS", especialidad: "Cardiología", total: 220000, Sociedad: "Cardiologos Asociados" },
      { estado: "Inicial", orden: "", profesional: "Ortega Juan", contrato: "CON000033", caso: "50032", CUPS: "345002", desc_servicio: "TORACENTESIS DE DRENAJE O DESCOMPRESIVA", fecha: "23/04/2025", hora: "03:00 p.m.", aseguradora: "Nueva EPS", especialidad: "Medicina Interna", total: 110000, Sociedad: "" },
      { estado: "Inicial", orden: "", profesional: "Ortega Juan", contrato: "CON000033", caso: "50033", CUPS: "890201", desc_servicio: "CONSULTA DE PRIMERA VEZ POR MEDICINA GENERAL", fecha: "23/04/2025", hora: "04:00 p.m.", aseguradora: "Nueva EPS", especialidad: "Medicina General",  total: 180000, Sociedad: "" },
      { estado: "Inicial", orden: "", profesional: "Orjuela Muñoz Sofia Patricia", contrato: "CON00004", caso: "50034", CUPS: "937101", desc_servicio: "TERAPIA FONOAUDIOLOGICA PARA PROBLEMAS EVOLUTIVOS Y ADQUIRIDOS DEL LENGUAJE ORAL Y ESCRITO", fecha: "23/04/2025", hora: "08:30 a.m.", aseguradora: "SURA EPS", especialidad: "Fonoaudiología", total: 210000, Sociedad: "Terapistas Asociados" },
      { estado: "Inicial", orden: "", profesional: "Gómez Laura", contrato: "CON00005", caso: "50035", CUPS: "939403", desc_servicio: "TERAPIA RESPIRATORIA INTEGRAL", fecha: "23/04/2025", hora: "09:30 a.m.", aseguradora: "Coomeva EPS", especialidad: "Fisioterapia", total: 120000, Sociedad: "Terapistas Asociados" },
      { estado: "Inicial", orden: "", profesional: "López Mario", contrato: "CON000010", caso: "50036", CUPS: "890402", desc_servicio: "INTERCONSULTA POR OTRAS ESPECIALIDADES MEDICAS", fecha: "23/04/2025", hora: "10:30 a.m.", aseguradora: "Nueva EPS", especialidad: "Medicina Interna",  total: 180000, Sociedad: "" },
      { estado: "Inicial", orden: "", profesional: "López Mario", contrato: "CON000012", caso: "50037", CUPS: "881302", desc_servicio: "ECOGRAFIA DE ABDOMEN TOTAL", fecha: "23/04/2025", hora: "11:30 a.m.", aseguradora: "SURA EPS", especialidad: "Radiología", total: 320000, Sociedad: "Radiologos Asociados" },
      { estado: "Inicial", orden: "", profesional: "Reyes Camila", contrato: "CON000045", caso: "50038", CUPS: "890228", desc_servicio: "Terapia física", fecha: "23/04/2025", hora: "01:30 p.m.", aseguradora: "Coomeva EPS", especialidad: "Fisioterapia", total: 190000, Sociedad: "Terapistas Asociados" },
      { estado: "Inicial", orden: "", profesional: "Reyes Camila", contrato: "CON000045", caso: "50039", CUPS: "890229", desc_servicio: "Terapia ocupacional", fecha: "23/04/2025", hora: "02:30 p.m.", aseguradora: "Coomeva EPS", especialidad: "Fisioterapia",  total: 180000, Sociedad: "Terapistas Asociados" },
      { estado: "Inicial", orden: "027", profesional: "Ramirez Julian", contrato: "CON000027", caso: "50040", CUPS: "870005", desc_servicio: "RADIOGRAFIA DE MASTOIDES COMPARATIVAS", fecha: "23/04/2025", hora: "03:30 p.m.", aseguradora: "Nueva EPS", especialidad: "Radiología", total: 250000, Sociedad: "Radiologos Asociados" }
    ];

    // Datos de liquidaciones integrados directamente
    const liquidaciones = [
      { estado: "APROBADO", orden: "027", profesional: "Ramirez Julian", contrato: "CON000027", caso: "50045", CUPS: "870005", desc_servicio: "RADIOGRAFIA DE MASTOIDES COMPARATIVAS", fecha: "26/04/2025", hora: "09:30 a.m.", aseguradora: "Nueva EPS", especialidad: "Radiología", total: 270000, Sociedad: "Radiologos Asociados" },
      { estado: "APROBADO", orden: "027", profesional: "Ramirez Julian", contrato: "CON000022", caso: "50008", CUPS: "890202", desc_servicio: "CONSULTA DE PRIMERA VEZ POR OTRAS ESPECIALIDADES MEDICAS", fecha: "6/04/2025", hora: "09:30 a.m.", aseguradora: "Nueva EPS", especialidad: "Medicina Interna",  total: 180000, Sociedad: "" },
      { estado: "APROBADO", orden: "027", profesional: "Ramirez Julian", contrato: "CON000022", caso: "50028", CUPS: "890202", desc_servicio: "CONSULTA DE PRIMERA VEZ POR OTRAS ESPECIALIDADES MEDICAS", fecha: "23/04/2025", hora: "10:00 a.m.", aseguradora: "Nueva EPS", especialidad: "Medicina Interna",  total: 180000, Sociedad: "" },
      { estado: "APROBADO", orden: "027", profesional: "Ramirez Julian", contrato: "CON000027", caso: "50029", CUPS: "870005", desc_servicio: "RADIOGRAFIA DE MASTOIDES COMPARATIVAS", fecha: "23/04/2025", hora: "11:00 a.m.", aseguradora: "Coomeva EPS", especialidad: "Radiología", total: 270000, Sociedad: "Radiologos Asociados" }
    ];

    // Variables para el contador de liquidaciones
    let contadorLiquidaciones = 15; // Empezamos en LQ015

    // Obtener radios y secciones
    const radioPre = document.getElementById("pre");
    const radioLiq = document.getElementById("liq");
    const seccionPre = document.getElementById("preliquidacion-section");
    const seccionLiq = document.getElementById("liquidacion-section");
    let datosActuales = [];

    // Función para obtener fecha/hora actual
    function getCurrentDateTime() {
      const now = new Date();
      const year = now.getFullYear();
      const month = String(now.getMonth() + 1).padStart(2, '0');
      const day = String(now.getDate()).padStart(2, '0');
      const fecha = `${year}-${month}-${day}`;
      let hours = now.getHours() + 2;
      const ampm = hours >= 12 ? 'p.m.' : 'a.m.';
      hours = hours % 12;
      hours = hours ? hours : 12;
      const minutes = String(now.getMinutes()).padStart(2, '0');
      const hora = `${hours}:${minutes} ${ampm}`;
      return { fecha, hora };
    }

    // Función para enviar correo
    function enviarCorreo() {
      const templateParams = {
        to_email: 'medico.gral41@gmail.com'
      };

      emailjs.send('service_90kj5s7', 'template_e6fp56h', templateParams)
        .then(function(response) {
          alert("Correos enviados con éxito ✔️");
        }, function(error) {
          alert("Error al enviar los correos ❌: " + JSON.stringify(error));
        });
    }

    // Función para generar tabla
    function generarTabla(datos) {
      const container = document.getElementById("resultados");
      datosActuales = datos;

      const formatNumber = num => new Intl.NumberFormat('es-CO').format(num);

      const tablaHTML = `
        <h3>${radioPre.checked ? 'Preliquidaciones' : 'Liquidaciones'}</h3>
        <table>
          <thead>
            <tr>
              <th class="col-select"><input type="checkbox" id="selectAllHead"></th>
              <th>Estado</th>
              <th>Orden</th>
              <th>Profesional</th>
              <th>Contrato</th>
              <th>Caso</th>
              <th>Cód. Servicio</th>
              <th>Desc. Servicio</th>
              <th>Fecha</th>
              <th>Hora</th>
              <th>Aseguradora</th>
              <th>Especialidad</th>
              <th>Total</th>
            </tr>
          </thead>
          <tbody id="tabla-body">
            ${datos.map((item, index) => `
              <tr data-index="${index}">
                <td class="col-select"><input type="checkbox" class="row-checkbox"></td>
                <td class="estado-cell">${item.estado}</td>
                <td class="orden-cell">${radioPre.checked ? '' : item.orden}</td>
                <td>${item.profesional}</td>
                <td>${item.contrato}</td>
                <td>${item.caso}</td>
                <td>${item.CUPS}</td>
                <td>${item.desc_servicio}</td>
                <td>${item.fecha}</td>
                <td>${item.hora}</td>
                <td>${item.aseguradora}</td>
                <td>${item.especialidad}</td>
                <td>$${formatNumber(item.total)}</td>
              </tr>
            `).join("")}
          </tbody>
          <tfoot>
            <tr>
              <td colspan="12"><strong>Totales</strong></td>
              <td>$${formatNumber(datos.reduce((sum, item) => sum + (item.total || 0), 0))}</td>
            </tr>
          </tfoot>
        </table>
      `;

      container.innerHTML = tablaHTML;
      localStorage.setItem('datosTabla', JSON.stringify(datos));

      // Evento seleccionar todo
      document.getElementById("selectAllHead").addEventListener("change", function() {
        const isChecked = this.checked;
        document.querySelectorAll(".row-checkbox").forEach(cb => cb.checked = isChecked);
      });
    }

    // Función para filtrar datos
    function filtrarDatos() {
      const fechaInicio = radioPre.checked ? document.getElementById("fechaInicioPre").value : document.getElementById("fechaInicioLiq").value;
      const fechaFin = radioPre.checked ? document.getElementById("fechaFinPre").value : document.getElementById("fechaFinLiq").value;
      const aseguradora = document.getElementById("aseguradoraSelect").value;
      const tipoContrato = document.getElementById("tipoContrato").value;
      const especialidad = document.getElementById("especialidad").value;
      const profesional = document.getElementById("profesionalSelect").value;
      const orden = document.getElementById("ordenInput") ? document.getElementById("ordenInput").value : "";

      let datosFiltrados = radioPre.checked ? preliquidaciones : liquidaciones;
      
      datosFiltrados = datosFiltrados.filter(item => {
        if (fechaInicio && new Date(item.fecha.split('/').reverse().join('-')) < new Date(fechaInicio)) return false;
        if (fechaFin && new Date(item.fecha.split('/').reverse().join('-')) > new Date(fechaFin)) return false;
        if (aseguradora && item.aseguradora !== aseguradora) return false;
        if (profesional && item.profesional !== profesional) return false;
        if (orden && item.orden !== orden) return false;
        const especialidadVisible = document.getElementById("especialidadGrupo").style.display !== "none";
        if (especialidadVisible && especialidad && item.especialidad !== especialidad) return false;
        return true;
      });

      generarTabla(datosFiltrados);
    }

    // Función para mostrar/ocultar especialidad
    function mostrarEspecialidad(valor) {
      const divEsp = document.getElementById("especialidadGrupo");
      divEsp.style.display = valor === "grupo" ? "flex" : "none";
    }

    // Función para actualizar estados
    function gen_Accion(tipo) {
      const filas = document.querySelectorAll("#tabla-body tr");
      let cambios = false;
      
      filas.forEach((fila, index) => {
        const checkbox = fila.querySelector(".row-checkbox");
        if (checkbox && checkbox.checked) {
          cambios = true;
          const estadoCell = fila.querySelector(".estado-cell");
          const ordenCell = fila.querySelector(".orden-cell");
          
          if (tipo === 'pre') {
            estadoCell.innerText = "Preliquidado";
            // Buscar el registro original para obtener el orden si existe
            const registroOriginal = preliquidaciones.find(item => 
              item.profesional === datosActuales[index].profesional && 
              item.contrato === datosActuales[index].contrato && 
              item.caso === datosActuales[index].caso
            );
            ordenCell.innerText = registroOriginal?.orden || "";
          } else {
            estadoCell.innerText = "Liquidado";
            // Generar número de orden secuencial
            const numeroOrden = "LQ" + String(contadorLiquidaciones).padStart(3, '0');
            ordenCell.innerText = numeroOrden;
            contadorLiquidaciones++; // Incrementamos para el próximo
          }
        }
      });
      
      if (cambios) {
        enviarCorreo();
      } else {
        alert("Por favor seleccione al menos un registro para " + (tipo === 'pre' ? 'preliquidar' : 'liquidar'));
      }
    }

    // Evento al cargar página
    document.addEventListener('DOMContentLoaded', function() {
      const fechaInicioPre = document.getElementById("fechaInicioPre");
      const fechaFinPre = document.getElementById("fechaFinPre");
      const periodoPre = document.getElementById("periodoPre");
      const fechaInicioLiq = document.getElementById("fechaInicioLiq");
      const fechaFinLiq = document.getElementById("fechaFinLiq");
      const periodoLiq = document.getElementById("periodoLiq");

      const fechaInicioAbril = "2025-04-01";
      const fechaFinAbril = "2025-04-30";

      // Establecer valores por defecto
      if (fechaInicioPre) fechaInicioPre.value = fechaInicioAbril;
      if (fechaFinPre) fechaFinPre.value = fechaFinAbril;
      if (periodoPre) periodoPre.value = 4;
      if (fechaInicioLiq) fechaInicioLiq.value = fechaInicioAbril;
      if (fechaFinLiq) fechaFinLiq.value = fechaFinAbril;
      if (periodoLiq) periodoLiq.value = 4;

      function validarFechas(inputInicio, inputFin, inputPeriodo) {
        if (inputInicio.value !== fechaInicioAbril || inputFin.value !== fechaFinAbril) {
          alert("Periodo cerrado ❌. Solo se permiten fechas dentro de abril.");
          inputInicio.value = fechaInicioAbril;
          inputFin.value = fechaFinAbril;
          inputPeriodo.value = 4;
        }
      }

      if (fechaInicioPre) {
        fechaInicioPre.addEventListener("change", () => validarFechas(fechaInicioPre, fechaFinPre, periodoPre));
      }
      if (fechaFinPre) {
        fechaFinPre.addEventListener("change", () => validarFechas(fechaInicioPre, fechaFinPre, periodoPre));
      }
      if (periodoPre) {
        periodoPre.addEventListener("change", () => {
          if (periodoPre.value != 4) {
            alert("Periodo cerrado ❌. Solo se permite el periodo 4.");
            periodoPre.value = 4;
          }
        });
      }

      if (fechaInicioLiq) {
        fechaInicioLiq.addEventListener("change", () => validarFechas(fechaInicioLiq, fechaFinLiq, periodoLiq));
      }
      if (fechaFinLiq) {
        fechaFinLiq.addEventListener("change", () => validarFechas(fechaInicioLiq, fechaFinLiq, periodoLiq));
      }
      if (periodoLiq) {
        periodoLiq.addEventListener("change", () => {
          if (periodoLiq.value != 4) {
            alert("Periodo cerrado ❌. Solo se permite el periodo 4.");
            periodoLiq.value = 4;
          }
        });
      }

      if (radioPre.checked) {
        seccionPre.classList.remove("hidden");
        seccionLiq.classList.add("hidden");
        generarTabla(preliquidaciones);
      } else if (radioLiq.checked) {
        seccionLiq.classList.remove("hidden");
        seccionPre.classList.add("hidden");
        generarTabla(liquidaciones);
      }

      radioPre.addEventListener("change", () => {
        seccionPre.classList.remove("hidden");
        seccionLiq.classList.add("hidden");
        generarTabla(preliquidaciones);
      });

      radioLiq.addEventListener("change", () => {
        seccionLiq.classList.remove("hidden");
        seccionPre.classList.add("hidden");
        generarTabla(liquidaciones);
      });
    });
// ===== Toggle Submenú Radicación (compacto y solo por click) =====
document.addEventListener('DOMContentLoaded', function () {
  const linkRad = document.getElementById('radicacion-link');
  const subRad  = document.getElementById('submenu-radicacion');
  if (!linkRad || !subRad) return;

  // Mostrar/ocultar SOLO por click en "Radicación facturas"
  linkRad.addEventListener('click', function (e) {
    e.preventDefault();
    const isVisible = subRad.style.display === 'flex';
    subRad.style.display = isVisible ? 'none' : 'flex';
  });

  // Cierra si haces click fuera de la barra lateral (opcional)
  document.addEventListener('click', function (e) {
    const sidebar = document.querySelector('.sidebar');
    if (!sidebar) return;
    if (!sidebar.contains(e.target)) {
      subRad.style.display = 'none';
    }
  });
});
