const mysql = require('mysql2'); // Asegúrate de usar mysql2


const db = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: '',
  database: 'agenda_medica'
});

db.connect((err) => {
  if (err) {
    console.error('Error conectando a la base de datos: ' + err.stack);
    return;
  }
  console.log('Conectado a la base de datos');
});

module.exports = db;
