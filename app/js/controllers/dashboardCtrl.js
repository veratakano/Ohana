'use strict';

app.controller('dashboardCtrl', ['$scope','loginService', function($scope,loginService){
	
	$scope.txt='Dashboard';
	
	$scope.logout=function(){
		loginService.logout();
	}
	
}])