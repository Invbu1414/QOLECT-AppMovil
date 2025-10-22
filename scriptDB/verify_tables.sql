-- Verificar que todas las tablas se crearon correctamente
SELECT
    table_name,
    (SELECT COUNT(*)
     FROM information_schema.columns
     WHERE columns.table_name = tables.table_name) as columnas
FROM information_schema.tables
WHERE table_schema = 'public'
AND table_name IN (
    'perfil', 'usuario', 'categoria', 'marca', 'producto',
    'etiqueta', 'productoetiqueta', 'noticia', 'usuarionoticia',
    'viaje', 'experiencia', 'notificacion', 'lead', 'medio', 'calificacion'
)
ORDER BY table_name;
