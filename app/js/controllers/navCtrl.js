'use strict';

app.controller('navController', ['$scope', 'loginService', function($scope, loginService) {

    $scope.logout=function(){
        loginService.logout();
    }
    
}]);