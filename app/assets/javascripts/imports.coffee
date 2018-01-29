class App.Imports extends App.Base

  new: =>
    Dropzone.autoDiscover = false
    setTimeout( ->
      $("#new_import").dropzone({ 
    		paramName: "import[file]",
    		addRemoveLinks: true
      })
      $("#new_import").show()
    , 200)
