'use strict';

app.factory('memberService', ['$http','$rootScope', function($http,$rootScope){
	return{
		memberGet:function(memberID){
			var promise = $http.post(
	      		$rootScope.apiVersion + 'getMember.php', 
	      		{
	      			member:memberID
	      		}
	    		).then(function(output){
	    			return output.data;
				});
				return promise;		   
		}
	}

}]);