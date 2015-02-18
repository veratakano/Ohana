'use strict';

app.factory('treeService', ['$http','$location', '$rootScope', 'sessionService', 
	function($http, $location, $rootScope, sessionService){
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
		}
	};
}])