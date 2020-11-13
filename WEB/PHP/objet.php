<?php
$link = mysqli_connect("localhost:3306","root","root","objet");
if (!$link) {
  die('Erreur de connexion');
}

if (!isset($_POST["ID"])) {
  $requete = "SELECT id , nom , latitude , longitude , latitude_2 , longitude_2 , zoom_min , icone , type , indice , depart , bloque_par , suivant FROM objet ORDER BY id";
  $array=[];
  if ($result = mysqli_query($link,$requete)) {
    while ($ligne = mysqli_fetch_assoc($result)) {
      $array[] = $ligne;
    }
  }
}

elseif (isset($_POST["ID"])) {
  $requete = "SELECT id , nom , latitude , longitude , latitude_2 , longitude_2 , zoom_min , icone , type , indice , depart , bloque_par , suivant FROM objet ORDER BY id";
  $array=[];
  if ($result = mysqli_query($link,$requete)) {
    while ($ligne = mysqli_fetch_assoc($result)) {
      if ($ligne["id"] == $_POST["ID"]) {
        $array[] = $ligne;
      }
    }
  }
}

foreach ($array as $objet) {
  if (!is_float($objet["latitude"])){
    $objet["latitude"] = floatval($objet["latitude"]);
  }
  if (!is_float($objet["longitude"])){
    $objet["longitude"] = floatval($objet["longitude"]);
  }
  if (!is_float($objet["latitude_2"])){
    $objet["latitude_2"] = floatval($objet["latitude_2"]);
  }
  if (!is_float($objet["longitude_2"])){
    $objet["longitude_2"] = floatval($objet["longitude_2"]);
  }
  if (!is_float($objet["zoom_min"])){
    $objet["zoom_min"] = floatval($objet["zoom_min"]);
  }
}
echo json_encode($array,JSON_NUMERIC_CHECK);
?>
