'use strict';

app.controller('settingCtrl',['$scope','$rootScope','sessionService','treeService','loginService',
	function ($scope,$rootScope,sessionService,treeService,loginService) {

    if(!!sessionService.get('uid')){
        $scope.validUser = true;
    }

    loginService.getUserInfo(sessionService.get('uid')).then(function(data) {
        $scope.user = data;
        $scope.fullName = $scope.user.firstName + ' ' + $scope.user.lastName;
    });

    treeService.getTreeFirstMember(sessionService.get('treeownid')).then(function(data) {
        $scope.profilePic = $rootScope.apiVersion + 'getProfImg.php?id=' + data.memberID;
    });


}]);