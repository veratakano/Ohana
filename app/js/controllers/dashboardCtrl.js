
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
           template: 'userDialogId',
           className: 'ngdialog-theme-default ngdialog-theme-custom',
           data: {id: id},
           controller: 'dialogCtrl'
         });
   };


}])

// Open Popup Controller
app.controller('dialogCtrl', ['$scope','memberService','inviteService', function($scope,memberService,inviteService){

  memberService.memberGet($scope.ngDialogData.id).then(function(data) {
    $scope.member = data;
  });

  $scope.sendInvite = function(){
    $scope.loading = true;
    inviteService.inviteSend($scope.member).then(function(data) {
      $scope.message = data.message;
    }, function ( response ) {
    // TODO: handle the error somehow
    }).finally(function() {
    // called no matter success or failure
      $scope.loading = false;
    });
  }
            

}]);
