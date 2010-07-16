// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(document).ready(function(){
    //var latlng = new google.maps.LatLng(-34.397, 150.644);
    var geocoder = new google.maps.Geocoder();
    var postcode = $("#postcode").val();
    if (geocoder) {
      geocoder.geocode( { 'address': postcode}, function(results, status) {
        if (status == google.maps.GeocoderStatus.OK) {
        var myOptions ={
          zoom:12,
          draggable:false,
          center:results[0].geometry.location,
          mapTypeId: google.maps.MapTypeId.ROADMAP
        }
        var map = new google.maps.Map(document.getElementById("where"), myOptions);
          
        } else {
          alert("Geocode was not successful for the following reason: " + status);
        }
      });
  }

    });
