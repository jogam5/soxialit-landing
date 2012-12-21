// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery.preview.full
//= requiere jquery.tokeninput
//= require bootstrap
//= require jquery_ujs
//= require box-maker
//= require jquery-fileupload/basic
//= require jquery-fileupload/vendor/tmpl
//= require rails.validations
//= require masonry
//= require masonry.min
//= require_tree .

$(function () {
  $('#product_tag_list').tokenInput('/sizes.json', { 
    crossDomain: false,
    prePopulate: $('#product_tag_list').data('pre'),
    theme: 'facebook',
	 preventDuplicates: true,
	 tokenValue: 'name', // defaults to 'id'
  
	 allowCustomEntry: true
   
  });
});


$(function(){
	$('#product_size_tokens').tokenInput('/sizes.json', {
    crossDomain: false,
	 preventDuplicates: true,
    prePopulate: $('#product_size_tokens').data('load')
	});
 });


$(function() {
  $('#ajax-status')
    .hide()  // hide it initially.
    .ajaxStart(function() {
      $(this).show(); // show on any Ajax event.
    })
    .ajaxStop(function() {
      $(this).hide(); // hide it when it is done.
  });
});

