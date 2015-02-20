'use strict';

app.controller('searchCtrl',['$location', '$scope', '$rootScope', 'searchService', 
	function ($location, $scope, $rootScope, searchService) {
	// alert("here");

	$scope.currentForm = 'form.parent';

	$scope.searchProfile=function(credentials){
	     alert(credentials.firstName);
	   searchService.searchProfileByName(credentials);
  };
  
}]);