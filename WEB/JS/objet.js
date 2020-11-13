var mymap = L.map('map').setView([47,2], 8);
var afficher = L.featureGroup();
var zoom_aff = [];
var id = [];
var recuperable = document.getElementById("recuperable");

function suivant(enCours, suivant, limite) {
  if (enCours.value.length == limite)
    document.code[suivant].focus();
  }

fetch("../PHP/objet.php")
  .then(r => r.json())
  .then(r => {
    for (var i = 0 ; i < r.length; i++) {
      var imageUrl = r[i]["icone"];
      var imageBounds = [[r[i]["latitude"], r[i]["longitude"]], [r[i]["latitude"]+0.002, r[i]["longitude"]+0.002]];
      image = L.imageOverlay(imageUrl, imageBounds,{interactive : true});
      if (r[i]["depart"]==1) {
        afficher.addLayer(image);
        zoom_aff.push(r[i]["zoom_min"]);
        id.push(r[i]["id"]);
      }
    }
    mymap.setView([r[2]["latitude"]+0.001,r[2]["longitude"]+0.001], 15);
    affichage(mymap , afficher , zoom_aff , id);
    mymap.addEventListener("zoomend",function() {affichage()} , true);
  })

function affichage() {
  var liste = afficher.getLayers();
  mymap.eachLayer(function(layer){
    mymap.removeLayer(layer);
  })
  L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
      attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
  }).addTo(mymap);
  for (var i = 0 ; i < liste.length; i++) {
    if (mymap.getZoom() >= zoom_aff[i]) {
      liste[i].addTo(mymap);
      liste[i].addEventListener("click",function() {action(this , afficher , zoom_aff , id , event)});
    }
  }
}

function action(image , e) {
  var liste = afficher.getLayers();
  for (var i = 0 ; i < liste.length; i++) {
    if (image == liste[i]) {
      var id_img = id[i];
      break;
    }
  }
  var data = new FormData();
  data.append("ID",id_img);
  fetch("../PHP/objet.php", {
    method: "POST",
    body : data
  })
    .then(r => r.json())
    .then(r => {
      if (r[0]["type"] == "bloque_cadenas") {
        var texte = "<b>Bloqué par un code</b><br>Indice :<br>" + r[0]["indice"] + "<br>Entrez le code ici :<br><form id='form' action='#' name='code' method='post'> <input type='text' size='1' name='code1' id='1' maxlength='1' onKeyUp='suivant(this,\"code2\", 1)'> <input type='text' size='1' name='code2' id='2' maxlength='1' onKeyUp='suivant(this,\"code3\", 1)'> <input type='text' size='1' name='code3' id='3' maxlength='1' onKeyUp='suivant(this,\"code4\", 1)'> <input type='text' size='1' name='code4' id='4' maxlength='1' onKeyUp='suivant(this,\"envoi\", 1)'> <input type='submit' name='envoi' id='envoi' value='Valider'></form>"
        var popup = image.bindPopup(texte).openPopup([r[0]["latitude"]+0.001,r[0]["longitude"]+0.001]);
        cadenas(r[0]["bloque_par"] , popup , texte , r[0]["suivant"] , image);
      }
      if (r[0]["type"] == "bloque_cle") {
        var texte = "<b>Bloqué par une clé</b><br>Indice :<br>" + r[0]["indice"]
        var popup = image.bindPopup(texte).openPopup([r[0]["latitude"]+0.001,r[0]["longitude"]+0.001]);
        cle();
      }
      if (r[0]["type"] == "recuperable") {
        recuperer(image , r[0]["icone"]);
      }
    })
}

function cadenas(bloque_par , popup , texte , suivant , image) {
  var data = new FormData();
  data.append("ID",bloque_par);
  fetch("../PHP/objet.php", {
    method: "POST",
    body : data
  })
    .then(r => r.json())
    .then(r => {
      var form = document.getElementById("form");
      form.addEventListener("submit" , function() {verif(r[0]["indice"] , popup , texte , event , suivant , image)});
    })
}

function verif(code , popup , texte , e , suivant , image) {
  e.preventDefault();
  var code1 = form.elements["code1"];
  var code2 = form.elements["code2"];
  var code3 = form.elements["code3"];
  var code4 = form.elements["code4"];
  code_ecrit = code1.value + code2.value + code3.value + code4.value;
  if (code_ecrit == code) {
    var data = new FormData();
    data.append("ID",suivant);
    fetch("../PHP/objet.php", {
      method: "POST",
      body : data
    })
    .then(r => r.json())
    .then(r => {
      var liste = afficher.getLayers();
      for (var i = 0 ; i < liste.length; i++) {
        if (image == liste[i]) {
          id.splice(i, 1);
          zoom_aff.splice(i,1);
          break;
        }
      }
      afficher.removeLayer(image);
      var imageUrl = r[0]["icone"];
      var imageBounds = [[r[0]["latitude"], r[0]["longitude"]], [r[0]["latitude"]+0.002, r[0]["longitude"]+0.002]];
      newimage = L.imageOverlay(imageUrl, imageBounds,{interactive : true});
      afficher.addLayer(newimage);
      zoom_aff.push(r[i]["zoom_min"]);
      id.push(r[i]["id"]);
      affichage();

      if (r[0]["type"] == "fin") {
        texte = r[0]["indice"] + "<form id='form' action='../PHP/resultat.php' name='fin' method='post'><input type='submit' name=terminer' value='Terminer'></form>"
        var popup = image.bindPopup(texte).openPopup([r[0]["latitude"]+0.001,r[0]["longitude"]+0.001]);
      }
    })
  }
  else {
    popup.setContent(texte + "<br><b>Code faux ! Veuillez ressayer.</b>")
    var form2 = document.getElementById("form");
    form2.addEventListener("submit" , function() {verif(code , popup , texte , event , suivant , afficher , zoom_aff , id , image)});
  }
}


function cle() {

}


function recuperer(image , icone) {
  var img = document.createElement("img");
  img.src = icone;
  img.addEventListener("click" , selectionner);
  recuperable.appendChild(img);
  console.log(rec);
  var liste = afficher.getLayers();
  for (var i = 0 ; i < liste.length; i++) {
    if (image == liste[i]) {
      id.splice(i, 1);
      zoom_aff.splice(i,1);
      break;
    }
  }
  afficher.removeLayer(image);
  affichage();
}

function selectionner() {
  console.log("hello");
}
