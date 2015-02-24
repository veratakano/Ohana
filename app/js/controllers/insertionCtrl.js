'use strict';

app.controller('insertionCtrl',['$location','$scope','$rootScope','$timeout','$upload','$routeParams','memberService','memberRelation', 
	function ($location, $scope, $rootScope,$timeout,$upload,$routeParams,memberService,memberRelation) {

	$scope.relation = memberRelation;
	
	$scope.selTab=function(){
		if ($scope.relation.fatherID == 0){
			return 1;
		}else{
			return 2;
		}
	  
	};

	$scope.imgFile = "api/v1/getProfImg.php?id=0";
	$scope.fimgFile = $scope.imgFile;
	$scope.mimgFile = $scope.imgFile;


	$scope.generateThumb = function(file,role) {
		if (file != null) {
			$scope.errorMsg = null;
			if (file.type.indexOf('image') > -1) {
				$timeout(function() {
					var fileReader = new FileReader();
					fileReader.readAsDataURL(file);
					fileReader.onload = function(e) {
						$timeout(function() {
							if(role == 'father'){
								$scope.flblpicFile = file.name;
								$scope.fimgFile = e.target.result;
							}else if(role == 'mother'){
								$scope.mlblpicFile = file.name;
								$scope.mimgFile = e.target.result;
							} else {
								$scope.lblpicFile = file.name;
								$scope.imgFile = e.target.result;
							}
						});
					}
				});
			}
		}
	}

   $scope.addParent=function(credentials){
   		memberService.addParent(credentials).then(function(data) {
			memberService.getMemberRelation(memberRelation.memberID).then(function(data) {
					uploadPic(credentials.fpicFile, data.fatherID, data.treeID);
					uploadPic(credentials.mpicFile, data.motherID, data.treeID);
			});
		});
	};
  
   $scope.addSibling=function(credentials){
	   memberService.addSibing(credentials).then(function(data) {
	   		uploadPic(credentials.picFile, data.sibling_id, $scope.relation.treeID);
	   });
	};
  
  
	$scope.addChildren=function(credentials){
		memberService.addChildren(credentials).then(function(data) {
	   		uploadPic(credentials.picFile, data.offspring_id, $scope.relation.treeID);
	   });
	};


	$scope.addSpouse=function(credentials){
	   memberService.addSpouse(credentials).then(function(data) {
	   		uploadPic(credentials.picFile, data.spouse_id, $scope.relation.treeID);
	   });
	};

	var uploadPic = function(file, memberID, treeID) {
		$scope.formUpload = true;
		if (file != null) {
			file.upload = $upload.upload({
				url: $rootScope.apiVersion + 'upload_image.php',
				method: 'POST',
				headers: {
					'my-header' : 'my-header-value'
				},
				fields: {memberID: memberID, treeID: treeID},
				file: file,
				fileFormDataName: 'image',
			});

			file.upload.then(function(response) {
				$timeout(function() {
					file.result = response.data.status;
				});
			}, function(response) {
				if (response.data.status == 'error')
					$scope.errorMsg = response.data.status + ': ' + response.data.message;
			});

			file.upload.progress(function(evt) {
				// Math.min is to fix IE which reports 200% sometimes
				file.progress = Math.min(100, parseInt(100.0 * evt.loaded / evt.total));
			});

			file.upload.xhr(function(xhr) {
				// xhr.upload.addEventListener('abort', function(){console.log('abort complete')}, false);
			});
		}else {
			$scope.errorMsg = "Please select an image.";
		}
	}



}]);