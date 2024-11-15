const db = require('./Db');

class Profesional {
  // Obtener todos los profesionales con sus especialidades
  static obtenerTodos(callback) {
    const query = `
      SELECT p.id, p.nombre_completo, p.estado, p.matricula, GROUP_CONCAT(e.nombre) AS especialidades
      FROM profesionales p
      LEFT JOIN profesional_especialidad pe ON p.id = pe.profesional_id
      LEFT JOIN especialidades e ON pe.especialidad_id = e.id
      GROUP BY p.id
    `;
    db.query(query, callback);
  }

  // Crear un nuevo profesional
  static crear({ nombre, matricula, especialidades }, callback) {
    const profesionalQuery = 'INSERT INTO profesionales (nombre_completo, matricula, estado) VALUES (?, ?, "activo")';
    
    db.query(profesionalQuery, [nombre, matricula], (err, result) => {
      if (err) return callback(err);
      const profesionalId = result.insertId;

      // Insertar especialidades asociadas
      if (especialidades && especialidades.length > 0) {
        const values = especialidades.map(eid => [profesionalId, eid]);
        const especialidadQuery = 'INSERT INTO profesional_especialidad (profesional_id, especialidad_id) VALUES ?';
        db.query(especialidadQuery, [values], callback);
      } else {
        callback(null);
      }
    });
  }

  // Editar profesional y sus especialidades
  static editar(id, { nombre, matricula, especialidades }, callback) {
    const profesionalQuery = 'UPDATE profesionales SET nombre_completo = ?, matricula = ? WHERE id = ?';
    db.query(profesionalQuery, [nombre, matricula, id], (err) => {
      if (err) return callback(err);

      // Actualizar especialidades
      const deleteQuery = 'DELETE FROM profesional_especialidad WHERE profesional_id = ?';
      db.query(deleteQuery, [id], (err) => {
        if (err) return callback(err);

        if (especialidades && especialidades.length > 0) {
          const values = especialidades.map(eid => [id, eid]);
          const especialidadQuery = 'INSERT INTO profesional_especialidad (profesional_id, especialidad_id) VALUES ?';
          db.query(especialidadQuery, [values], callback);
        } else {
          callback(null);
        }
      });
    });
  }

  // Inactivar un profesional
  static inactivar(id, callback) {
    const query = 'UPDATE profesionales SET estado = "inactivo" WHERE id = ?';
    db.query(query, [id], callback);
  }

  // Activar un profesional
  static activar(id, callback) {
    const query = 'UPDATE profesionales SET estado = "activo" WHERE id = ?';
    db.query(query, [id], callback);
  }

  // Obtener especialidades disponibles
  static obtenerEspecialidades(callback) {
    db.query('SELECT * FROM especialidades', callback);
  }

  static configurarHorario(profesionalId, mananaInicio, mananaFin, tardeInicio, tardeFin, callback) {
    const queryDelete = 'DELETE FROM horarios_profesional WHERE profesional_id = ?';
    db.query(queryDelete, [profesionalId], (err) => {
      if (err) return callback(err);
  
      const horarios = [];
      if (mananaInicio && mananaFin) {
        horarios.push([profesionalId, 'mañana', mananaInicio, mananaFin]);
      }
      if (tardeInicio && tardeFin) {
        horarios.push([profesionalId, 'tarde', tardeInicio, tardeFin]);
      }
  
      const queryInsert = 'INSERT INTO horarios_profesional (profesional_id, turno, inicio, fin) VALUES ?';
      db.query(queryInsert, [horarios], callback);
    });
  }

  // Obtener profesional por ID con sus especialidades
  static obtenerPorId(id, callback) {
    const query = `
      SELECT p.id, p.nombre_completo, p.matricula, p.estado, GROUP_CONCAT(e.nombre) AS especialidades
      FROM profesionales p
      LEFT JOIN profesional_especialidad pe ON p.id = pe.profesional_id
      LEFT JOIN especialidades e ON pe.especialidad_id = e.id
      WHERE p.id = ?
      GROUP BY p.id
    `;
    
    db.query(query, [id], (err, resultados) => {
      if (err) return callback(err);
      if (resultados.length === 0) return callback(new Error('Profesional no encontrado'));

      const profesional = resultados[0];
      profesional.especialidades = profesional.especialidades ? profesional.especialidades.split(',') : [];
      callback(null, profesional);
    });
  }

static obtenerHorarios(profesionalId, callback) {
  const query = `
    SELECT turno, horario FROM horarios_profesional
    WHERE profesional_id = ?
  `;
  db.query(query, [profesionalId], (err, resultados) => {
    if (err) return callback(err);

    const horarios = { manana: null, tarde: null };
    resultados.forEach(row => {
      if (row.turno === 'mañana') {
        horarios.manana = row.horario;
      } else if (row.turno === 'tarde') {
        horarios.tarde = row.horario;
      }
    });

    callback(null, horarios);
  });
}
}

module.exports = Profesional;
