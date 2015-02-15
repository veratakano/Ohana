'use strict';

app.controller('insertionCtrl',['$location', '$scope', '$rootScope', 'memberService', function ($location, $scope, $rootScope, memberService) {
	alert("here");
   $scope.addParent=function(credentials){
	   //alert(credentials);
	   memberService.addParent(credentials);
  };
  
   $scope.addBrother=function(credentials){
	   // alert(credentials);
	   memberService.addBrother(credentials);
  };
  
  $scope.addSister=function(credentials){
	   alert(credentials);
	   memberService.addSister(credentials);
  };
  
   $scope.addSon=function(credentials){
	   // alert(credentials);
	   memberService.addSon(credentials);
  };
  
  $scope.addDaughter=function(credentials){
	   alert(credentials);
	   memberService.addDaughter(credentials);
  };
  
  $scope.addSpouse=function(credentials){
	   alert(credentials);
	   memberService.addSpouse(credentials);
  };
}]);