<!DOCTYPE html>
<html lang="fr'" dir="ltr">
  <head>
    <meta charset="utf-8">
    <title>GeoEscape</title>
    <link rel="stylesheet" href="../CSS/resultat.css">
  </head>
  <body>
    <h1>GeoEscape</h1>

    <?php
    $link = mysqli_connect("localhost:3306","root","root","objet");

    if (!$link) {
      die('Erreur de connexion');
    }
    if (isset($_POST["nom"]) and isset($_POST["temps"])) {
      $minute=floor($_POST["temps"]/60);
      $heure=floor($minute/60);
      $seconde=$_POST["temps"]-$minute*60;
      $minute=$minute-$heure*60;
      if ($heure<10){
        $heure="0".$heure;
      }
      if ($minute<10){
        $minute="0".$minute;
      }
      if ($seconde<10){
        $seconde="0".$seconde;
      }
      $temps=$heure.":".$minute.".".$seconde;

      $nom = $_POST["nom"];
      $request = "INSERT INTO score VALUES ('".$nom."','".$temps."')";

      mysqli_query($link,$request);
    }

    $request_ordre="SELECT * FROM score ORDER BY Temps";
    if ($result = mysqli_query($link, $request_ordre)) {
      while ($ligne = mysqli_fetch_assoc($result)) {
        $resultat[]=$ligne;
      }
    } else {
      echo "Erreur de requête de base de données.";
    }


    $compteur=0;
    foreach ($resultat as $element) {
      $compteur++;
      if ($element["Temps"]==$temps){
        $place=$compteur;
      }
    }


    echo "<div class='parag'>";
    echo "<p>Félicitation ".$_POST["nom"]." vous avez réussis à vous échapper en ".$heure." heures, ".$minute." minutes et ".$seconde." secondes. Vous êtes en position ".$place.".</p>";
    echo "</div>";


    echo "<div id='score'>";
    echo "<div class='titre'>";
    echo "<p>Tableau des scores</p>";
    echo "</div>";
      echo "<div class='tab'>";
      echo "<table><tr>";
      foreach ($resultat[0] as $key => $value) {
        echo "<th>$key</th>";}
      for ($i=0; $i<5; $i++) {
        echo "</tr><tr>";
        echo "<td>".$resultat[$i]['Nom']."</td>";
        echo "<td>".$resultat[$i]['Temps']."</td>";}
    echo "</tr></table>";
    echo "</div>
          </div>";
    ?>

    <img src="../Images/MtBlanc.jpg" class="blanc">
    <img src="../Images/MStMichel.jpg" class="michel">
    <img src="../Images/Code.jpg" class="code">
    <img src="../Images/CoffreOuv.png" class="coffre">
  </body>
</html>
