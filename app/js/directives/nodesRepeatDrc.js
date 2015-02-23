
'use strict';

app.filter('bytes', function() {
	return function(bytes, precision) {
		if (isNaN(parseFloat(bytes)) || !isFinite(bytes)) return '-';
		if (typeof precision === 'undefined') precision = 1;
			var units = ['bytes', 'kB', 'MB', 'GB', 'TB', 'PB'],
			number = Math.floor(Math.log(bytes) / Math.log(1024));
			return (bytes / Math.pow(1024, Math.floor(number))).toFixed(precision) + ' ' + units[number];
	}
}); 


app.filter('checkUnknown', function() {
	return function(input) {
		return input ? input : 'Unknown';
	}
}); 

app.filter('gender', function() {
	return function(input) {
		if(!input){
			return 'Unknown';
		}
		else {
			if(input == 'M'){
				return 'Male';
			} else {
				return 'Female';
			}
		}
	}
}); 

app.filter('vitalStatus', function() {
	return function(input) {
		if(!input){
			return 'Unknown';
		}
		else {
			if(input == '1'){
				return 'Living';
			} else {
				return 'Deceased';
			}
		}
	}
}); 