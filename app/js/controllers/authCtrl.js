
'use strict';

app.controller('authCtrl',['$location','$scope','$rootScope','$routeParams','loginService','fbService','sessionService', 
  function ($location, $scope,$rootScope,$routeParams,loginService,fbService,sessionService) {

    $scope.params = $routeParams;

    $scope.login=function(credentials){

      loginService.login(credentials).then(function(data) {
        var obj = angular.fromJson(data);
        if(obj.status == "success"){
          sessionService.set('unqid',obj.unqid);
          sessionService.set('uid',obj.uid);
          sessionService.set('email',obj.email);
          sessionService.set('treeownid',obj.treeid);
          sessionService.set('treeid',obj.treeid);
          $location.path('dashboard');
        }        
        else  {
          $scope.message = obj.message;
        }
      });
    };

    $scope.signup=function(credentials){
      //call Signup service
       loginService.signup(credentials,$scope.params).then(function(data) {
          var obj = angular.fromJson(data);
          if(obj.status == "success"){
              sessionService.set('unqid',obj.unqid);
              sessionService.set('uid',obj.uID);
              sessionService.set('email',obj.email);
              sessionService.set('treeownid',obj.treeid);
              sessionService.set('treeid',obj.treeid);
              $location.path('dashboard');
          }        
          else  {
            $scope.message = obj.message;
          }
      });
    }

    $scope.fbLogin = function(){
      fbService.login($scope,$scope.params);
    };

 
}]);