'use strict';

app.factory('loginService', ['$http','$location', '$rootScope', 'sessionService', function($http, $location, $rootScope, sessionService){
	return{
		login:function(credentials,scope){
			$http.post(
      		$rootScope.apiVersion + 'authentication.php', 
      		{
      			user:credentials,
      			mode: 'login'
      		}
    		).success(function(output){
				var obj = angular.fromJson(output);

				var uid=obj.uid;
				if(obj.status == "success"){

					//scope.msgtxt='Correct information';
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
		logout:function(){
			sessionService.destroy('unqid');
			$location.path('/login');
		}
	}

}]);