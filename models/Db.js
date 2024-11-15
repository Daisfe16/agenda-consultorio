const mysql = require('mysql2'); // Asegúrate de usar mysql2


const db = mysql.createConnection({
  host: 'bntlwia2ijagitxujcz0-mysql.services.clever-cloud.com',
  user: 'ucwtbvhbewwgra0x',
  password: '7A9sFR4F4LnZXpo6ESsX',
  database: 'bntlwia2ijagitxujcz0'
});

db.connect((err) => {
  if (err) {
    console.error('Error conectando a la base de datos: ' + err.stack);
    return;
  }
  console.log('Conectado a la base de datos');
});

module.exports = db;
