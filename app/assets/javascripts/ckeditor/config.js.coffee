# http://docs.cksource.com/ckeditor_api/symbols/CKEDITOR.config.html#.toolbar_Full
CKEDITOR.editorConfig = (config) ->
  config.language = 'es'
  config.width = '500'
  config.height = '200'
  config.toolbar_Pure = [
    { name: 'basicstyles', items: [ 'Bold','Italic','Underline','Strike' ] },
    { name: 'links',       items: [ 'Link'] }, 
  ]
  config.toolbar = 'Pure'
  true