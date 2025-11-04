<?php
echo "<h1>Hola desde PHP</h1>";

// Información dinámica 
echo "<h1>Información del servidor PHP</h1>";
echo "<p>Servidor: " . $_SERVER['SERVER_NAME'] . "</p>";
echo "<p>Dirección IP: " . $_SERVER['SERVER_ADDR'] . "</p>";
echo "<p>Fecha y hora actual: " . date('Y-m-d H:i:s') . "</p>";
phpinfo();

?>
