-- ============================================
-- QOLECT - Limpieza de Base de Datos
-- ============================================
-- Ejecutar PRIMERO este script para limpiar todo

-- Eliminar vistas primero
DROP VIEW IF EXISTS viajes_completos CASCADE;
DROP VIEW IF EXISTS experiencias_completas CASCADE;

-- Eliminar políticas RLS
DROP POLICY IF EXISTS "Users can view own data" ON usuario;
DROP POLICY IF EXISTS "Users can update own data" ON usuario;
DROP POLICY IF EXISTS "Users can view own viajes" ON viaje;
DROP POLICY IF EXISTS "Users can manage own viajes" ON viaje;
DROP POLICY IF EXISTS "Users can view own experiencias" ON experiencia;
DROP POLICY IF EXISTS "Users can manage own experiencias" ON experiencia;
DROP POLICY IF EXISTS "Users can view own notifications" ON notificacion;
DROP POLICY IF EXISTS "Anyone can view active noticias" ON noticia;
DROP POLICY IF EXISTS "Anyone can view active productos" ON producto;

-- Eliminar tablas en orden correcto (respetando foreign keys)
DROP TABLE IF EXISTS calificacion CASCADE;
DROP TABLE IF EXISTS medio CASCADE;
DROP TABLE IF EXISTS usuario_noticia CASCADE;
DROP TABLE IF EXISTS producto_etiqueta CASCADE;
DROP TABLE IF EXISTS etiqueta CASCADE;
DROP TABLE IF EXISTS lead CASCADE;
DROP TABLE IF EXISTS notificacion CASCADE;
DROP TABLE IF EXISTS experiencia CASCADE;
DROP TABLE IF EXISTS viaje CASCADE;
DROP TABLE IF EXISTS noticia CASCADE;
DROP TABLE IF EXISTS producto CASCADE;
DROP TABLE IF EXISTS marca CASCADE;
DROP TABLE IF EXISTS categoria CASCADE;
DROP TABLE IF EXISTS usuario CASCADE;
DROP TABLE IF EXISTS perfil CASCADE;

-- Eliminar función de trigger
DROP FUNCTION IF EXISTS update_updated_at_column() CASCADE;

-- ============================================
-- FIN DE LIMPIEZA
-- ============================================
