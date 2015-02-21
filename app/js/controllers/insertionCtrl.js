'use strict';

app.controller('insertionCtrl',['$location', '$scope', '$rootScope', 'memberService', 
	function ($location, $scope, $rootScope, memberService) {

	$scope.currentForm = 'form.parent';
	

	$scope.selFrom = function (tab) {
        $scope.currentTab = tab.id;
    }

   $scope.addParent=function(credentials){
	   
	   memberService.addParent(credentials);
	};
  
   $scope.addSibling=function(credentials){
	  
	   memberService.addSibing(credentials);
	};
  
  
	$scope.addChildren=function(credentials){
	   
	   memberService.addChildren(credentials);
	};


	$scope.addSpouse=function(credentials){
	   
	   memberService.addSpouse(credentials);
	};
}]);