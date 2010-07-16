// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(document).ready(function(){
    //initial the process bar
    $("#complete").addClass("first");
    //update the process bar
    function updateSteps(fields){
      var length = fields.length;
      if (length >0){
      $("#complete").removeClass();
      $("#complete").addClass(fields[length-1]); 
     }
     navigationbutton();
     confirmpage();
    }

    function confirmpage(){
      $("#confirm-title").html($("#post_title").val());
      $("#confirm-story").html($("#post_body").val());
      $("#confirm-suggestion").html($("#post_suggestion").val());
      $("#confirm-storydetail").html("<p>"+$("#post_who_id").val()+" is "+$("#storydata_gender").val()+" aged "+$("#storydata_age").val()+"</p>");
      $("#confirm-storywhere").html("<p>"+$("#address_address_line1").val()+" "+$("#address_address_line2").val()+" "+$("#address_city").val()+" "+$("#address_county").val()+" "+$("#address_postcode").val()+"</p>");
      $("#confirm-storytag").html("<p>"+$("#post_tag_list").val()+"</p>");
      $("#confirm-storyrating").html("<img src='/images/ratingbar"+$('#storydata_wholerating').val()+".png' alt='rating'");
    }

    //formwizard configure
    $("#new_post").formwizard({
      historyEnabled:false,
      formPluginEnabled:true,
      validationEnabled:true,
      focusFirstInput:true,
      inAnimation:"slideDown",
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
                "post[body]":{
                      required:true,
                      minlength:140
                }
           },
        messages:{
                 "post[body]":"More than 140 characters would be great",
                 "post[title]":"4-140 characters would be great"
                 },
          errorElement:"div",
        errorPlacement: function(error, element) {
                offset=element.offset();
                error.insertBefore(element);
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
            $("#date_happened_on_month").slideDown("slow");}
          else{
            $("#date_happened_on_month").hide();
            $("#date_happened_on_day").hide();
          }
          });
      $("#date_happened_on_month").change(function(){
          if($(this).val()){
            $("#date_happened_on_day").slideDown("slow");
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
      $('#address_country').val(island);
      $('#address_county').val(county);
      $('#address_city').val(city);
      $('#address_address_line2').val(streetName);
      $('#address_postcode').val(postcode);
      $.fancybox.close();
      });

  function codeAddress() {
    marker.setMap(null); 
    var address = document.getElementById("address").value;
    if (geocoder) {
      geocoder.geocode({'address': address}, function(results, status) {
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
    var sevenlevels = ["Completely dissatisfie","Very dissatisfied","Fairly dissatisfied","Neither satisfied nor dissatisfied","Fairly satisfied","Very satisfied","Completely satisfied"]; 
    function ratebar(name, bar, val){
      $("#"+bar).slider({
        value:3,
        min:0,
        max:6,
        step:1,
        slide:function(event,ui){
          $("#storydata_"+name).val(ui.value);
          $("#"+val).empty();
          $("#"+val).append(sevenlevels[ui.value]);
        }    
          });
       $("#storydata_"+name).val($("#"+bar).slider("value"));
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
        var current_question = [1];
        var question_steps = [1,2,3,4,5];
        navigationbutton();
        $("#nextbt").click(function(){
            nextpage();
            });
        $("#backbt").click(function(){
            backpage();
            });
        $("input:radio[name=storydata[contact]]").change(function(){
              contactcheck();});

        $("input:radio[name=storydata[isreport]]").change(function(){
                isreport();
               });
        $("input:radio[name=storydata[anycontact]]").change(function(){
               anycontact();
               });
            
    function contactcheck(){
       if ($('input:radio[name=storydata[contact]]:checked').val()=="true"){
        $("#q12, #q13,#q14,#q15").slideDown("slow");
       }
       else{
        $("#q12, #q13,#q14,#q15,#q16,#q17,#q18,#q2,#q3,#q4,#q5").slideUp("slow");
       }
    }

    function isreport(){
      if ($('input:radio[name=storydata[isreport]]:checked').val()=="true")
      {
        $("#q16,#q17,#q18").slideDown("slow");
      }else
      {
        $("#q16,#q17,#q18").slideUp("slow");
      }
    }
    function anycontact(){
     if ($('input:radio[name=storydata[anycontact]]:checked').val()=="true"){
                  $(".q31").slideDown("slow");
                }
                else{
                 $(".q31").slideUp("slow");
                }
    
    }

    function nextpage(){
        var current = parseInt(current_question[current_question.length-1]);
        var step = current+1;
        $("#q"+current).hide();
        $("#q"+step).slideDown("slow");
        current_question.push(step);
        navigationbutton();
    }
    
      function backpage(){
        var current = parseInt(current_question[current_question.length-1]);
        var backstep = current-1;
        $("#q"+current).hide();
        $("#q"+backstep).slideDown("slow");
        current_question.pop();
        navigationbutton();
    }

    function navigationbutton(){
      for(i=1; i<6; i++){
       if($.inArray(i,current_question)>-1){
        $("#l"+i).addClass("active");
       }
       else{
        $("#l"+i).removeClass("active");
       }
      } 

      if ($("#new_post").formwizard("state").currentStep=="third"){
      if(current_question.length>1){
        $("#backbt").removeClass("hide");
        $("#back").addClass("hide");
        }else{
        $("#backbt").addClass("hide");
        $("#back").removeClass("hide");
        }
      if(current_question.length>4){

        $("#nextbt").addClass("hide");
        $("#next").removeClass("hide");
      }
      else{
        $("#nextbt").removeClass("hide");
        $("#next").addClass("hide");
      }
      }
      else{
       $("#next").removeClass("hide");
        $("#back").removeClass("hide");
      }
    }

    });


  

