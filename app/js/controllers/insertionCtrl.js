'use strict';

app.controller('insertionCtrl',['$location', '$scope', '$rootScope', 'memberService', function ($location, $scope, $rootScope, memberService) {
	alert("here");
   $scope.addParent=function(credentials){
	   alert(credentials);
	   memberService.addParent(credentials);
  };
}]);