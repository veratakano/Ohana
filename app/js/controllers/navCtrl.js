
'use strict';

app.controller('navController', ['$scope','$location','loginService','sessionService','treeService',
	function($scope,$location,loginService,sessionService,treeService) {

    $scope.logout=function(){
        loginService.logout();
    }

    $scope.viewProfile=function(){
        treeService.getTreeFirstMember(sessionService.get('treeownid')).then(function(data) {
            $location.path('/profile/' + data.memberID);
        });
    }

    $scope.search = function(searchStr){
        //$scope.searchStr = '';
        if(!!searchStr){
    	   $location.path('/search_profile/' + searchStr );
        }
    }
    
}]);