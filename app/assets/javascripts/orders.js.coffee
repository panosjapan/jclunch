# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $('#search_region_name').autocomplete
    source: $('#search_region_name').data('autocomplete-source')

	jQuery ->
	  $('#order_date').datepicker
	    dateFormat: 'yy-mm-dd'
	    
