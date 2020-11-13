var mymap = L.map('map').setView([47,2], 8);
var afficher = L.featureGroup();
var zoom_aff = [];
var id = [];
var recuperable = document.getElementById("recuperable");
var selection = [];
var id_selection = 0;

function suivant(enCours, suivant, limite) {
  if (enCours.value.length == limite)
    document.code[suivant].focus();
  }

fetch("../PHP/objet.php")
  .then(r => r.json())
  .then(r => {
    for (var i = 0 ; i < r.length; i++) {
      if (r[i]["depart"]==1) {
        ajout_image (r[i]["icone"] , r[i]["latitude"] , r[i]["longitude"] , r[i]["latitude_2"] , r[i]["longitude_2"] , r[i]["zoom_min"] , r[i]["id"])
      }
    }
    mymap.setView([(r[0]["latitude"]+r[0]["latitude_2"])/2,(r[0]["longitude"]+r[0]["longitude_2"])/2], 15);
    affichage(mymap , afficher , zoom_aff , id);
    mymap.addEventListener("zoomend",function() {affichage()} , true);
  })

function ajout_image (icone , latitude , longitude , latitude_2 , longitude_2 , zoom_min , id_img) {
  var imageUrl = icone;
  var imageBounds = [[latitude, longitude], [latitude_2, longitude_2]];
  image = L.imageOverlay(imageUrl, imageBounds,{interactive : true});
  image.addEventListener("click" , function() {action(this , event)});
  afficher.addLayer(image);
  zoom_aff.push(zoom_min);
  id.push(id_img);
  return image;
}

function suppression_image (image) {
  var liste = afficher.getLayers();
  for (var i = 0 ; i < liste.length; i++) {
    if (image == liste[i]) {
      id.splice(i, 1);
      zoom_aff.splice(i,1);
      break;
    }
  }
  afficher.removeLayer(image);
}


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
        var popup = image.bindPopup(texte).openPopup([(r[0]["latitude"]+r[0]["latitude_2"])/2,(r[0]["longitude"]+r[0]["longitude_2"])/2]);
        cadenas(r[0]["bloque_par"] , texte , r[0]["suivant"] , image);
      }
      if (r[0]["type"] == "bloque_cle") {
        cle(image , r[0]["indice"] , r[0]["latitude"] , r[0]["longitude"] , r[0]["latitude_2"] , r[0]["longitude_2"] , r[0]["bloque_par"] , r[0]["suivant"]);
      }
      if (r[0]["type"] == "recuperable") {
        recuperer(image , r[0]["icone"]);
      }
      if (r[0]["type"] == "inutile") {
        var popup = image.bindPopup(r[0]["indice"]).openPopup([(r[0]["latitude"]+r[0]["latitude_2"])/2,(r[0]["longitude"]+r[0]["longitude_2"])/2]);
      }
      if (r[0]["type"] == "code") {
        var popup = image.bindPopup("Le code est " + r[0]["indice"]).openPopup([(r[0]["latitude"]+r[0]["latitude_2"])/2,(r[0]["longitude"]+r[0]["longitude_2"])/2]);
      }
    })
}

function cadenas(bloque_par , texte , suivant , image) {
  var data = new FormData();
  data.append("ID",bloque_par);
  fetch("../PHP/objet.php", {
    method: "POST",
    body : data
  })
    .then(r => r.json())
    .then(r => {
      var form = document.getElementById("form");
      form.addEventListener("submit" , function() {verif(r[0]["indice"] , texte , event , suivant , image)});
    })
}

function verif(code , texte , e , suivant , image) {
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
      suppression_image (image)
      img = ajout_image (r[0]["icone"] , r[0]["latitude"] , r[0]["longitude"] , r[0]["latitude_2"] , r[0]["longitude_2"] , r[0]["zoom_min"] , r[0]["id"])
      affichage();

      if (r[0]["type"] == "fin") {
        texte = r[0]["indice"] + "<form id='form' action='../PHP/resultat.php' name='fin' method='post'><input type='submit' name=terminer' value='Terminer'></form>"
        var liste = afficher.getLayers();
        var popup = img.bindPopup(texte).openPopup([(r[0]["latitude"]+r[0]["latitude_2"])/2,(r[0]["longitude"]+r[0]["longitude_2"])/2]);
      }
    })
  }
  else {
    image["_popup"].setContent(texte + "<br><b>Code faux ! Veuillez ressayer.</b>")
    var form2 = document.getElementById("form");
    form2.addEventListener("submit" , function() {verif(code , texte , event , suivant , image)});
  }
}


function cle(image , indice , latitude , longitude , latitude_2 , longitude_2 , bloque_par , suivant) {
  if (id_selection == bloque_par){
    var data = new FormData();
    data.append("ID",suivant);
    fetch("../PHP/objet.php", {
      method: "POST",
      body : data
    })
    .then(r => r.json())
    .then(r => {
      suppression_image (image)
      ajout_image (r[0]["icone"] , r[0]["latitude"] , r[0]["longitude"] , r[0]["latitude_2"] , r[0]["longitude_2"] , r[0]["zoom_min"] , r[0]["id"]);
      recuperable.removeChild(selection[0]);
      id_selection = 0;
      var data = new FormData();
      data.append("ID",r[0]["suivant"]);
      fetch("../PHP/objet.php", {
        method: "POST",
        body : data
      })
      .then(r => r.json())
      .then(r => {
        ajout_image (r[0]["icone"] , r[0]["latitude"] , r[0]["longitude"] , r[0]["latitude_2"] , r[0]["longitude_2"] , r[0]["zoom_min"] , r[0]["id"])
        affichage();
      })
    })
  }
  else {
    var texte = "<b>Bloqué par une clé</b><br>Indice :<br>" + indice
    var popup = image.bindPopup(texte).openPopup([(latitude+latitude_2)/2,(longitude+longitude_2)/2]);
  }
}


function recuperer(image , icone) {
  var img = document.createElement("img");
  img.src = icone;
  var liste = afficher.getLayers();
  for (var i = 0 ; i < liste.length; i++) {
    if (image == liste[i]) {
      var id_img = id[i];
      break;
    }
  }
  img.addEventListener("click" , function() {selectionner(this , id_img)});
  recuperable.appendChild(img);
  suppression_image(image);
  affichage();
}

function selectionner(img , id_img) {
  for (var i = 0 ; i < selection.length; i++) {
    selection[i].classList.remove("selection");
    selection[i].removeEventListener("click" , function() {deselectionner(this , id_img)});
    selection[i].addEventListener("click" , function() {selectionner(this , id_img)});
    selection.splice(selection[i],1);
    id_selection = 0;
  }
  selection.push(img);
  id_selection = id_img;
  img.classList.add("selection");
  img.removeEventListener("click" , function() {selectionner(this , id_img)});
  img.addEventListener("click" , function() {deselectionner(this , id_img)});
}

function deselectionner(img , id_img) {
  img.classList.remove("selection");
  img.removeEventListener("click" , function() {deselectionner(this , id_img)});
  img.addEventListener("click" , function() {selectionner(this , id_img)});
  selection.splice(img,1);
  id_selection = 0;
}
