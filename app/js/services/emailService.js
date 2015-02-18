'use strict';

app.factory('emailService', ['$http','$rootScope', 
	function($http,$rootScope){
	return{
		inviteSend:function(member){
			var promise = $http.post(
	      		$rootScope.apiVersion + 'gmail_test.php', 
	      		{
	      			member:member
	      		}
	    		).then(function(output){
	    			return output.data;
				});
				return promise;		   
		}
	}

}]);