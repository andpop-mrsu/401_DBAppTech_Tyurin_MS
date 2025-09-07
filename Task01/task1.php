<?php
$readmeFile = 'README.md';
if (file_exists('README.md'))
	echo file_get_contents($readmeFile);
else
    echo "File Файл 'README.md not' found";