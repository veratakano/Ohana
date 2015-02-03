
'use strict';

app.controller('authCtrl',['$location', '$scope', '$rootScope', 'loginService','fbService','sessionService', function ($location, $scope, $rootScope, loginService, fbService, sessionService) {

  $scope.msgtxt='';
  
  $scope.login=function(credentials){

    loginService.login(credentials).then(function(data) {
      var obj = angular.fromJson(data);
      if(obj.status == "success"){
        sessionService.set('unqid',obj.unqid);
        sessionService.set('uid',obj.uid);
        sessionService.set('email',obj.email);
        $location.path('dashboard');
      }        
      else  {
        $scope.message = obj.message;
      }
    });
  };

   $scope.signup=function(credentials){
    loginService.signup(credentials, $scope); //call login service
  };

  $scope.fbLogin = function(){
	fbService.login($scope);
  };

 
}]);