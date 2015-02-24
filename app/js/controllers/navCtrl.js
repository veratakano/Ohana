
'use strict';

app.controller('navController', ['$scope','$location','loginService','sessionService', 
	function($scope,$location,loginService,sessionService) {

    $scope.logout=function(){
        loginService.logout();
    }

    $scope.viewProfile=function(){
        $location.path('/profile/' + sessionService.get('uid'));
    }
    
}]);