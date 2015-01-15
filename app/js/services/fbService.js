'use strict';

app.factory('fbService', ['$location','$window', '$rootScope', 'sessionService', function($location, $window, $rootScope, sessionService){
	return{
		login:function(){
			FB.login(function(response) {
   				 if (response.status === 'connected') {
   				 	$rootScope.$apply(function() {
   				 		sessionService.set('unqid',response.authResponse.userID);
    					$location.path('dashboard');
 					});
   				 }
   				
 			}, {scope: 'user_relationships'});
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
		getUserInfo:function(){
			FB.api('/me/family ', function(response) {
				if (response && !response.error) {
					console.log(response);
				}
    		});
		}
	}
}]);