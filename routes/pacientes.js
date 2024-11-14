const express = require('express');
const router = express.Router();
const db = require('../db'); // Asegúrate de tener un archivo de configuración de la base de datos

// Obtener todos los pacientes
router.get('/', (req, res) => {
  db.query('SELECT * FROM pacientes', (err, pacientes) => {
    if (err) throw err;
    res.render('pacientes/index', { pacientes });
  });
});

// Crear un nuevo paciente
router.get('/nuevo', (req, res) => {
  res.render('pacientes/nuevo');
});

router.post('/nuevo', (req, res) => {
  const { nombre, dni, obra_social, contacto } = req.body;

  const query = 'INSERT INTO pacientes (nombre, dni, obra_social, contacto) VALUES (?, ?, ?, ?)';
  db.query(query, [nombre, dni, obra_social, contacto], (err) => {
    if (err) throw err;
    res.redirect('/pacientes');
  });
});

// Editar un paciente
router.get('/:id/editar', (req, res) => {
  const pacienteId = req.params.id;

  db.query('SELECT * FROM pacientes WHERE id = ?', [pacienteId], (err, pacientes) => {
    if (err) throw err;
    if (pacientes.length === 0) return res.status(404).send('Paciente no encontrado');
    res.render('pacientes/editar', { paciente: pacientes[0] });
  });
});

router.post('/:id/editar', (req, res) => {
  const { nombre, dni, obra_social, contacto } = req.body;
  const pacienteId = req.params.id;

  const query = 'UPDATE pacientes SET nombre = ?, dni = ?, obra_social = ?, contacto = ? WHERE id = ?';
  db.query(query, [nombre, dni, obra_social, contacto, pacienteId], (err) => {
    if (err) throw err;
    res.redirect('/pacientes');
  });
});

module.exports = router;
