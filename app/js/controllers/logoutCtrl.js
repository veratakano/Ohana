
'use strict';

app.controller('logoutCtrl',['$scope', 'loginService', 
	function ($scope, loginService) {

  loginService.logout();

}]);