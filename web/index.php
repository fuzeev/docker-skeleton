<?php

error_reporting(E_ALL);
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);

const PROJECT_ROOT = __DIR__ . '/../';
const PROJECT_SOURCE_ROOT = PROJECT_ROOT . 'src/';

require_once PROJECT_ROOT . 'vendor/autoload.php';

echo 'Hello world';