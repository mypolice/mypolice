// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(document).ready(function(){
    // add postcode validation
    $.validator.addMethod("postcode",
        function(value,element){
      return this.optional(element)||/^[A-Z]{1,2}[0-9R][0-9A-Z]? [0-9][ABD-HJLNP-UW-Z]{2}$/i.test(value);},
      "Please enter valid postcode");
    //initial the process bar
    $("#complete").addClass("first");
    //update the process bar
    function updateSteps(fields){
      var length = fields.length;
      if (length >0){
      $("#complete").removeClass();
      $("#complete").addClass(fields[length-1]); 
     }
    }


    //formwizard configure
    $("#new_post").formwizard({
      historyEnabled:true,
      formPluginEnabled:true,
      validationEnabled:true,
      focusFirstInput:true,
      afterNext:function(wizardData){
        updateSteps(wizardData.activatedSteps);
        if($("#new_post").formwizard("state").isLastStep){
          $("#next_button").hide();
        }
      },
      afterBack:function(wizardData){
        updateSteps(wizardData.activatedSteps);   
        if(!$("#new_post").formwizard("state").isLastStep){
          $("#next_button").show();
        }       
      }
      },
      {
        rules:{
                "post[title]":{
                      required:true,
                      minlength: 4,
                      maxlength:100
                      },
                "post[body]":{
                      required:true,
                      minlength:140

                //},
              //  "address[postcode]":{
                  //    required:true,
                    //  postcode:true
                }
           },
        messages:{
                 "post[body]":"More than 140 characters would be great",
                 "post[title]":"4-140 characters would be great"
                 },
          errorElement:"div",
          //wrapper:"div",
          //errorLabelContainer: ".message",
        errorPlacement: function(error, element) {
                offset=element.offset();
                error.insertBefore(element);
                //error.addClass('message');
                error.css('position','absolute');
                error.css('left',offset.left+element.outerWidth());
                error.css('top',offset.top);
             }
      }          
      ,{
        success:function(data){
              updateSteps([]);
              $("#formcontent").empty();
              $("#formcontent").append("<h2> Thanks! Your Story is now being moderated and should appear on the site shortly. In the meantime, explore the other <a href='/posts'>Stories</a> on MyPolice</h2>");

                },
        resetForm:true
      }
      );

      //date
      $("#date_happened_on_month").hide();
      $("#date_happened_on_day").hide();
      $("#date_happened_on_year").change(function(){
          if ($(this).val()){
            $("#date_happened_on_month").show();}
          else{
            $("#date_happened_on_month").hide();
            $("#date_happened_on_day").hide();
          }
          });
      $("#date_happened_on_month").change(function(){
          if($(this).val()){
            $("#date_happened_on_day").show();
          }
          else{
            $("#date_happened_on_day").hide();
          }
          });
    
      //maps
var geocoder;
var map;
var marker;
var infowindow = new google.maps.InfoWindow();
var streetName="";
var postcode="";
var city="";
var county ="";
var streetNumber="";
var island="";
  
  function initialize() {
    geocoder = new google.maps.Geocoder();
    var latlng = new google.maps.LatLng(55.86, -4.260);
    var myOptions = {
      zoom: 8,
      center: latlng,
      mapTypeId: google.maps.MapTypeId.ROADMAP
    }
    //^[a-zA-Z\s]+ regular  
    map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);
        marker = new google.maps.Marker({
        position: latlng, 
        map: map,
        draggable:true,
        });
     google.maps.event.addListener(marker, 'dragend',positionchange);
}

    function positionchange(){
      var ll = marker.position;
      geocoder.geocode({'latLng':ll}, function(results, status){
        if(status==google.maps.GeocoderStatus.OK){
        infowindow.setContent(results[0].formatted_address);
        infowindow.open(map,marker);
        map.setCenter(results[0].geometry.location);
        $("#address").val(results[0].formatted_address);
        getaddress(results[0].address_components); 
        }else{
        alert("Geocoder failed dur to:" + status);
        }        
        });
    }
    
  $("#geocode").click(function(){
      codeAddress();
      }
      );
  $("#saveaddress").click(function(){
      $('#address_address_line1').val(streetNumber);
      $('#address_county').val(county+","+island);
      $('#address_city').val(city);
      $('#address_address_line2').val(streetName);
      $('#address_postcode').val(postcode);
      $.fancybox.close();
      });

  function codeAddress() {
    marker.setMap(null); 
    var address = document.getElementById("address").value;
    if (geocoder) {
      geocoder.geocode( { 'address': address}, function(results, status) {
        if (status == google.maps.GeocoderStatus.OK) {
          map.setCenter(results[0].geometry.location);
              marker = new google.maps.Marker({
              map: map, 
              position: results[0].geometry.location,
              draggable:true
          });

        infowindow.setContent(results[0].formatted_address);
        infowindow.open(map,marker);
        getaddress(results[0].address_components);
         google.maps.event.addListener(marker, 'dragend',positionchange);
        } else {
          alert("Geocode was not successful for the following reason: " + status);
        }
      });
    }
  }

    function getaddress(components){
      for (var i=0;i<components.length;i++){
        switch(components[i].types[0]){
          case "street_number":
            streetNumber = components[i].long_name;
          break;
          case "route":
            streetName=components[i].long_name;
          break;
          case "administrative_area_level_3":
            city = components[i].long_name;
          break;
          case "administrative_area_level_2":
            county = components[i].long_name;
          break;
          case "administrative_area_level_1":
            island = components[i].long_name;
          break;
          case "country":
            country = components[i].long_name;
            if(country!="United Kingdom")
              alert("Sorry, Our serivce is only available in the UK");
          break;
          case "postal_code":
            postcode = components[i].long_name;
          break;
        }
    }
      
  }
