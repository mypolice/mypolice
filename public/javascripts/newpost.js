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
      focusFirstInpur:true,
      afterNext:function(wizardData){
        updateSteps(wizardData.activatedSteps);
        var l = wizardData.activatedSteps.length
        if($.inArray("fifth",wizardData.activatedSteps)>0){
        $("#next_button").hide();
        }
      },
      afterBack:function(wizardData){
        updateSteps(wizardData.activatedSteps);        
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
                      minlength:100
                },
                "address[postcode]":{
                      required:true,
                      postcode:true
                }
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
              $('#next_button').empty();
              $('#back_button').empty();
              $("#formcontent").append("<h2> Thanks! Your Story has been submitted and should appear on the site shortly. In the meantime, explore the other <a href='/posts'>Stories</a> on MyPolice</h2>");

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
    });
