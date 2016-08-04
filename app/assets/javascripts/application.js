// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require jquery-ui/accordion
//= require jquery-ui/datepicker
//= require autocomplete-rails
//= require jquery.fileupload
//= require bootstrap
//= require_self
//= require nprogress
//= require chosen.jquery
//= require_tree .


//s=0;
var delay = (function(){
  var timer = 0;
  return function(callback, ms){
    clearTimeout (timer);
    timer = setTimeout(callback, ms);
  };
})();

var PhoneQuery = (function(){
  $.get($("#f_search").attr("action"), $("form").serialize(), null, "script");
})

var showNotifications = function(){
  var time = 5000;
  $nt = $(".alert");
  if ($nt.hasClass('flash_success')){ time = 2000; }
  setTimeout(function() {
    //$nt.removeClass("in");
    //$nt.delay(1500).addClass('out').delay(1000).removeClass('out');
    $nt.slideDown('slow').delay(3000).addClass('out');
    //setTimeout("$nt.addClass('out')",1000);
  }, time);
}

function capitalize(a) {
    newVal = '';
    a = a.split(' ');
    for (var c = 0; c < a.length; c++) {
        newVal += a[c].substring(0, 1).toUpperCase() + a[c].substring(1, a[c].length)+' '
    }
    return newVal.substring(0, newVal.length-1)
}



$(function() {

  NProgress.configure({
    showSpinner: false,
    ease: 'ease',
    speed: 300
  });

  NProgress.start();
  NProgress.done();

  $('.chosen').chosen();
  $('.schosen').chosen();
  $('.menu .chosen-container').css({"width": "170px", "margin-right": '8px'});


  $( document ).ajaxStart(function() {
      NProgress.start();
  });

  $( document ).ajaxStop( function() {
    $('[data-toggle="tooltip"]').tooltip({'placement': 'top', fade: false});
    NProgress.done();
  });


  $('[data-toggle="tooltip"]').tooltip({'placement': 'top', fade: false});


 $('.datepicker').datepicker();
  $( document ).ajaxStop(function() {
    $('table.tableSorter').tableSort();
  });
  $('table.tableSorter').tableSort();

  $('.switcher_a').each(function(){
        var switcher = $(this);
        var link = $(this).find('.link_a');
        var scale = $(this).find('.scale');
        var handle = $(this).find('.handle');
        var details = switcher.parent().find('.details');

        $(link).click(function(event){
            switcher.toggleClass('toggled');
            link.toggleClass('on');
            var attr = link.hasClass('on') ? 'on' : 'off'
            link[0].innerHTML = link.attr(attr);
            handle.toggleClass('active');

            if(switcher.hasClass('toggled')){
                details.slideDown(300);

            } else {
                details.slideUp(300);

            }
            sortable_query({only_actual:link.hasClass('on')});
            return false;
        });

        $(scale).click(function(event){
            switcher.toggleClass('toggled');
            link.toggleClass('on');
            link[0].innerHTML = link.attr(link.hasClass('on') ? 'on' : 'off');
            handle.toggleClass('active');

            if(switcher.hasClass('toggled')){
                details.slideDown(300);
            } else {
                details.slideUp(300);
            }
            sortable_query({only_actual:link.hasClass('on')});
            return false;
        });



    });


 //$( "#accordion" ).accordion();
// $( "#accordion" ).accordion( "option", "active", {  animate: 200} );


  $("#phones th a, #phones .pagination a").on("click", function() {
    $.getScript(this.href);
    return false;
  });

      var accordion_head = $('.accordion > li > a'),
        accordion_body = $('.accordion li > .sub-menu');

      // Open the first tab on load
      m_active = parseInt($('.accordion').attr('active'));
      accordion_head.eq(m_active).addClass('active').next().slideDown('normal');
      accordion_head.on('click', function(event) {
        event.preventDefault();

        if ($(this).attr('class') != 'active'){
          accordion_body.slideUp('normal');
          $(this).next().stop(true,true).slideToggle('normal');
          accordion_head.removeClass('active');
          $(this).addClass('active');
        }

      });



  $("#group_mags_search input").keyup(function(event) {


	var c= String.fromCharCode(event.keyCode);

    var c= String.fromCharCode(event.keyCode);
    var isWordcharacter = c.match(/\w/);

    if (isWordcharacter || event.keyCode ==8){
        s=1;
        setTimeout( function(){ if (s==1){
              $.get($("#group_mags_search").attr("action"), $("#phones_search").serialize(), null, "script");
              s=0;}
              return false;},400);
        }

    return false;
  });



  $('#f_search input').on('keyup', function(e) {
    var c, isBackspaceOrDelete, isWordCharacter;
    c = String.fromCharCode(event.keyCode);
    isWordCharacter = c.match(/\w/);
    isBackspaceOrDelete = event.keyCode === 8 || event.keyCode === 46;
    if (isWordCharacter || isBackspaceOrDelete) {
      delay('PhoneQuery({})', 700);
    }
  });

  $("input#phone_otdel_name").keyup(function() {
    var c = String.fromCharCode(event.keyCode);
    var isWordcharacter = c.match(/\w/);

    if (isWordcharacter || event.keyCode ==8 || event.keyCode ==32 ){
       $(this).val($(this).val().toUpperCase());

    }


    return false;
  });


});


