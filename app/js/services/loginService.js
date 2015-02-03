'use strict';

app.factory('loginService', ['$http','$location','$window', '$rootScope', 'sessionService', function($http, $location, $window, $rootScope, sessionService){
	return{
		signup:function(credentials,scope){
			$http.post(
	      		$rootScope.apiVersion + 'registration.php', 
	      		{
	      			user:credentials
	     		}
	    		).success(function(output){
					var obj = angular.fromJson(output);
					var uid = obj.uid;
					if(obj.status == "success"){
						sessionService.set('unqid',obj.unqid);
						sessionService.set('uid',obj.uid);
						sessionService.set('email',obj.email);
						$location.path('dashboard');
					}	       
					else  {
						scope.message = obj.message;
					}
				}).error(function(){
      		});		   
		},
		login:function(credentials){

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
			//$location.path('/login');
		}
	}

}]);