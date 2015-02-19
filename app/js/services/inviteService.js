'use strict';

app.factory('inviteService', ['$http','$rootScope', 
	function($http,$rootScope){
	return{
		inviteSend:function(member){
			var promise = $http.post(
	      		$rootScope.apiVersion + 'email_invite.php', 
	      		{
	      			member:member
	      		}
	    		).then(function(output){
	    			return output.data;
				});
				return promise;		   
		},
		inviteStatusUpdate:function(member,status){
			var promise = $http.post(
	      		$rootScope.apiVersion + 'updateMember.php', 
	      		{
	      			type: 'invite',
	      			status: status,
	      			member:member
	      		}
	    		).then(function(output){
	    			return output.data;
				});
				return promise;		   
		},
		insertShareTree:function(member,treeID){
			var promise = $http.post(
	      		$rootScope.apiVersion + 'createShareTree.php', 
	      		{
	      			member:member,
	      			tree:treeID
	      		}
	    		).then(function(output){
	    			return output.data;
				});
				return promise;	
		}
	}

}]);