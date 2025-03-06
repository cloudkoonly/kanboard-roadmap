<?php
// Get the current page name for active state
$current_page = basename(dirname($_SERVER['PHP_SELF']));
if ($current_page === 'roadmap') {
    $current_page = 'index';
}

function isActive($page) {
    global $current_page;
    return $current_page === $page ? 'active' : '';
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cloudkoonly | Roadmap&Feedback&Changelog</title>
    
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <!-- Common Styles -->
    <link rel="stylesheet" href="/roadmap/assets/css/style.css">