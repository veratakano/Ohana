'use strict';

app.factory('sessionService', ['$http','$rootScope', 
	function($http, $rootScope){
	return{
		set:function(key,value){
			return sessionStorage.setItem(key,value);
		},
		setPHPSession:function(key,value){
			var promise = $http.post(
	      		$rootScope.apiVersion + 'storeToSession.php', 
	      		{
	      			key:key,
	      			value:value
	      		}
	    		).then(function(output){
	    			return output.data;
				});

			return promise;
		},
		get:function(key){
			return sessionStorage.getItem(key);
		},
		destroy:function(){
			$http.post($rootScope.apiVersion + 'destroy_session.php');
			return sessionStorage.clear();
		}
	};
}])