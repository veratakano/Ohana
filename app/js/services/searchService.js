'use strict';

app.factory('searchService', ['$http','$rootScope', 
	function($http,$rootScope){
	return{
		
		searchProfileByName:function(credentials){

			var promise = $http.post(
	      		$rootScope.apiVersion + 'search.php', 
	      		{
	      			value:credentials,
					type:1
	      		}
	    		).then(function(output){
	    			return output.data;
				});

				return promise;		   
		}
		
	}

}]);