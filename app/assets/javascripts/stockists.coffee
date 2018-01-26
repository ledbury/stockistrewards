class App.Stockists extends App.Base
  map: null,
  marker: null,
  @zoomLevel: 4,

  index: =>

  new: =>
    addressFields = $('#stockist_name, #stockist_address_1, #stockist_address_2, #stockist_state, #stockist_postcode')
    addressFields.on 'change', @updateMap
    addressFields.on 'input', @updateMap

    @initMap()

  edit: =>
    App.Stockist.on 'change', @updateMap
    App.Stockist.on 'input', @updateMap

    @initMap()
    @updateMap()

  initMap: ->
    e = document.getElementById('map')
    if(e != null)
      App.Stockists.map = new google.maps.Map e, {center: {lat: 39.50, lng: -98.35}, zoom: App.Stockists.zoomLevel}

  updateMap: ->
    zipcode = $("#stockist_postcode").val().substring(0, 5);
    console.log('updateMap'+zipcode)
    if (zipcode.length == 5 && /^[0-9]+$/.test(zipcode))
      url = "/zipcode/" + zipcode
      $.ajax({"url": url, "dataType": "json"}).done (data) ->
        $("#stockist_city").val(data[0])
        $("#stockist_state").val(data[1])

    a = App.Stockists.getAddress()
    App.Stockists.codeAddress(a)

  @getAddress: ->
    zl = 4
    address = ''
    if $('#stockist_name').val().length > 0
      address += $('#stockist_name').val()+', '
    if $('#stockist_address_1').val().length > 0
      address += $('#stockist_address_1').val()
      zl++
    if $('#stockist_address_2').val().length > 0
      address += ', '+$('#stockist_address_2').val()
    if $('#stockist_city').val().length > 0
      address += ', '+$('#stockist_city').val()
      zl++
    if $('#stockist_postcode').val().length > 0
      address += ', '+$('#stockist_postcode').val()
      zl+=3
    if $('#stockist_state').val().length > 0
      address += ', '+$('#stockist_state').val()
      zl++
    App.Stockists.zoomLevel = zl
    App.Stockists.map.zoomLevel = zl
    address += ', USA'


  @codeAddress: (address) =>
    console.log('codeAddress: '+address)

    geocoder = new google.maps.Geocoder()
    geocoder.geocode( {address:address}, (results, status) ->
      if (status == google.maps.GeocoderStatus.OK)
        App.Stockists.map.setCenter(results[0].geometry.location)
        App.Stockists.map.setZoom(App.Stockists.zoomLevel)

        if App.Stockists.marker != undefined
          App.Stockists.marker.setMap(null)
        App.Stockists.marker = new google.maps.Marker
          position: results[0].geometry.location,
          map: App.Stockists.map,
          title: $('#stockist_name').val()


    )
