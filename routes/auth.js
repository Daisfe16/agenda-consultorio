const express = require('express');
const router = express.Router();
const authController = require('../controllers/authController');

// Ruta para mostrar el formulario de login
router.get('/login', authController.getLogin);

// Ruta para manejar el envío del formulario de login
router.post('/login', authController.postLogin);

module.exports = router;