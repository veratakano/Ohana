'use strict';

app.factory('searchService', ['$http','$rootScope', 
	function($http,$rootScope){
	return{
		searchProfile:function(keyword,gender,vs){
			var promise = $http.post(
	      		$rootScope.apiVersion + 'search.php', 
	      		{
	      			keyword:keyword,
					gender:gender,
					vs:vs
	      		}
	    		).then(function(output){
	    			return output.data;
				});

				return promise;		   
		}
	}

}]);