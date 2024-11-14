-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 14-11-2024 a las 22:19:02
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `agenda_medica`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `calendario_no_laborable`
--

CREATE TABLE `calendario_no_laborable` (
  `id` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `descripcion` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clasificaciones`
--

CREATE TABLE `clasificaciones` (
  `id` int(11) NOT NULL,
  `nombre` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `especialidades`
--

CREATE TABLE `especialidades` (
  `id` int(11) NOT NULL,
  `nombre` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `especialidades`
--

INSERT INTO `especialidades` (`id`, `nombre`) VALUES
(1, 'Neurologo'),
(2, 'Traumatologo'),
(3, 'Kinesiologo'),
(4, 'Odontologo'),
(5, 'Fonoaudiologo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `horarios_profesional`
--

CREATE TABLE `horarios_profesional` (
  `id` int(11) NOT NULL,
  `profesional_id` int(11) NOT NULL,
  `turno` enum('mañana','tarde') NOT NULL,
  `horario` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `lista_espera`
--

CREATE TABLE `lista_espera` (
  `id` int(11) NOT NULL,
  `paciente_id` int(11) NOT NULL,
  `profesional_id` int(11) DEFAULT NULL,
  `especialidad_id` int(11) DEFAULT NULL,
  `fecha_ingreso` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pacientes`
--

CREATE TABLE `pacientes` (
  `id` int(11) NOT NULL,
  `nombre_completo` varchar(255) NOT NULL,
  `dni` varchar(20) NOT NULL,
  `motivo_consulta` text DEFAULT NULL,
  `obra_social` varchar(255) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `foto_documento` varchar(255) DEFAULT NULL,
  `fecha_registro` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `pacientes`
--

INSERT INTO `pacientes` (`id`, `nombre_completo`, `dni`, `motivo_consulta`, `obra_social`, `telefono`, `email`, `foto_documento`, `fecha_registro`) VALUES
(1, 'Isaias Felippo', '42278658', 'Dolor de Rodilla', 'Osecac', '2664316702', NULL, NULL, '2024-10-04 02:28:09'),
(3, 'Ivan Suarez', '', '0', NULL, '289402949', 'dasdasd@afme.com', NULL, '2024-11-14 21:10:54');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `profesionales`
--

CREATE TABLE `profesionales` (
  `id` int(11) NOT NULL,
  `nombre_completo` varchar(255) NOT NULL,
  `matricula` varchar(50) NOT NULL,
  `fecha_registro` timestamp NOT NULL DEFAULT current_timestamp(),
  `hora_inicio_turno1` time DEFAULT NULL,
  `hora_fin_turno1` time DEFAULT NULL,
  `hora_inicio_turno2` time DEFAULT NULL,
  `hora_fin_turno2` time DEFAULT NULL,
  `estado` enum('activo','inactivo') DEFAULT 'activo'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `profesionales`
--

INSERT INTO `profesionales` (`id`, `nombre_completo`, `matricula`, `fecha_registro`, `hora_inicio_turno1`, `hora_fin_turno1`, `hora_inicio_turno2`, `hora_fin_turno2`, `estado`) VALUES
(1, 'Juanon Lucero', '431829', '0000-00-00 00:00:00', '09:00:00', '13:00:00', '16:00:00', '21:00:00', 'activo'),
(2, 'Isaias Felippo', '094928', '2024-11-13 03:46:02', NULL, NULL, NULL, NULL, 'inactivo'),
(3, 'trinidad felippo', '98504', '2024-11-13 20:37:24', NULL, NULL, NULL, NULL, 'activo'),
(4, 'Zacarias', '049489', '2024-11-13 20:40:49', NULL, NULL, NULL, NULL, 'activo'),
(5, 'Lucas Alvarez', '40291', '2024-11-13 20:56:20', NULL, NULL, NULL, NULL, 'activo'),
(6, 'Carlos Mendez', '00982', '2024-11-13 22:01:51', NULL, NULL, NULL, NULL, 'activo'),
(7, 'Jeremias Lisandro ', '094818', '2024-11-14 20:44:28', NULL, NULL, NULL, NULL, 'activo'),
(8, 'Fabian Torres', '23214', '2024-11-14 21:07:42', NULL, NULL, NULL, NULL, 'activo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `profesional_especialidad`
--

CREATE TABLE `profesional_especialidad` (
  `id` int(11) NOT NULL,
  `profesional_id` int(11) NOT NULL,
  `especialidad_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `profesional_especialidad`
--

INSERT INTO `profesional_especialidad` (`id`, `profesional_id`, `especialidad_id`) VALUES
(12, 3, 2),
(13, 3, 3),
(14, 2, 2),
(15, 4, 1),
(16, 5, 1),
(19, 6, 1),
(20, 6, 4),
(21, 6, 5),
(22, 1, 2),
(23, 1, 4),
(24, 7, 1),
(25, 7, 2),
(26, 7, 3),
(27, 7, 4),
(28, 7, 5),
(29, 8, 1),
(30, 8, 2),
(31, 8, 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sobreturnos`
--

CREATE TABLE `sobreturnos` (
  `id` int(11) NOT NULL,
  `turno_id` int(11) NOT NULL,
  `hora_extra` time NOT NULL,
  `estado` enum('Reservada','Confirmado','Cancelado','Ausente','Presente','En consulta','Atendido') DEFAULT 'Reservada'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sucursales`
--

CREATE TABLE `sucursales` (
  `id` int(11) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `direccion` varchar(255) NOT NULL,
  `telefono` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `sucursales`
--

INSERT INTO `sucursales` (`id`, `nombre`, `direccion`, `telefono`) VALUES
(1, 'Clinica España', 'Av España', '09481523');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `turnos`
--

CREATE TABLE `turnos` (
  `id` int(11) NOT NULL,
  `paciente_id` int(11) NOT NULL,
  `profesional_id` int(11) NOT NULL,
  `especialidad_id` int(11) NOT NULL,
  `sucursal_id` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `hora` time NOT NULL,
  `estado` enum('No disponible','Libre','Reservada','Confirmado','Cancelado','Ausente','Presente','En consulta','Atendido') DEFAULT 'Libre',
  `ocupado` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `turnos`
--

INSERT INTO `turnos` (`id`, `paciente_id`, `profesional_id`, `especialidad_id`, `sucursal_id`, `fecha`, `hora`, `estado`, `ocupado`) VALUES
(1, 1, 1, 1, 1, '0000-00-00', '09:30:56', 'Reservada', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `turno_clasificacion`
--

CREATE TABLE `turno_clasificacion` (
  `id` int(11) NOT NULL,
  `turno_id` int(11) NOT NULL,
  `clasificacion_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('admin','medico','paciente') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `username`, `password`, `role`) VALUES
(1, 'ClaudiaVasco', '$2a$10$6TlDq9KxQn.PVG1TbT15zO/Fyx4Ce6A0XGQn2J.bKsOtsquOf9QkK', 'admin'),
(2, 'Raul monsalva', '$2a$10$./VRk5FZCuXVkOgNx5LQheXG3K.OphvczmWaWktBeql5MsBZq/N/q', 'medico'),
(3, 'Luis Jofre', '$2a$10$2XcZTbTPNDSAe1PmJa.HReDF/y4x65DmnciPZcU7KOJ0j/tvHbRm6', 'paciente');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `calendario_no_laborable`
--
ALTER TABLE `calendario_no_laborable`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `clasificaciones`
--
ALTER TABLE `clasificaciones`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `especialidades`
--
ALTER TABLE `especialidades`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `horarios_profesional`
--
ALTER TABLE `horarios_profesional`
  ADD PRIMARY KEY (`id`),
  ADD KEY `profesional_id` (`profesional_id`);

--
-- Indices de la tabla `lista_espera`
--
ALTER TABLE `lista_espera`
  ADD PRIMARY KEY (`id`),
  ADD KEY `paciente_id` (`paciente_id`),
  ADD KEY `profesional_id` (`profesional_id`),
  ADD KEY `especialidad_id` (`especialidad_id`);

--
-- Indices de la tabla `pacientes`
--
ALTER TABLE `pacientes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `dni` (`dni`);

--
-- Indices de la tabla `profesionales`
--
ALTER TABLE `profesionales`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `profesional_especialidad`
--
ALTER TABLE `profesional_especialidad`
  ADD PRIMARY KEY (`id`),
  ADD KEY `profesional_id` (`profesional_id`),
  ADD KEY `especialidad_id` (`especialidad_id`);

--
-- Indices de la tabla `sobreturnos`
--
ALTER TABLE `sobreturnos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `turno_id` (`turno_id`);

--
-- Indices de la tabla `sucursales`
--
ALTER TABLE `sucursales`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `turnos`
--
ALTER TABLE `turnos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `paciente_id` (`paciente_id`),
  ADD KEY `profesional_id` (`profesional_id`),
  ADD KEY `especialidad_id` (`especialidad_id`),
  ADD KEY `sucursal_id` (`sucursal_id`);

--
-- Indices de la tabla `turno_clasificacion`
--
ALTER TABLE `turno_clasificacion`
  ADD PRIMARY KEY (`id`),
  ADD KEY `turno_id` (`turno_id`),
  ADD KEY `clasificacion_id` (`clasificacion_id`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `calendario_no_laborable`
--
ALTER TABLE `calendario_no_laborable`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `clasificaciones`
--
ALTER TABLE `clasificaciones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `especialidades`
--
ALTER TABLE `especialidades`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `horarios_profesional`
--
ALTER TABLE `horarios_profesional`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `lista_espera`
--
ALTER TABLE `lista_espera`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pacientes`
--
ALTER TABLE `pacientes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `profesionales`
--
ALTER TABLE `profesionales`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `profesional_especialidad`
--
ALTER TABLE `profesional_especialidad`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT de la tabla `sobreturnos`
--
ALTER TABLE `sobreturnos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `sucursales`
--
ALTER TABLE `sucursales`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `turnos`
--
ALTER TABLE `turnos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `turno_clasificacion`
--
ALTER TABLE `turno_clasificacion`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `horarios_profesional`
--
ALTER TABLE `horarios_profesional`
  ADD CONSTRAINT `horarios_profesional_ibfk_1` FOREIGN KEY (`profesional_id`) REFERENCES `profesionales` (`id`);

--
-- Filtros para la tabla `lista_espera`
--
ALTER TABLE `lista_espera`
  ADD CONSTRAINT `lista_espera_ibfk_1` FOREIGN KEY (`paciente_id`) REFERENCES `pacientes` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `lista_espera_ibfk_2` FOREIGN KEY (`profesional_id`) REFERENCES `profesionales` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `lista_espera_ibfk_3` FOREIGN KEY (`especialidad_id`) REFERENCES `especialidades` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `profesional_especialidad`
--
ALTER TABLE `profesional_especialidad`
  ADD CONSTRAINT `profesional_especialidad_ibfk_1` FOREIGN KEY (`profesional_id`) REFERENCES `profesionales` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `profesional_especialidad_ibfk_2` FOREIGN KEY (`especialidad_id`) REFERENCES `especialidades` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `sobreturnos`
--
ALTER TABLE `sobreturnos`
  ADD CONSTRAINT `sobreturnos_ibfk_1` FOREIGN KEY (`turno_id`) REFERENCES `turnos` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `turnos`
--
ALTER TABLE `turnos`
  ADD CONSTRAINT `turnos_ibfk_1` FOREIGN KEY (`paciente_id`) REFERENCES `pacientes` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `turnos_ibfk_2` FOREIGN KEY (`profesional_id`) REFERENCES `profesionales` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `turnos_ibfk_3` FOREIGN KEY (`especialidad_id`) REFERENCES `especialidades` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `turnos_ibfk_4` FOREIGN KEY (`sucursal_id`) REFERENCES `sucursales` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `turno_clasificacion`
--
ALTER TABLE `turno_clasificacion`
  ADD CONSTRAINT `turno_clasificacion_ibfk_1` FOREIGN KEY (`turno_id`) REFERENCES `turnos` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `turno_clasificacion_ibfk_2` FOREIGN KEY (`clasificacion_id`) REFERENCES `clasificaciones` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
