'use strict';

app.factory('emailService', ['$http','$rootScope', function($http,$rootScope){
	return{
		inviteSend:function(emailadd){
			var promise = $http.post(
	      		$rootScope.apiVersion + 'sendInvite.php', 
	      		{
	      			email:emailadd
	      		}
	    		).then(function(output){
	    			return output.data;
				});
				return promise;		   
		}
	}

}]);