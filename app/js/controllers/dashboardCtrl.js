
'use strict';

app.controller('dashboardCtrl', ['$rootScope','$scope','$route','ngDialog','loginService','treeService', function($rootScope,$scope,$route,ngDialog,loginService,treeService){

	$scope.txt='Dashboard';
	
	$scope.logout=function(){
		loginService.logout();
	};

  $scope.openDialog = function (id,title,gender) {

        ngDialog.open({
          template: 'userDialogId',
          className: 'ngdialog-theme-default ngdialog-theme-custom',
          data: {id: id, title: title, gender: gender},
          controller: 'SomeController'
        });
  };

  $rootScope.$on('ngDialog.closed', function (e, $dialog) {
    
    var gen3 = ({
              "gen": "3",
              'nodes': [
                  {
                    'id': 5,
                    'title': 'Grandson',
                    'text': '',
                    'top': 200,
                    'left': 20,
                  },
                  {
                    'id': 6,
                    'title': 'Granddaughter',
                    'text': '',
                    'top': 20,
                    'left': 500,
                  },
                ]
         });

    var connG31 = ({'from': 'node5', 'to': 'node2', 'pos1':'TopCenter', 'pos2':'Bottom'});
    var connG32 = ({'from': 'node6', 'to': 'node2', 'pos1':'TopCenter', 'pos2':'Bottom'});

    //$scope.flowchart.generations.push(gen3);
    //$scope.flowchart.connections.push(connG31);
    //$scope.flowchart.connections.push(connG32);

    //$route.reload();
  });

  //$scope.flowchart = treeService.getTreeData();

  $scope.$on('onRepeatLast', function(scope, element, attrs){  
       var connections = $rootScope.flowchart.connections;
       angular.forEach(connections, function(idx, elm) {
            //jsPlumb set container
           jsPlumb.setContainer($("#treeView"));
           jsPlumb.connect({
                source: idx.from,
                target: idx.to,
                endpoint:[ "Rectangle", { width:10, height:10 }, "Rectangle", { width:10, height:8 } ],
                anchors:[ idx.pos1, idx.pos2],
                connector:[ "Flowchart" ]
            });
        });


       /*jsPlumb.connect({
                source: idx.from,
                target: idx.to,
                detachable: false,
                paintStyle: {
                  strokeStyle: '#005b0f',
                  lineWidth: '1'
                },
                hoverPaintStyle: {
                  strokeStyle: '#ff0000',
                  lineWidth: '2'
                },
                dragOptions: {
                  cursor: "pointer",
                  zIndex: 2000
                },
                endpoint: "Blank",
                endpoint:[ "Rectangle", { width:10, height:10 }, "Rectangle", { width:10, height:8 } ],
                anchors:[idx.pos1, idx.pos2],
                connector:[ "Flowchart", { alwaysRespectStubs: true, cornerRadius: 0, gap:0,stub:[30, 30]} ]
            });*/
    });
   
}])

app.controller('SomeController', ['$scope', '$location', 'ngDialog', function($scope,$location,ngDialog){
            $scope.openEdit = function(){
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
            }
}]);
