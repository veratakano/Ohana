'use strict';

app.controller('settingCtrl',['$scope','$rootScope','sessionService','treeService','loginService','ngDialog','fbService',
	function ($scope,$rootScope,sessionService,treeService,loginService,ngDialog,fbService) {

    if(!!sessionService.get('uid')){
        $scope.validUser = true;
    }

    loginService.getUserInfo(sessionService.get('uid')).then(function(data) {
        $scope.user = data;
        $scope.fullName = $scope.user.firstName + ' ' + $scope.user.lastName;
        $scope.fbConnected = $scope.user.fbID;
    });

    treeService.getTreeFirstMember(sessionService.get('treeownid')).then(function(data) {
        $scope.profilePic = $rootScope.apiVersion + 'getProfImg.php?id=' + data.memberID;
    });

    //Open Popup for members
   $scope.editUser = function () {
      ngDialog.open({
        template: 'editUser',
        className: 'ngdialog-theme-default ngdialog-theme-custom-profile',
        scope: $scope,
        controller: 'editUser'
      });
   };

   $scope.signinFB = function(){
    fbService.loginUpdate(sessionService.get('uid'),$scope);
   }


}]);

// Open Popup Controller
app.controller('editUser', ['$scope','$rootScope','treeService','sessionService','loginService',
  function($scope,$rootScope,treeService,sessionService,loginService){

    treeService.getTreeData(sessionService.get('uid')).then(function(data) {
        $scope.privacy = data.privacy;
    });

    $scope.updateUser = function(){
       $scope.$broadcast('show-errors-check-validity');
         if($scope.frmEditUser.$valid) {
            $scope.loading = true;
            loginService.updateUser(sessionService.get('uid'),$scope.user,$scope.privacy).then(function(data) {
                if(data.status = "success"){
                    $scope.success = data.message;
                } else {
                    $scope.error = data.message;
                }
                $scope.loading = false;
            });
        }
    }
    


 }]);