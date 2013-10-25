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
//= require jquery-ui
//= require jquery_ujs
//= require jquery-fileupload/basic
//= require jquery-fileupload/vendor/tmpl
//= require jquery.cookie
//= require_tree .
	
jQuery(function() {

  $("#horizontal-tabs ul.static-tabs-nav").setStaticTabs();
  $("#vertical-tabs ul.dynamic-tabs-nav").setDynamicTabs();
  $(this).loadSessionTabs();
  $(".frontcover").draggable({containment: 'document', revert: true, revertDuration: 100});
  $("#horizontal-tabs ul.static-tabs-nav li").droppable({hoverClass: "hover", tolerance: "pointer", drop:handleDropEvent });
  $("#textbook_drop_id_1").click(function(){
    var secure_token = $('meta[name="csrf-token"]').attr("content");
    var dataString = 'authenticity_token=' + secure_token + '&tbdel[archive]=9';
    $.ajax({
      type: "PUT",
      url: "/course_assets/1/textbook_delegations/1",
      data: dataString,
      success: function() {
        alert('success');
      },
      error: function(){
        alert('error');
        return false;
      }
    })
    return false;
  })
});
