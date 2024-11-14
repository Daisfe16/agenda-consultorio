const express = require('express');
const router = express.Router();

// Importar controladores
const agendaController = require('../controllers/agendaController');
const turnoController = require('../controllers/turnosController');
const profesionalController = require('../controllers/profesionalController');

router.get('/login', (req, res) => {
    res.render('login'); // Renderizar la vista de login
});

// Ruta principal (homepage)
router.get('/', (req, res) => {
    res.render('index'); // Renderizar la vista de inicio
});

// Rutas para las agendas
router.get('/agendas', agendaController.mostrarAgendas); // Mostrar todas las agendas
router.post('/agendas', agendaController.crearAgenda); // Crear una nueva agenda
router.get('/agendas/:id', agendaController.mostrarAgenda); // Mostrar una agenda específica
router.post('/agendas/edit/:id', agendaController.editarAgenda); // Editar una agenda

// Rutas para los turnos
router.get('/turnos', turnoController.mostrarTurnos); // Mostrar todos los turnos
router.get('/turnos/nuevo', (req, res) => {
    res.render('nuevoTurno'); // Renderizar vista para crear nuevo turno
});
router.post('/turnos', turnoController.crearTurno); // Crear un nuevo turno
router.get('/turnos/:id', turnoController.mostrarTurno); // Ver el detalle del turno
router.get('/turnos/:id/editar', turnoController.mostrarFormularioEditarTurno); // Mostrar el formulario de edición
router.post('/turnos/:id/editar', turnoController.editarTurno); // Procesar la edición

router.post('/turnos/:id/eliminar', turnoController.eliminarTurno); // Eliminar el turno


// Ruta para mostrar la lista de profesionales
router.get('/profesionales', profesionalController.mostrarProfesional);
router.get('/profesionales/nuevo', profesionalController.formularioNuevoProfesional);
router.post('/profesionales/nuevo', profesionalController.crearProfesional);
router.get('/profesionales/:id/editar', profesionalController.formularioEditarProfesional);
router.post('/profesionales/:id/editar', profesionalController.editarProfesional);
router.post('/profesionales/:id/inactivar', profesionalController.inactivarProfesional);
router.post('/profesionales/:id/activar', profesionalController.activarProfesional);
module.exports = router;
