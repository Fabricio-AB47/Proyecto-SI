-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 16-02-2022 a las 03:30:03
-- Versión del servidor: 10.4.22-MariaDB
-- Versión de PHP: 8.1.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `agencia`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `carrito`
--

CREATE TABLE `carrito` (
  `id_carrito` int(11) NOT NULL,
  `email_usuario` varchar(150) NOT NULL,
  `id_tour` int(11) NOT NULL,
  `id_lugar` int(11) NOT NULL,
  `cantidad_tickets` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `carrito`
--

INSERT INTO `carrito` (`id_carrito`, `email_usuario`, `id_tour`, `id_lugar`, `cantidad_tickets`) VALUES
(18, 'ricardo@gmail.com', 13, 9, 3),
(19, 'dante@gmail.com', 13, 9, 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_registro`
--

CREATE TABLE `detalle_registro` (
  `id_detalle_registro` int(11) NOT NULL,
  `id_tour` int(11) NOT NULL,
  `id_lugar` int(11) NOT NULL,
  `id_registro` int(11) NOT NULL,
  `email_usuario` varchar(150) NOT NULL,
  `cantidad_tickets` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `detalle_registro`
--

INSERT INTO `detalle_registro` (`id_detalle_registro`, `id_tour`, `id_lugar`, `id_registro`, `email_usuario`, `cantidad_tickets`) VALUES
(1, 1, 1, 1, 'admin1@admin.com', 100);

--
-- Disparadores `detalle_registro`
--
DELIMITER $$
CREATE TRIGGER `tr_vacantes` AFTER INSERT ON `detalle_registro` FOR EACH ROW BEGIN

UPDATE tour SET vacantes_tour = ( (SELECT vacantes_tour FROM tour WHERE id_tour = NEW.id_tour) - NEW.cantidad_tickets) WHERE id_tour = NEW.id_tour;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `lugar`
--

CREATE TABLE `lugar` (
  `id_lugar` int(11) NOT NULL,
  `nombre_lugar` varchar(50) NOT NULL,
  `mapa_lugar` varchar(1500) NOT NULL,
  `foto_lugar` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `lugar`
--

INSERT INTO `lugar` (`id_lugar`, `nombre_lugar`, `mapa_lugar`, `foto_lugar`) VALUES
(4, 'Quito', '<iframe src=\"https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d255347.02337735455!2d-78.57062702350281!3d-0.18625043946287106!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x91d59a4002427c9f%3A0x44b991e158ef5572!2sQuito%2C%20Ecuador!5e0!3m2!1ses!2suk!4v1627891335951!5m2!1ses!2suk\" width=\"600\" height=\"450\" style=\"border:0;\" allowfullscreen=\"\" loading=\"lazy\"></iframe>', '3.jpg'),
(9, 'Guayaquil', 'https://goo.gl/maps/rmCfwLawqpwSejAx7', '8.jpg'),
(10, 'Cuenca', 'https://goo.gl/maps/S6oVuXLj7FMPErALA', '5.jpg');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `registro`
--

CREATE TABLE `registro` (
  `id_registro` int(11) NOT NULL,
  `email_usuario` varchar(150) NOT NULL,
  `total_registro` decimal(10,0) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `registro`
--

INSERT INTO `registro` (`id_registro`, `email_usuario`, `total_registro`) VALUES
(1, 'admin1@admin.com', '251'),
(2, 'admin@admin.com', '502');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tour`
--

CREATE TABLE `tour` (
  `id_tour` int(11) NOT NULL,
  `id_lugar` int(11) NOT NULL,
  `nombre_tour` varchar(500) NOT NULL,
  `vacantes_tour` int(11) NOT NULL,
  `foto_tour` varchar(500) NOT NULL,
  `precio_tour` decimal(10,0) NOT NULL,
  `descripcion_tour` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `tour`
--

INSERT INTO `tour` (`id_tour`, `id_lugar`, `nombre_tour`, `vacantes_tour`, `foto_tour`, `precio_tour`, `descripcion_tour`) VALUES
(1, 1, 'Tour por QUito', 7, '3.jpg', '251', 'Este tour lleva a quito ida y vuelta'),
(13, 9, 'Tour por Guayaquil', 20, '8.jpg', '380', 'Un viaje para demostrar la belleza que posee Guayaquil'),
(14, 10, 'Tour por Cuenca', 30, '5.jpg', '240', 'Conoce la belleza que puede ofrecerte Cuenca');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `email_usuario` varchar(150) NOT NULL,
  `nombre_usuario` varchar(250) NOT NULL,
  `password_usuario` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`email_usuario`, `nombre_usuario`, `password_usuario`) VALUES
('christian@gmail.com', 'Christian', '1234'),
('dante@gmail.com', 'Dante', '1234'),
('ricardo@gmail.com', 'Bryan', '1234');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `carrito`
--
ALTER TABLE `carrito`
  ADD PRIMARY KEY (`id_carrito`,`email_usuario`,`id_tour`,`id_lugar`),
  ADD KEY `usuario_carrito_fk` (`email_usuario`),
  ADD KEY `tour_carrito_fk` (`id_tour`,`id_lugar`);

--
-- Indices de la tabla `detalle_registro`
--
ALTER TABLE `detalle_registro`
  ADD PRIMARY KEY (`id_detalle_registro`,`id_tour`,`id_lugar`,`id_registro`,`email_usuario`),
  ADD KEY `registro_detalle_registro_fk` (`id_registro`,`email_usuario`),
  ADD KEY `tour_detalle_registro_fk` (`id_tour`,`id_lugar`);

--
-- Indices de la tabla `lugar`
--
ALTER TABLE `lugar`
  ADD PRIMARY KEY (`id_lugar`);

--
-- Indices de la tabla `registro`
--
ALTER TABLE `registro`
  ADD PRIMARY KEY (`id_registro`,`email_usuario`),
  ADD KEY `usuario_registro_fk` (`email_usuario`);

--
-- Indices de la tabla `tour`
--
ALTER TABLE `tour`
  ADD PRIMARY KEY (`id_tour`,`id_lugar`),
  ADD KEY `lugar_tour_fk` (`id_lugar`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`email_usuario`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `carrito`
--
ALTER TABLE `carrito`
  MODIFY `id_carrito` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT de la tabla `detalle_registro`
--
ALTER TABLE `detalle_registro`
  MODIFY `id_detalle_registro` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `lugar`
--
ALTER TABLE `lugar`
  MODIFY `id_lugar` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `registro`
--
ALTER TABLE `registro`
  MODIFY `id_registro` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `tour`
--
ALTER TABLE `tour`
  MODIFY `id_tour` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `carrito`
--
ALTER TABLE `carrito`
  ADD CONSTRAINT `tour_carrito_fk` FOREIGN KEY (`id_tour`,`id_lugar`) REFERENCES `tour` (`id_tour`, `id_lugar`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `usuario_carrito_fk` FOREIGN KEY (`email_usuario`) REFERENCES `usuario` (`email_usuario`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `detalle_registro`
--
ALTER TABLE `detalle_registro`
  ADD CONSTRAINT `registro_detalle_registro_fk` FOREIGN KEY (`id_registro`,`email_usuario`) REFERENCES `registro` (`id_registro`, `email_usuario`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `tour_detalle_registro_fk` FOREIGN KEY (`id_tour`,`id_lugar`) REFERENCES `tour` (`id_tour`, `id_lugar`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
