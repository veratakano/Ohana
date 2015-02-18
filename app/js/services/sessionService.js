'use strict';

app.factory('sessionService', ['$http','$rootScope', 
	function($http, $rootScope){
	return{
		set:function(key,value){
			return sessionStorage.setItem(key,value);
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