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

	// set up jquery-ui tabs function on the static-tabs div
	// $("#static-tabs").tabs();
	
	// check for a hash in the URL to load proper tab on a page reload or redirect
	var hash = window.location.hash;
	var navTabs = $('#ac-tabs ul.ac-tabs-nav a.tab-markers');
	var selectedTab = 0;	// selectedTab contains the tab# to select - default to the first one (#0)
	
	if (navTabs){	// if the page has navigation tabs
		
		// if URL contains a hash then match it to one of the tabs
		if (hash) {
			for (var idx=0; idx <navTabs.length; idx++) {
				if (navTabs[idx].hash == hash){
					selectedTab = idx;		// select this tab
					break;
				}
			}
		}
	
		// change background color for all tabs and their anchors to grey and enable the pointer cursor
		navTabs.each(function (){
			$(this).parent().css('background-color', '#999999');
			$(this).css('background-color', '#999999');
			$(this).css('cursor', 'pointer');
		});
		// then change the selected tab and anchor background to white and enable the text cursor
		$(navTabs[selectedTab]).parent().css('background-color', '#FFFFFF');
		$(navTabs[selectedTab]).css('background-color', '#FFFFFF');
		// $(navTabs[selectedTab]).css('cursor', 'text');
		var i = 0;
		
		// set up a click function so the current page tab is updated immediately before the new one loads
		$('#ac-tabs ul.ac-tabs-nav a').on( "click", function () {
			// change background color for all tabs and their anchors to grey 
			var navTabs = $('#ac-tabs ul.ac-tabs-nav a');
			navTabs.each(function (){
				$(this).parent().css('background-color', '#999999');
				$(this).css('background-color', 'inherit');
			});
			
			// then change the selected tab and anchor background to white
			$(this).parent().css('background-color', '#FFFFFF');
			$(this).css('background-color', 'inherit');
		});
	}

	// force first tab to be clicked on load
		// $('#ac-tabs .ac-tabs-nav a:first').trigger('click');
	
});
