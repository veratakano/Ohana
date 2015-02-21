
'use strict';

app.controller('logoutCtrl',['$scope','$location','loginService', 
	function ($scope, loginService) {

  loginService.logout();

}]);