$("#gmap").click(function(){
  if(map==undefined){
    initialize();
    }   });
$("a#gmap").fancybox({
    'hideOnContentClick':false,
    'hideOnOverlayClick':false,
    'width':800,
    'height':600,
    'autoDimensions':true
    });
//Address form display
/*
$("#address_county").change(function(){
  $("#address_city").parent().parent().removeClass("hide"); 
});
$("#address_city").change(function(){
  $("#address_address_line2").parent().parent().removeClass("hide"); 
});
$("#address_address_line2").change(function(){
  $("#address_address_line1").parent().parent().removeClass("hide"); 
});

*/
//character count
function charactercount(){
   var charLength=$('#post_body').val().length;
    //display count
    $('span#charCount').html(charLength);
}
charactercount();
$('#post_body').bind('keyup', function(event){charactercount();})
  .bind('mouseover', function(event){setTimeout(function(){charactercount();},10);})
  .bind('paste',function(event){setTimeout(function(){charactercount();},10);});


//autocomplete
//var availableTags = ["c++", "java", "php", "coldfusion", "javascript", "asp", "ruby", "python", "c", "scala", "groovy", "haskell", "perl"];
		function split(val) {
			return val.split(/,\s*/);
		}
		function extractLast(term) {
			return split(term).pop();
		}
var cache = {};		
		$("#post_tag_list").autocomplete({
			minLength: 0,
      source: function(request, response){
      if ( request.term in cache ) {
					response( cache[ request.term ] );
					return;
				}
      
      $.ajax({
        url:'/tags.json',
        dataType:"json",
        data: request,
        success:function(data){
          
        response($.map(data,function(item){
            return {
              label:item.name,
              value:item.name
            }
            }));    
          
          }
        })
      },
      /*
      source:function(request,response){
        $.getJSON(
          '/tags.json',{term:extractLast(request.term)},response($.map(data,function(item){
              alert(item.name);
              return value:item.name
              }))
          );
      },*/
			focus: function() {
				// prevent value inserted on focus
				return false;
			},
			select: function(event, ui) {
				var terms = split( this.value );
				// remove the current input
				terms.pop();
				// add the selected item
				terms.push( ui.item.value );
				// add placeholder to get the comma-and-space at the end
				terms.push("");
				this.value = terms.join(", ");
				return false;
			}
		});

//rating bar
    var sevenlevels = ["Completely satisfie","Very satisfied","Fairly satisfied","Neither satisfied nor dissatisfied","Fairly dissatisfied","Very dissatisfied","Completely dissatisfied"]; 
    function ratebar(name, bar, val){
      $("#"+bar).slider({
        value:3,
        min:0,
        max:6,
        step:1,
        slide:function(event,ui){
          $("#"+name).val(ui.value);
          $("#"+val).empty();
          $("#"+val).append(sevenlevels[ui.value]);
        }    
          });
       $("#"+name).val($("#"+bar).slider("value"));
    }
    ratebar("easeofcontactingrating","easeofcontactingratingbar","easeofcontactingratingvalue");
    ratebar("arriverating","arriveratingbar","arriveratingvalue");
    ratebar("actionrating","actionratingbar","actionratingvalue");
    ratebar("keepinformrating","keepinformratingbar","keepinformratingvalue");
    ratebar("treatmentrating","treatmentratingbar","treatmentratingvalue");
    ratebar("wholerating","wholeratingbar","wholeratingvalue");
          //question flow
          //init
        contactcheck();
        isreport();
        anycontact();

        $("input:radio[name=contact]").change(function(){
              contactcheck();});

        $("input:radio[name=isreported]").change(function(){
                isreport();
               });
        $("input:radio[name=anycontact]").change(function(){
               anycontact();
               });
            
    function contactcheck(){
       if ($('input:radio[name=contact]:checked').val()=="Yes"){
        $("#q12, #q13,#q14,#q15,#q2,#q3,#q4,#q5").removeClass('hide');
       }
       else{
        $("#q12, #q13,#q14,#q15,#q2,#q3,#q4,#q5,#q16,#q17,#q18,.q31").addClass('hide');
       }
    }

    function isreport(){
      if ($('input:radio[name=isreported]:checked').val()=="Yes")
      {
        $("#q16,#q17,#q18").removeClass('hide');
      }else
      {
        $("#q16,#q17,#q18").addClass('hide');
      }
    }

    function anycontact(){
     if ($('input:radio[name=anycontact]:checked').val()=="Yes"){
                  $(".q31").removeClass('hide');
                }
                else{
                 $(".q31").addClass('hide');
                }
    
    }
    });

