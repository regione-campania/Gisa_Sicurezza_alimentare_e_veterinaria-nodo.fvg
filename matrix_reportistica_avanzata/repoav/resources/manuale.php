
<?php
$file='Manuale reportistica avanzata.pdf';
header('Content-type: application/pdf');
header('Content-Disposition: inline; filename="Manuale reportistica avanzata.pdf"');
@readfile($file);
?>
