<?php
$link = mysqli_connect("localhost:3306","root","root","objet");
if (!$link) {
  die('Erreur de connexion');
}

if (!isset($_POST["id"])) {
  $requete = "SELECT id , nom , latitude , longitude , zoom_min , icone , type , indice , depart FROM objet ORDER BY id";
  $array=[];
  if ($result = mysqli_query($link,$requete)) {
    while ($ligne = mysqli_fetch_assoc($result)) {
      $array[] = $ligne;
    }
  }
}

else {
  $requete = "SELECT id , nom , latitude , longitude , zoom_min , icone , type , indice , depart FROM objet ORDER BY id";
  $array=[];
  if ($result = mysqli_query($link,$requete)) {
    while ($ligne = mysqli_fetch_assoc($result)) {
      if ($ligne["id"] == $_POST["id"]) {
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
  if (!is_float($objet["zoom_min"])){
    $objet["zoom_min"] = floatval($objet["zoom_min"]);
  }
}
echo json_encode($array,JSON_NUMERIC_CHECK);
?>
