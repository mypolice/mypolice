// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(document).ready(function(){
  $("#new_comment").submit(function(){
    $.post($(this).attr("action"),$(this).serialize(), null, "script");
    return false;
    });

   $("#new_response").submit(function(){
    $.post($(this).attr("action"),$(this).serialize(), null, "script");
    return false;
    });
  });

$(function() {
  $("#post_happened_on").datepicker({dateFormat:'yy-mm-dd'});
});
