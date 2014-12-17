'use strict';

app.controller('dashboardCtrl', ['$scope','loginService','treeService', function($scope,loginService,treeService){

	$scope.txt='Dashboard';
	
	$scope.logout=function(){
		loginService.logout();
	}

  $scope.flowchart = treeService.getTreeData();

  $scope.$on('onRepeatLast', function(scope, element, attrs){
     
       var connections = $scope.flowchart.connections;
       angular.forEach(connections, function(idx, elm) {
           jsPlumb.connect({
                source: idx.from,
                target: idx.to,
                endpoint:[ "Rectangle", { width:10, height:10 }, "Rectangle", { width:10, height:8 } ],
                anchors:[ idx.pos1, idx.pos2],
                connector:[ "Flowchart" ]
            });
        });
    });

   
}])