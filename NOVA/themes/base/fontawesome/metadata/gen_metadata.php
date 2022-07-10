<?php

$yamlPath = __DIR__ . '/icons.yml';
$yamlTxt  = file_get_contents($yamlPath);
$yaml     = \Symfony\Component\Yaml\Yaml::parse($yamlTxt);
$faMap    = [];

foreach ($yaml as $faName => $info) {
    foreach ($info['styles'] as $style) {
        if ($style === 'solid') {
            $pref = 'fas fa-';
        } elseif ($style === 'regular') {
            $pref = 'far fa-';
        } elseif ($style === 'brands') {
            $pref = 'fab fa-';
        }

        $code         = $pref . $faName;
        $faMap[$code] = $info['unicode'];
    }
}

$faMapTxt = "<?php\n\n\$faTable = " . var_export($faMap, true) . ";\n";
echo $faMapTxt;
