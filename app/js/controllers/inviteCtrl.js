
'use strict'; 

app.controller('inviteCtrl',['$scope','$rootScope','$routeParams', 'memberService', 
  function ($scope,$rootScope,$routeParams,memberService) {

  $scope.params = $routeParams;

  memberService.memberGet($scope.params.mID).then(function(data) {
  		$scope.member = data;
	});

  


 
}]);