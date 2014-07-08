$(function(){
	$('[data-behaviour~=datepicker]').datepicker({
		format: 'mm/dd/yyyy'
	});
	
	var thisCalendar = calendar;
	thisCalendar.init();
});



var calendar = (function(){

	var cal = {};
	
	//Module Variables
	var now = moment();
	cal.start = moment().startOf('day');
	cal.end  = now.add('days',7).endOf('day');	
	
	cal.init = function(){			
		$.ajax({
			url: '/api/allocations.json',
			data: {'start': this.start.toISOString(), 'end': this.end.toISOString()  },
			context: this,
			success: function(d){
				this.createCal(d)
			},
			error: function(qXHR,textStatus,errorThrown){
				cal.showError(qXHR,textStatus,errorThrown);
			}
		})	
	}
	
	cal.createCal = function(d){
		console.log(d);
		var source = $('#sliderTemplate').html();
		var rowTemplate = Handlebars.compile(source);
		var output = rowTemplate(d);
		$('.gridSlider').html(output);
		this.calLayout();
	}
	
	cal.createError = function(qXHR,textStatus,errorThrown){
		console.log(qXHR,textStatus,errorThrown);	
	}
	
	cal.calLayout = function(note){
		var width = $('.userAllocations').width();
		var scope = this;
		$('.userAllocation').each(function(){
			var startDate = moment($(this).attr('data-start'));
			var endDate = moment($(this).attr('data-end'));
			//Find how many days past the start/end dates we are.
			var startOffset = moment(startDate).diff(moment(scope.start));
			var endOffset = moment(endDate).diff(moment(scope.end));
			
			
			var lengthInDays = 0;
			
			if(startOffset<0 && endOffset<0){
				lengthInDays = 7;
			}else if(startOffset > 0 && endOffset > 0){
				startDays = Math.round(startOffset/1000/60/60/24);
				endDays = Math.round(endOffset/1000/60/60/24);
				lengthInDays = (startDays + endDays) -7;
			}else if(startOffset > 0){
				lengthInDays = Math.floor(startOffset/1000/60/60/24)-7;
			}else{
				lengthInDays = Math.floor(endOffset/1000/60/60/24)-7;
			}
			console.log(lengthInDays, startDate, endDate);
			
		});
		
	}
	
	//Now give it back to the caller;
	return cal;
	
}());