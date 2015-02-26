'use strict';

app.factory('memberService', ['$http','$q','$rootScope', 
	function($http,$q,$rootScope){
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
		getMemberSetbyTreeID:function(memberID){
			var promise = $http.post(
	      		$rootScope.apiVersion + 'getMemberSet.php'
	    		).then(function(output){
	    			return output.data;
				});
				return promise;		   
		},
		getMemberRelation:function(memberID){
			var promise = $http.post(
	      		$rootScope.apiVersion + 'getMemberRelation.php',
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
		getMemberFamily:function(memberID, treeID){
			var promise = $http.post(
	      		$rootScope.apiVersion + 'getFamilyMember.php', 
	      		{
	      			member:memberID,
	      			tree:treeID
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
					type:'1',
					link: document.URL
					
	      		}
	    		).then(function(output){
	    			return output.data;
				}, function(response) {
	                // something went wrong
	                return $q.reject(response.data);
	            });

				return promise;		   
		},
		
		// if siblings, get the father and mother IDs of selected member
		// if offsprings, get the memberID and spouseID of selected parent
		addSibing:function(credentials){

		
			var promise = $http.post(
	      		$rootScope.apiVersion + 'addFamily.php', 
	      		{
	      			user:credentials,
					type:'2',
					link: document.URL
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
					type:'4',
					link: document.URL
	      		}
	    		).then(function(output){
	    			return output.data;
				});

				return promise;		   
		},
		addChildren:function(credentials){

			
			var promise = $http.post(
	      		$rootScope.apiVersion + 'addFamily.php', 
	      		{
	      			user:credentials,
					type:'3',
					link: document.URL
	      		}
	    		).then(function(output){
	    			return output.data;
				});

				return promise;		   
		},
		updateMember: function(member){
			var promise = $http.post(
	      		$rootScope.apiVersion + 'updateMember.php', 
	      		{
	      			member:member
	      		}
	    		).then(function(output){
	    			return output.data;
				});

				return promise;		   
		},
		deleteProfile: function(member){
			var promise = $http.post(
	      		$rootScope.apiVersion + 'deleteFamily.php', 
	      		{
	      			member:member
	      		}
	    		).then(function(output){
	    			return output.data;
				});

				return promise;		   
		},
	}

}]);