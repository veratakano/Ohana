
'use strict';

app.controller('dashboardCtrl', ['$window','$rootScope','$scope','$route','ngDialog','sessionService','treeService', 
  function($window,$rootScope,$scope,$route,ngDialog,sessionService,treeService){

  $scope.ownTree = sessionService.get('treeownid');
	
  treeService.getTreeShared(sessionService.get('uid')).then(function(data) {
    if(data != ''){
      $scope.sharetrees = data;
      $scope.hasShareTree = true;
    }else{
     $scope.hasShareTree = false;
    }
  });

  $scope.changeTree = function(tree){
    sessionService.setPHPSession('treeid',tree.treeID).then(function(data) {
      sessionService.set('treeid',tree.treeID);
      $window.location.reload();
    });
  };

  $scope.changeOwnTree = function(treeid){
    sessionService.setPHPSession('treeid',treeid).then(function(data) {
      sessionService.set('treeid',treeid);
      $window.location.reload();
    });
  };

   //Open Popup for members
   $scope.openDialog = function (id) {
         ngDialog.open({
           template: 'memberAction',
           className: 'ngdialog-theme-default ngdialog-theme-custom-profile-tree',
           data: {id: id},
           controller: 'memberActions'
         });
   };


}])

// Open Popup Controller
app.controller('memberActions', ['$scope','$rootScope','$location','memberService','inviteService','ngDialog','sessionService',
  function($scope,$rootScope,$location,memberService,inviteService,ngDialog,sessionService){

  memberService.memberGet($scope.ngDialogData.id).then(function(data) {
    $scope.member = data;
    $scope.fullName = $scope.member.firstName + " " + $scope.member.lastName;
    $scope.profilePic = $rootScope.apiVersion + 'getProfImg.php?id=' + $scope.member.memberID;

    $scope.iStatus = $scope.member.inviteStatus;

    $scope.showEmail = function() {
      if (!$scope.member.email){
        return false;
      }else{
        if ($scope.member.email == sessionService.get('email')) {
          return false;
        }else{
          return true;
        }
      }
    };
  });

  $scope.addMemeber = function(){
    $location.path('/create_member/' + $scope.member.memberID);
    ngDialog.close();
  }

  $scope.viewProfile = function(){
    $location.path('/profile/' + $scope.member.memberID);
    ngDialog.close();
  }

  $scope.sendInvite = function(){
    $scope.loading = true;
    inviteService.inviteSend($scope.member).then(function(data) {
      $scope.status = true;
      if(data.status == 'success'){
        $scope.success = true;
      }else{
        $scope.error = true;
      }
    }, function ( response ) {
     //handle the error
     $scope.error = true;
    }).finally(function() {
    // called no matter success or failure
      
    });
  }
            

}]);
