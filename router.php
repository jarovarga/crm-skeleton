<?php

if (!preg_match('/\.json/', $_SERVER['REQUEST_URI'])) {
    return false;
}

$_SERVER['SCRIPT_NAME'] = DIRECTORY_SEPARATOR . 'index.php';
$_SERVER['SCRIPT_FILENAME'] = $_SERVER['DOCUMENT_ROOT'] . $_SERVER['SCRIPT_NAME'];
$_SERVER['PHP_SELF'] = $_SERVER['SCRIPT_NAME'];

require $_SERVER['DOCUMENT_ROOT'] . $_SERVER['SCRIPT_NAME'];
