const express = require('express');
const bodyParser = require('body-parser');
const path = require('path');
const session = require('express-session');
const flash = require('connect-flash');
const nodemon = require('nodemon'); // Asegúrate de que nodemon esté instalado
const routes = require('./routes/index'); // Asegúrate de que esta ruta sea correcta

const authController = require('./controllers/authController');
const logger = require('morgan');
const cookieParser = require('cookie-parser');

const app = express();
const PORT = process.env.PORT || 3000;

app.use(logger('dev')); // Registro de solicitudes HTTP
app.use(cookieParser()); // Manejo de cookies

// Configurar el motor de plantillas Pug
app.set('view engine', 'pug');
app.set('views', path.join(__dirname, 'views'));

// Middleware
// Middleware para manejar errores
app.use((err, req, res, next) => {
    console.error(err.stack); // Muestra el error en la consola
    res.status(500).render('error', { message: 'Algo salió mal, por favor intenta de nuevo más tarde.' });
  });
  
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());
app.use(express.static(path.join(__dirname, 'public'))); // Carpeta para archivos estáticos

// Configuración de la sesión
app.use(session({
  secret: 'tu_secreto_aqui', // Usa una cadena secreta segura
  resave: false,
  saveUninitialized: false,
}));

// Inicializar el middleware flash
app.use(flash());

// Middleware para hacer que los mensajes flash estén disponibles en todas las vistas
app.use((req, res, next) => {
  res.locals.success_msg = req.flash('success_msg');
  res.locals.error_msg = req.flash('error_msg');
  res.locals.error = req.flash('error');
  next();
});

// Middleware para pasar mensajes flash a las vistas
app.use((req, res, next) => {
  res.locals.success_msg = req.flash('success_msg');
  res.locals.error_msg = req.flash('error_msg');
  res.locals.error = req.flash('error');
  next();
});



// Rutas
app.use('/', routes); 
// Manejo de errores
app.use((req, res, next) => {
  const err = new Error('No encontrado');
  err.status = 404;
  next(err);
});

// Error handler
app.use((err, req, res, next) => {
  res.status(err.status || 500);
  res.render('error', {
    message: err.message,
    error: err,
  });
});

// Configuración de la sesión
app.use(session({
  secret: 'tu_secreto_aqui', // Usa una cadena secreta segura
  resave: false,
  saveUninitialized: false,
}));

// Inicializar el middleware flash
app.use(flash());


// Middleware para hacer que los mensajes flash estén disponibles en todas las vistas
app.use((req, res, next) => {
  res.locals.success_msg = req.flash('success_msg');
  res.locals.error_msg = req.flash('error_msg');
  res.locals.error = req.flash('error');
  next();
});

// Ruta para la vista de login
app.get('/login', authController.getLogin);


// Ruta de login
app.post('/login', (req, res) => {
  const { username, password } = req.body;

  // Verificar que ambos campos estén presentes
  if (!username || !password) {
    return res.status(400).send('Por favor ingresa tu usuario y contraseña');
  }

  // Consulta para verificar si el usuario existe en la base de datos
  const query = 'SELECT * FROM usuarios WHERE username = ?';

  db.query(query, [username], (err, result) => {
    if (err) {
      console.log(err);
      return res.status(500).send('Error en la base de datos');
    }

    // Verificar si el usuario existe
    if (result.length === 0) {
      return res.status(400).send('Usuario no encontrado');
    }

    const user = result[0]; // Asignar el primer (y único) usuario encontrado

    // Verificar la contraseña ingresada con la contraseña hasheada en la base de datos
    bcrypt.compare(password, user.password, (err, isMatch) => {
      if (err) {
        console.log(err);
        return res.status(500).send('Error al comparar contraseñas');
      }

      // Si las contraseñas coinciden
      if (isMatch) {
        // Guardar la sesión del usuario
        req.session.user = {
          id: user.id,
          username: user.username,
          role: user.role
        };

        // Redireccionar según el rol del usuario
        if (user.role === 'admin') {
          res.redirect('/agenda/admin');
        } else if (user.role === 'medico') {
          res.redirect('/agenda/medico');
        } else {
          res.redirect('/agenda/usuario');
        }
      } else {
        // Si la contraseña es incorrecta
        return res.status(400).send('Contraseña incorrecta');
      }
    });
  });
});

// Iniciar el servidor
app.listen(PORT, () => {
  console.log(`Servidor corriendo en http://localhost:${PORT}`);
});
