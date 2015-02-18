
'use strict';

app.controller('dashboardCtrl', ['$rootScope','$scope','$route','ngDialog','loginService','treeService', 
  function($rootScope,$scope,$route,ngDialog,loginService,treeService){
	
	$scope.logout=function(){
		loginService.logout();
	};

  treeService.getTreeData().then(function(data) {
    $scope.tree = data;
  });

  //var tree = treeService.getTreeData();

   //Open Popup for members
   $scope.openDialog = function (id) {
         ngDialog.open({
           template: 'userDialogId',
           className: 'ngdialog-theme-default ngdialog-theme-custom',
           data: {id: id},
           controller: 'dialogCtrl'
         });
   };

  /*$scope.$on('onRepeatLast', function(scope, element, attrs){  
       var connections = $rootScope.flowchart.connections;
       angular.forEach(connections, function(idx, elm) {
            //jsPlumb set container
           jsPlumb.setContainer($("#treeView"));
           //jsPlumb Draw relation
           jsPlumb.connect({
                source: idx.from,
                target: idx.to,
                endpoint:[ "Rectangle", { width:10, height:10 }, "Rectangle", { width:10, height:8 } ],
                anchors:[ idx.pos1, idx.pos2],
                connector:[ "Flowchart" ]
            });
        });
    });*/
   
}])

// Open Popup Controller
app.controller('dialogCtrl', ['$scope','memberService','emailService', function($scope,memberService,emailService){

  memberService.memberGet($scope.ngDialogData.id).then(function(data) {
    $scope.member = data;
  });

  $scope.sendInvite = function(){
    $scope.loading = true;
    emailService.inviteSend($scope.member).then(function(data) {
      $scope.message = data.message;
    }, function ( response ) {
    // TODO: handle the error somehow
    }).finally(function() {
    // called no matter success or failure
      $scope.loading = false;
    });
  }
            
           /* $scope.openEdit = function(){
               ngDialog.close();
               ngDialog.open({
                template: 'editDialogId',
                scope: $scope,
                className: 'ngdialog-theme-default ngdialog-theme-custom',
               });
            };
            $scope.openProfile = function(){
               ngDialog.close();
               $location.path('/profile/' + $scope.ngDialogData.id);
            }*/
}]);
