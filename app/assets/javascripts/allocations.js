$(function(){
	console.log('on');
	var datepicker_params = {pickTime:false};
	
	$('#allocation_start_date, #allocation_end_date').datetimepicker(datepicker_params);
})