<?php
$host = $_ENV['MYSQL_HOST'];
$port = $_ENV['MYSQL_TCP_PORT'];
$db = $_ENV['MYSQL_DATABASE'];
$user = $_ENV['MYSQL_USER'];
$pass = $_ENV['MYSQL_PASSWORD'];
$charset = 'utf8mb4';

$dsn = "mysql:host=$host;port=$port;dbname=$db;charset=$charset";
$options = [];

try {
    $pdo = new PDO($dsn, $user, $pass, $options);
    if (basename(__FILE__) == basename($_SERVER['SCRIPT_FILENAME'])) {
        echo "Database connection successful!";
    }
} catch (\PDOException $e) {
    throw new \PDOException($e->getMessage(), (int)$e->getCode());
}
?>