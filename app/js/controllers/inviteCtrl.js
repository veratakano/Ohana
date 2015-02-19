 
'use strict'; 

app.controller('inviteCtrl',['$scope','$location','$routeParams','memberService','treeService','inviteService',
  function ($scope,$location,$routeParams,memberService,treeService,inviteService) {

	$scope.params = $routeParams;

	if(!$scope.params.mid){
		treeService.getTreeOwner($scope.params.tid).then(function(data) {
			$scope.owner = data;
			$scope.newUser = true;
			$scope.loadingView = true;
		});
	} else {
		memberService.memberIsUser($scope.params.mid).then(function(data) {
			$scope.memberisUser = data;
			memberService.memberGet($scope.params.mid).then(function(data) {
				$scope.member = data;
				treeService.getTreeOwner($scope.params.tid).then(function(data) {
					$scope.owner = data;
					$scope.loadingView = true;
				});
			});
		});
	};

	$scope.inviteReject = function(){
		$scope.rloading = true;
		inviteService.inviteStatusUpdate($scope.member.memberID,'rejected').then(function(data) {
			$scope.reject = data;
			if($scope.reject.status == 'success'){
				$scope.success = $scope.reject.message;
			} else {
				$scope.error = $scope.reject.message;
			}
			$scope.rloading = false;
		});
	};

	$scope.inviteAccept = function(){
		$scope.aloading = true;
		inviteService.inviteStatusUpdate($scope.member.memberID,'accepted').then(function(data) {
			if(data.status == 'success'){
				inviteService.insertShareTree($scope.memberisUser.uID, $scope.params.tid).then(function(data) {
					if(data.status == 'success'){
						$scope.success = data.message;
					} else {
						$scope.error = data.message;
					}
				});
			} else {
				$scope.error = data.message;
			}
			$scope.aloading = false;
		});
	};

	$scope.inviteSignUp = function(){
		$location.path('signup');
	};
 
}]);