<!DOCTYPE html>
<html lang="fr" dir="ltr">
  <head>
    <meta charset="utf-8">
    <title>GeoEscape</title>
  </head>
  <body>
    <form class="formulaire" action="../HTML/resultat.html" method="post">
      <?php
      echo 'Nom <input type="text" name="nom" value='.$_Post[nom].'>'
      ?>
      <p></p>
      <input type="text" name="temps" value="00:07:28">
      <input type="submit" name="Resultat" value="Resultat">
    </form>
  </body>
</html>
