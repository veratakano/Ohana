'use strict';

app.factory('loginService', ['$http','$location','$window', '$rootScope', 'sessionService', 
	function($http, $location, $window, $rootScope, sessionService){
	return{
		getUserInfo: function(credential){
			var promise = $http.post(
	      		$rootScope.apiVersion + 'getUserInfo.php',
	      		{
	      			user:credential
	      		}
	    		).then(function(output){
	    			return output.data;
				});

				return promise;		 
		},
		updateUser: function(uid,credential,treePrivacy){
			var promise = $http.post(
	      		$rootScope.apiVersion + 'updateUser.php',
	      		{
	      			userid:uid,
	      			user:credential,
	      			privacy:treePrivacy
	      		}
	    		).then(function(output){
	    			return output.data;
				});

				return promise;		 
		},
		updateFB: function(uid,fbID){
			var promise = $http.post(
	      		$rootScope.apiVersion + 'updateUserFacebook.php',
	      		{
	      			userid:uid,
	      			fbID:fbID
	      		}
	    		).then(function(output){
	    			return output.data;
				});

				return promise;		 
		},
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
		resetPassword:function(credentials){
			var promise = $http.post(
	      		$rootScope.apiVersion + 'resetPassword.php', 
	      		{
	      			email:credentials.email
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