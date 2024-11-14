const db = require('./db');

class Agenda {
  static obtenerTodas(callback) {
    db.query('SELECT * FROM agendas', (err, resultados) => {
      if (err) return callback(err);
      callback(null, resultados);
    });
  }

  static crear(datos, callback) {
    const { profesional_id, dias, horarios } = datos;
    db.query('INSERT INTO agendas (profesional_id, dias, horarios) VALUES (?, ?, ?)', 
      [profesional_id, dias, horarios], 
      (err) => {
        if (err) return callback(err);
        callback(null);
      }
    );
  }

  static obtenerPorId(id, callback) {
    db.query('SELECT * FROM agendas WHERE id = ?', [id], (err, resultados) => {
      if (err) return callback(err);
      callback(null, resultados[0]);
    });
  }

  static editar(id, datos, callback) {
    const { profesional_id, dias, horarios } = datos;
    db.query('UPDATE agendas SET profesional_id = ?, dias = ?, horarios = ? WHERE id = ?', 
      [profesional_id, dias, horarios, id], 
      (err) => {
        if (err) return callback(err);
        callback(null);
      }
    );
  }
}

module.exports = Agenda;
