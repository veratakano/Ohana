
'use strict';

app.controller('authCtrl',['$location','$scope','$rootScope','$routeParams','loginService','fbService','sessionService', 
  function ($location, $scope,$rootScope,$routeParams,loginService,fbService,sessionService) {

    $scope.params = $routeParams;


    $scope.login=function(){

      $scope.$broadcast('show-errors-check-validity');

      if ($scope.loginForm.$valid) {
        $scope.loading = true;

        loginService.login($scope.credentials).then(function(data) {
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
          $scope.loading = false;
        });
      }
    };

    $scope.signup=function(){

      $scope.$broadcast('show-errors-check-validity');

      if ($scope.signupForm.$valid) {
        $scope.loading = true;
        //call Signup service
         loginService.signup($scope.credentials,$scope.params).then(function(data) {
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
            $scope.loading = false;
        });
      }
    }

    $scope.fbLogin = function(){
      fbService.login($scope);
    };

    $scope.reset = function(){
      $scope.success = '';
      $scope.error = '';
      $scope.$broadcast('show-errors-check-validity');
      if ($scope.resetForm.$valid) {
        $scope.loading = true;
        loginService.resetPassword($scope.credentials).then(function(data) {
          if(data.status == "success"){
            $scope.success = data.message;
          } else  {
            $scope.error = data.message;
          }
          $scope.loading = false;
        });
      }
    };

 
}]);