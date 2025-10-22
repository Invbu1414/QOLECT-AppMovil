-- ============================================
-- ELIMINAR TODO - Script de limpieza total
-- ============================================

-- Eliminar tablas en orden correcto
DROP TABLE IF EXISTS notificacion CASCADE;
DROP TABLE IF EXISTS lead CASCADE;
DROP TABLE IF EXISTS calificacion CASCADE;
DROP TABLE IF EXISTS medio CASCADE;
DROP TABLE IF EXISTS usuarionoticia CASCADE;
DROP TABLE IF EXISTS productoetiqueta CASCADE;
DROP TABLE IF EXISTS etiqueta CASCADE;
DROP TABLE IF EXISTS experiencia CASCADE;
DROP TABLE IF EXISTS viaje CASCADE;
DROP TABLE IF EXISTS noticia CASCADE;
DROP TABLE IF EXISTS producto CASCADE;
DROP TABLE IF EXISTS marca CASCADE;
DROP TABLE IF EXISTS categoria CASCADE;
DROP TABLE IF EXISTS usuario CASCADE;
DROP TABLE IF EXISTS perfil CASCADE;

-- Eliminar función
DROP FUNCTION IF EXISTS update_updated_at_column() CASCADE;

-- Listo para crear todo de nuevo
