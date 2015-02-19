'use strict';

app.factory('memberService', ['$http','$rootScope', 
	function($http,$rootScope){
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
		},
		memberGetGal: function(memberID){
			var promise = $http.post(
	      		$rootScope.apiVersion + 'getMemberGal.php', 
	      		{
	      			member:memberID
	      		}
	    		).then(function(output){
	    			return output.data;
				});

				return promise;		   
		},
		memberIsUser: function(memberID){
			var promise = $http.post(
	      		$rootScope.apiVersion + 'getMemberUser.php', 
	      		{
	      			member:memberID
	      		}
	    		).then(function(output){
	    			return output.data;
				});

				return promise;		  
		},
		addParent:function(credentials){

			var promise = $http.post(
	      		$rootScope.apiVersion + 'addFamily.php', 
	      		{
	      			user:credentials,
					type:'1'
	      		}
	    		).then(function(output){
	    			return output.data;
				});

				return promise;		   
		},
		
		// if siblings, get the father and mother IDs of selected member
		// if offsprings, get the memberID and spouseID of selected parent
		addBrother:function(credentials){

			var promise = $http.post(
	      		$rootScope.apiVersion + 'addFamily.php', 
	      		{
	      			user:credentials,
					type:'2'
	      		}
	    		).then(function(output){
	    			return output.data;
				});

				return promise;		   
		},
		addSister:function(credentials){

			var promise = $http.post(
	      		$rootScope.apiVersion + 'addFamily.php', 
	      		{
	      			user:credentials,
					type:'3'
	      		}
	    		).then(function(output){
	    			return output.data;
				});

				return promise;		   
		},
		addSon:function(credentials){

			var promise = $http.post(
	      		$rootScope.apiVersion + 'addFamily.php', 
	      		{
	      			user:credentials,
					type:'4'
	      		}
	    		).then(function(output){
	    			return output.data;
				});

				return promise;		   
		},
		addDaughter:function(credentials){

			var promise = $http.post(
	      		$rootScope.apiVersion + 'addFamily.php', 
	      		{
	      			user:credentials,
					type:'5'
	      		}
	    		).then(function(output){
	    			return output.data;
				});

				return promise;		   
		},
		addSpouse:function(credentials){

			var promise = $http.post(
	      		$rootScope.apiVersion + 'addFamily.php', 
	      		{
	      			user:credentials,
					type:'6'
	      		}
	    		).then(function(output){
	    			return output.data;
				});

				return promise;		   
		}
		
	}

}]);