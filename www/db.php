<?php
$host = '192.168.56.11';
$port = '5432';
$dbname = 'tallerdb';
$user = 'vagrant';
$password = 'vagrant';

$conn_string = "host=$host port=$port dbname=$dbname user=$user password=$password";
$dbconn = pg_connect($conn_string);

if (!$dbconn) {
    echo "<p>Error conectando a la BD</p>";
    exit;
}

$result = pg_query($dbconn, "SELECT id, nombre, precio FROM productos");
if (!$result) {
    echo "<p>Error en consulta</p>";
    exit;
}

echo "<h2>Productos desde PostgreSQL</h2><ul>";
while ($row = pg_fetch_assoc($result)) {
    echo "<li>" . htmlspecialchars($row['nombre']) . " — " . htmlspecialchars($row['precio']) . "</li>";
}
echo "</ul>";
pg_close($dbconn);
?>