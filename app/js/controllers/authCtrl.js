
'use strict';

app.controller('authCtrl',['$scope', '$rootScope', 'loginService', function ($scope, $rootScope, loginService) {

  $scope.msgtxt='';
  
  $scope.login=function(credentials){
    loginService.login(credentials,$scope, $rootScope); //call login service
  };

   $scope.signup=function(credentials){
    loginService.signup(credentials,$scope, $rootScope); //call login service
  };

}]);