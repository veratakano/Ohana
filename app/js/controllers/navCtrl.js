
'use strict';

app.controller('navController', ['$scope','$location','loginService','sessionService', 
	function($scope,$location,loginService,sessionService) {

    $scope.logout=function(){
        loginService.logout();
    }

    $scope.viewProfile=function(){
        $location.path('/profile/' + sessionService.get('uid'));
    }

    $scope.search = function(searchStr){
        //$scope.searchStr = '';
        if(!!searchStr){
    	   $location.path('/search_profile/' + searchStr );
        }
    }
    
}]);