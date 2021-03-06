
'use strict';

app.controller('dashboardCtrl', ['$anchorScroll','$location','$window','$rootScope','$scope','$route','$sce','ngDialog','sessionService','treeService', 
  function($anchorScroll,$location,$window,$rootScope,$scope,$route,$sce,ngDialog,sessionService,treeService){

  treeService.getTreeMain(sessionService.get('uid')).then(function(data) {
    $scope.treeMain = data;
  });

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
app.controller('memberActions', ['$scope','$rootScope','$location','memberService','inviteService','ngDialog','sessionService','treeService',
  function($scope,$rootScope,$location,memberService,inviteService,ngDialog,sessionService,treeService){

  var ownT = sessionService.get('treeownid');
  var currT = sessionService.get('treeid');

  if(ownT == currT){
    $scope.allowAccess = true;
  }

  treeService.getTreeFirstMember(ownT).then(function(data) {
    $scope.fm = data;
    memberService.getMemberRelation($scope.ngDialogData.id).then(function(data) {
        if (data == 'null'){
          $scope.isSpouse = true;
        }
    });
    memberService.memberGet($scope.ngDialogData.id).then(function(data) {
      $scope.member = data;
      $scope.fullName = $scope.member.firstName + " " + $scope.member.lastName;
      $scope.profilePic = $rootScope.apiVersion + 'getProfImg.php?id=' + $scope.member.memberID;

      $scope.iStatus = $scope.member.inviteStatus;

      if($scope.ngDialogData.id == $scope.fm.memberID){
        $scope.tOwner = true;
      }

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
  });

  $scope.addMemeber = function(){
    $location.path('/create_member/' + $scope.member.memberID);
    ngDialog.close();
  }

  $scope.viewProfile = function(){
    $location.path('/profile/' + $scope.member.memberID);
    ngDialog.close();
  }
  
  $scope.deleteProfile = function() {  
  	var fName = $scope.member.firstName;
  	var lName = $scope.member.lastName;
  	if (!fName) { fName = "Unknown"; }
  	if (!lName) { lName = ""; }
    ngDialog.close();
    bootbox.confirm("Are you sure you want to delete " + fName + " " + lName + "?", function(result) {
      if(result == true) {
        memberService.deleteProfile($scope.member);
      }
    }); 
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
