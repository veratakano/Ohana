'use strict';

app.factory('treeService', ['$http', '$rootScope', 
	function($http, $rootScope){
	return{
		getTreeData:function(){
			var promise = $http.post(
	      		$rootScope.apiVersion + 'getTree.php', 
	      		{
	      			//user:credentials
	      		}
	    		).then(function(output){
	    			return output.data;
				});

			return promise;	
		},
		getTreeOwner:function(treeID){
			var promise = $http.post(
	      		$rootScope.apiVersion + 'getTreeOwner.php', 
	      		{
	      			treeID:treeID
	      		}
	    		).then(function(output){
	    			return output.data;
				});

			return promise;	
		},
		getTreeShared: function(uid){
			var promise = $http.post(
	      		$rootScope.apiVersion + 'getTreeShared.php', 
	      		{
	      			userID:uid
	      		}
	    		).then(function(output){
	    			return output.data;
				});

			return promise;	
		}
	};
}])