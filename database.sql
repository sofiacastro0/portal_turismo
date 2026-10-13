-- Creamos la base de datos
CREATE DATABASE IF NOT EXISTS portal_turismo;
USE portal_turismo;

-- 1. Tabla de Usuarios
-- Necesaria para diferenciar los roles y el sistema de login[cite: 3].
CREATE TABLE usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL, -- Aquí guardaremos la contraseña hasheada
    rol ENUM('cliente', 'admin') DEFAULT 'cliente' NOT NULL 
);

-- 2. Tabla de Categorías
-- Permite clasificar las publicaciones (aventura, cultural, alojamiento, etc.)[cite: 3].
CREATE TABLE categorias (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);

-- 3. Tabla de Publicaciones (Actividades y Alojamientos)
-- Contiene todos los campos mínimos exigidos por el requerimiento[cite: 2].
CREATE TABLE publicaciones (
    id_publicacion INT AUTO_INCREMENT PRIMARY KEY,
    id_categoria INT NOT NULL,
    tipo ENUM('actividad', 'alojamiento') NOT NULL,
    nombre VARCHAR(150) NOT NULL,
    ubicacion VARCHAR(100) NOT NULL, -- región, ciudad o pueblo[cite: 2]
    cupo_disponible INT NOT NULL DEFAULT 0,
    precio DECIMAL(10, 2) NOT NULL,
    imagen VARCHAR(255) NOT NULL, -- Solo guardará el nombre del archivo, no la imagen en sí[cite: 3]
    temporada_recomendada ENUM('verano', 'otoño', 'invierno', 'primavera', 'todas') DEFAULT 'todas',
    reservas_totales INT DEFAULT 0, -- Columna auxiliar para calcular fácilmente el "Más elegido"[cite: 2]
    FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria) ON DELETE RESTRICT
);

-- 4. Tabla de Reservas
-- Registra qué usuario reservó qué publicación y la cantidad de cupos descontados[cite: 3].
CREATE TABLE reservas (
    id_reserva INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_publicacion INT NOT NULL,
    cantidad_cupos INT NOT NULL,
    fecha_reserva DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_publicacion) REFERENCES publicaciones(id_publicacion) ON DELETE CASCADE
);

-- INSERCIONES DE PRUEBA (Opcional, para que tengas datos iniciales)
-- Insertamos algunas categorías base[cite: 3]
INSERT INTO categorias (nombre) VALUES 
('Aventura'), 
('Cultural'), 
('Gastronómica'), 
('Familiar'), 
('Alojamiento');
