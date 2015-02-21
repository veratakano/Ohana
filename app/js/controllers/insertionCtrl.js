'use strict';

app.controller('insertionCtrl',['$location', '$scope', '$rootScope', 'memberService', 
	function ($location, $scope, $rootScope, memberService) {
	alert(document.URL);

	$scope.currentForm = 'form.parent';

	$scope.selFrom = function (tab) {
        $scope.currentTab = tab.id;
    }

   $scope.addParent=function(parents){
	   console.log(parents);
	   //memberService.addParent(parents);
	};
  
   $scope.addSibling=function(sibling){
	   console.log(sibling);
	  // memberService.addSibing(sibling);
	};
  
   //$scope.addSon=function(credentials){
	   // alert(credentials);
	  // memberService.addSon(credentials);
	//};
  
	$scope.addChildren=function(children){
	   console.log(children);
	   //memberService.addDaughter(children);
	};

	//$scope.addDaughter=function(credentials){
	   //alert(credentials);
	   //memberService.addDaughter(credentials);
	//};
  
	$scope.addSpouse=function(spouse){
	   console.log(spouse);
	  //memberService.addSpouse(spouse);
	};
}]);