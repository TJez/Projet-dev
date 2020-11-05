var mymap = L.map('map').setView([47,2], 8);

fetch("../PHP/objet.php")
  .then(r => r.json())
  .then(r => {
    var afficher = L.featureGroup();
    var zoom_aff = [];
    var id = [];
    for (var i = 0 ; i < r.length; i++) {
      var imageUrl = r[i]["icone"];
      var imageBounds = [[r[i]["latitude"], r[i]["longitude"]], [r[i]["latitude"]+0.002, r[i]["longitude"]+0.002]];
      image = L.imageOverlay(imageUrl, imageBounds);
      if (r[i]["depart"]==1) {
        afficher.addLayer(image);
        zoom_aff.push(r[i]["zoom_min"]);
        id.push(r[i]["id"]);
      }
    }
    mymap.setView([r[0]["latitude"]+0.001,r[0]["longitude"]+0.001], 15);
    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
        attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
    }).addTo(mymap);
    affichage(mymap , afficher , zoom_aff , id);
    mymap.addEventListener("zoomend",function() {affichage(mymap , afficher , zoom_aff , id)});
  })

function affichage(mymap , afficher , zoom_aff , id) {
  var liste = afficher.getLayers();
  for (var i = 0 ; i < liste.length; i++) {
    if (mymap.hasLayer(liste[i])) {
      mymap.removeLayer(liste[i]);
    }
    if (mymap.getZoom() >= zoom_aff[i]) {
      console.log(mymap);
      liste[i].addTo(mymap);
      liste[i].addEventListener("click",function() {action(id[i])});
    }
  }
}

function action(id) {
  var data = new FormData();
  data.append("ID",id);
  fetch("../PHP/objet.php", {
    method: "POST",
    body : data
  })
}
