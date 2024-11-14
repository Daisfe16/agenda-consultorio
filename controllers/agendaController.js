const Agenda = require('../models/agenda');

// Mostrar todas las agendas
exports.mostrarAgendas = (req, res) => {
  Agenda.obtenerTodas((err, agendas) => {
    if (err) {
      return res.status(500).send('Error al obtener agendas.');
    }
    res.render('agendas', { agendas });
  });
};

// Crear una nueva agenda
exports.crearAgenda = (req, res) => {
  const agendaData = req.body;
  Agenda.crear(agendaData, (err) => {
    if (err) {
      return res.status(500).send('Error al crear agenda.');
    }
    res.redirect('/agendas'); // Redirige a la lista de agendas
  });
};

// Mostrar una agenda específica
exports.mostrarAgenda = (req, res) => {
  const agendaId = req.params.id;
  Agenda.obtenerPorId(agendaId, (err, agenda) => {
    if (err || !agenda) {
      return res.status(404).send('Agenda no encontrada.');
    }
    res.render('agenda', { agenda });
  });
};

// Editar una agenda
exports.editarAgenda = (req, res) => {
  const agendaId = req.params.id;
  const agendaData = req.body;
  Agenda.editar(agendaId, agendaData, (err) => {
    if (err) {
      return res.status(500).send('Error al editar agenda.');
    }
    res.redirect('/agendas');
  });
};
