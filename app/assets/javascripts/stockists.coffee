class App.Stockists extends App.Base
  map: null,
  @zoomLevel: 4,

  index: =>
    @syncOrders "/sync_orders"

  syncOrders: (url, page = 1) ->
    startSync = $.get "#{url}?api_page=#{page}", (data) ->
      syncedProgressCount = parseInt($('.synced-order-count').text())
      unless orders == undefined
        for orders in data.orders
          syncedProgressCount += 1
        $('.synced-order-count').text(syncedProgressCount)

  new: =>
    $('#stockist_name, #stockist_address_1, #stockist_address_2, #stockist_state, #stockist_postcode').on 'input', @updateMap

  @initMap: =>
    e = document.getElementById('map')
    if(e != null)
      App.Stockists.map = new google.maps.Map e, {center: {lat: 39.50, lng: -98.35}, zoom: App.Stockists.zoomLevel}

  updateMap: ->
    a = App.Stockists.getAddress()
    App.Stockists.codeAddress(a)

  @getAddress: ->
    zl = 4
    address = ''
    if $('#stockist_name').val().length > 0
      address += $('#stockist_name').val()
    if $('#stockist_address_1').val().length > 0
      address += ', '+$('#stockist_address_1').val()
    if $('#stockist_address_2').val().length > 0
      address += ', '+$('#stockist_address_2').val()
    if $('#stockist_city').val().length > 0
      address += ', '+$('#stockist_city').val()
      zl++

    if $('#stockist_postcode').val().length > 0
      address += ', '+$('#stockist_postcode').val()
      zl++

    if $('#stockist_state').val().length > 0
      address += ', '+$('#stockist_state').val()
      zl++
    App.Stockists.zoomLevel = zl
    address += ', USA'

  @codeAddress: (address) =>
    console.log('codeAddress: '+address)

    geocoder = new google.maps.Geocoder()
    geocoder.geocode( {address:address}, (results, status) ->
      if (status == google.maps.GeocoderStatus.OK)
        App.Stockists.map.setCenter(results[0].geometry.location)
        App.Stockists.map.setZoom(App.Stockists.zoomLevel)
    )
