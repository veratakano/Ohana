'use strict';

app.controller('searchCtrl',['$location','$routeParams','$scope','$rootScope','searchService', 
	function ($location,$routeParams,$scope,$rootScope, searchService) {
	
    $scope.params = $routeParams;
    if(!!$scope.params.ss){
        $scope.keybords = $scope.params.ss
        searchService.searchProfile($scope.params.ss).then(function(data) {
            $scope.result = data;
        });
    }

	$scope.search = function (){
        if($scope.keybords != ""){
            searchService.searchProfile($scope.keybords).then(function(data) {
        	   $scope.result = data;
            });
        }
    };

    $scope.viewProf = function(memb){
        $location.path('/profile/'+memb.memberID);
    }
  
}]);