// controllers/profesionalesController.js
const Profesional = require('../models/Profesional');

// Mostrar todos los profesionales
exports.mostrarProfesional = (req, res) => {
  Profesional.obtenerTodos((err, profesionales) => {
    if (err) return res.status(500).send('Error al obtener los profesionales');
    res.render('listaProfesional', { profesionales });
  });
};

/// Mostrar formulario para crear un nuevo profesional
exports.formularioNuevoProfesional = (req, res) => {
  Profesional.obtenerEspecialidades((err, especialidades) => {
    if (err) return res.status(500).send('Error al obtener especialidades');
    res.render('nuevoProfesional', { especialidades });
  });
};

// Crear un nuevo profesional
exports.crearProfesional = (req, res) => {
  const { nombre_completo, matricula } = req.body;
  let { especialidades } = req.body;

  // Asegurar que especialidades sea un array
  if (!Array.isArray(especialidades)) {
    especialidades = [especialidades];
  }

  Profesional.crear({ nombre: nombre_completo, matricula, especialidades }, (err) => {
    if (err) return res.status(500).send('Error al crear profesional');
    res.redirect('/profesionales');
  });
};

// Formulario para editar un profesional existente
exports.formularioEditarProfesional = (req, res) => {
  const profesionalId = req.params.id;
  Profesional.obtenerPorId(profesionalId, (err, profesional) => {
    if (err) return res.status(500).send('Error al obtener el profesional');
    
    Profesional.obtenerEspecialidades((err, especialidades) => {
      if (err) return res.status(500).send('Error al obtener especialidades');
      res.render('editarProfesional', { profesional, especialidades });
    });
  });
};

exports.editarProfesional = (req, res) => {
  const profesionalId = req.params.id;
  const { nombre_completo, matricula } = req.body;
  let { especialidades } = req.body;

  // Convertir a array si especialidades es un solo valor
  if (!Array.isArray(especialidades)) {
    especialidades = [especialidades];
  }

  Profesional.editar(profesionalId, { nombre: nombre_completo, matricula, especialidades }, (err) => {
    if (err) return res.status(500).send('Error al editar el profesional');
    res.redirect('/profesionales');
  });
};
exports.inactivarProfesional = (req, res) => {
  const profesionalId = req.params.id;
  Profesional.inactivar(profesionalId, (err) => {
    if (err) return res.status(500).send('Error al inactivar el profesional');
    res.redirect('/profesionales');
  });
};

exports.activarProfesional = (req, res) => {
  const profesionalId = req.params.id;
  Profesional.activar(profesionalId, (err) => {
    if (err) return res.status(500).send('Error al activar el profesional');
    res.redirect('/profesionales');
  });
};
