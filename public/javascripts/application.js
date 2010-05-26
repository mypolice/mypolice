// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(document).ready(function(){
  $("#post_happened_on").datepicker({dateFormat:'yy-mm-dd', maxDate:new Date()});    
    $("#new_comment").validate();
    $("#new_response").validate();
    });   

