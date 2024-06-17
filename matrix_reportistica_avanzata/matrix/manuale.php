

<?php
$file='manuale.pdf';
header('Content-type: application/pdf');
header('Content-Disposition: inline; filename="manuale-Matrix.pdf"');
@readfile($file);
?>
