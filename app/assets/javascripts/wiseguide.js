$(document).ready(function(){
  // global AJAX setup
  $(document).ajaxStart(function(e) {
    $('body').ajaxLoader();
  }).ajaxStop(function(e) {
    $('body').ajaxLoaderRemove();
  });
    
  $("tr.auto-zebra:odd").addClass("odd");
  
  $('#flash a.closer').click(function() {
    $('#flash').animate({ height: 0, opacity: 0, marginTop: "-10px", marginBottom: "-10px" }, 'slow').hide();
    return false;
  });
  
  // toggle-next links toggle the next sibling
  $("body").on("click", "[data-behavior=toggle-next]", function(e){
    var link = $(this).hide();
    link.next().show();
    
    e.preventDefault();
  });
  
  // date picker
  $('.datepicker').datepicker({
    buttonText: "Select",
    dateFormat: 'yy-mm-dd',
  });
  
  // time picker
  $('.timepicker').timepicker({
    timeFormat: "hh:mm TT",
    stepMinute: 5,
  });

  // datetime picker
  $('.datetimepicker').datetimepicker({
    buttonText: "Select",
    dateFormat: "yy-mm-dd",
    defaultValue: null,
    numberOfMonths: 1,
    showOn: "button",
    stepMinute: 15,
    timeFormat: 'hh:mm TT',
  });
  
  $('.birthdatepicker').datepicker({
    buttonText: "Select", 
    changeYear: true,
    dateFormat: 'yy-mm-dd',
    showOn: "button",
    yearRange: '1900:2010'
  });
  
  // auto-resizing text areas
  autosize($("textarea[data-behavior=autoresize]"));
  autosize($("body.surveyor textarea"));
  autosize($("body.surveys textarea"));

  // Disable table header styles that are not on first line of table in surveys
  $("body.surveyor tr").not(":first-child").find("th").css("background", "none").css("color", "#444")
  
  // Don't allow an end date before today
  $('.trip-authorizations #trip_authorization_end_date').datepicker('option', 'minDate', new Date());

  // Highlight the relevant field if the customer does not authorize leaving a voicemail
  function highlightNoVoiceMail(){
    $(".vm").each(function(index, field) {
      var fld = $(field)
      if (fld.val() == "false" && fld.parent().siblings("input.phone").first().val().length > 0) {
        fld.parent().addClass("stand-out")
      } else {
        fld.parent().removeClass("stand-out")
      }
    });
  }

  highlightNoVoiceMail();

  $(".vm, .phone").change(highlightNoVoiceMail);
});
