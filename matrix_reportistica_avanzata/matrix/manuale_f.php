<?php
$file='manuale_formule.pdf';
header("Content-Type: application/pdf");
header('Content-Disposition: inline; filename="manuale_formule-Matrix.pdf"');
readfile($file);
?>