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
//= require jquery_ujs
//= require twitter/bootstrap
//= require chosen.jquery.min
//= require jquery.tools.min
//= require_tree .

jQuery.expr[':'].regex = function(elem, index, match) {
    var matchParams = match[3].split(','),
        validLabels = /^(data|css):/,
        attr = {
            method: matchParams[0].match(validLabels) ? 
                        matchParams[0].split(':')[0] : 'attr',
            property: matchParams.shift().replace(validLabels,'')
        },
        regexFlags = 'ig',
        regex = new RegExp(matchParams.join('').replace(/^\s+|\s+$/g,''), regexFlags);
    return regex.test(jQuery(elem)[attr.method](attr.property));
}

$('document').ready(function(){
	
	$('.chzn-select').chosen();	
	$(".date-picker").dateinput({    
		format: 'yyyy/mm/dd',              
		offset: [0, 0],            
		speed: 'fast'
	});
	$('#submit-search').click(function(){
		var spinner = new Spinner().spin();
		$('#multiplex-respond').html("");		
		$('#multiplex-respond').prepend(spinner.el);
	});
	
	$('select#city').live("change" , function() {
	  var city = $('select#city option:selected').val();
	  var url = '/update_multiplex_cinecol?city='+ city;
	  $('#multiplex-container').load(url , function(){
		$('.chzn-select').chosen();
		$("select#multiplex").trigger('liszt:updated');	
	  });
	
	});
	
	$('select#city_royal').live("change" , function() {
	  var city = $('select#city_royal option:selected').val();
	  var url = '/update_multiplex_royal?city='+ city;
	  $('#multiplex-container').load(url , function(){
		$('.chzn-select').chosen();
		$("select#multiplex").trigger('liszt:updated');	
	  });
	
	});
	
	$('select#multiplex').live("change",function(){
		var city =  $('select#city option:selected').val();
		var date =  $('input#date').val();
		var mul =  $('select#multiplex option:selected').val();
		var spinner = new Spinner().spin();
		$('#multiplex-respond').html("");		
		$('#multiplex-respond').prepend(spinner.el);
		var rq_url = "/search_multiplex.js?city=" + city + "&date=" + date + "&multiplex=" + mul; 
		$.ajax({
		  url: rq_url
		}).done(function(){
			spinner.stop();
		});
	});
	
	$('select#multiplex_royal').live("change",function(){
		var city =  $('select#city_royal option:selected').val();
		var mul =  $('select#multiplex_royal option:selected').val();
		var rq_url = "/search_multiplex_royal.js?city=" + city + "&multiplex=" + mul; 
		var spinner = new Spinner().spin();
		$('#multiplex-respond').html("");
		$('#multiplex-respond').prepend(spinner.el);
		$.ajax({
		  url: rq_url
		}).complete(function(){
			$('#multiplex-respond').html($('#multiplex-respond td:regex(width,755)').html());
			$("#multiplex-respond table").addClass("table table-striped");
			spinner.stop();
		});
	});
	
});