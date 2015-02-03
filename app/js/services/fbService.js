'use strict';

app.factory('fbService', ['$location','$window', '$rootScope', 'sessionService','loginService', function($location, $window, $rootScope, sessionService,loginService){
	return{
		login:function(scope){
			FB.login(function(response) {
   				 if (response.status === 'connected') {
   				 	$rootScope.$apply(function() {
   				 		FB.api('/me ', function(response) {
							if (response && !response.error) {
								var credentials = {
						 			"fname": response.first_name,
						 			"lname": response.last_name,
						 			"email": response.email,
						 			"fbID" : response.id
								};
								loginService.login(credentials).then(function(data) {
							      var obj = angular.fromJson(data);
							      if(obj.status == "success"){
							        sessionService.set('unqid',obj.unqid);
							        sessionService.set('uid',obj.uid);
							        sessionService.set('email',obj.email);
							        $location.path('dashboard');
							      }        
							      else  {
							        loginService.signup(credentials,scope);
							      }
							    });
							}
    					});
 					});
   				 }
   				
 			}, {scope: 'email,user_relationships'});
		},
		watchAuthenticationStatusChange:function(){
			var _self = this;

			FB.getLoginStatus(function(response) {

				if (response.status === 'connected') {
					FB.api('/me/family ', function(response) {
      					if (response && !response.error) {
        					console.log(response);
      					}
    				});
				}
			});
		},
		getUserInfo:function(callback){
			FB.api('/me', function(response){
                callback(response);
            });
			/*FB.api('/me/family ', function(response) {
				if (response && !response.error) {
					console.log(response);
				}
    		});*/
		}
	}
}]);