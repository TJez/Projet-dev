<?php
$link = mysqli_connect("localhost:3306","root","root","objet");
if (!$link) {
  die('Erreur de connexion');

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
  if (!is_int($objet["latitude"])){
    $objet["latitude"] = intval($objet["latitude"]);
  }
  if (!is_int($objet["longitude"])){
    $objet["longitude"] = intval($objet["longitude"]);
  }
  if (!is_int($objet["zoom_min"])){
    $objet["zoom_min"] = intval($objet["zoom_min"]);
  }
}
echo json_encode($array);
?>
