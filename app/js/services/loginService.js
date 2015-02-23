'use strict';

app.factory('loginService', ['$http','$location','$window', '$rootScope', 'sessionService', 
	function($http, $location, $window, $rootScope, sessionService){
	return{
		signup:function(credentials,inviteparams){
			var promise = $http.post(
	      		$rootScope.apiVersion + 'registration.php', 
	      		{
	      			user:credentials,
	      			invite:inviteparams
	      		}
	    		).then(function(output){
	    			return output.data;
				});

				return promise;		 
		},
		login:function(credentials,inviteparams){
			var promise = $http.post(
	      		$rootScope.apiVersion + 'authentication.php', 
	      		{
	      			user:credentials
	      		}
	    		).then(function(output){
	    			return output.data;
				});

				return promise;		   
		},
		logout:function(){
			sessionService.destroy();
			$window.location.reload();
			//$window.location.href = '#/';
			$location.path('/login');
		}
	}

}]);