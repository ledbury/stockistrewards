class App.Stockists extends App.Base

  new: =>
    console.log 'MAUI Stockist Rewards >>> [RAILS_SCRIPT]'
    map = new google.maps.Map document.getElementById('map'),
      {center: {lat: -34.397, lng: 150.644}, zoom: 8}

  index: =>
