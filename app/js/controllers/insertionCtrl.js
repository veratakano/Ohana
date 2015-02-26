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

	$scope.originalSibling = angular.copy($scope.sibling);

	$scope.imgFile = "api/v1/getProfImg.php?id=0";
	$scope.fimgFile = $scope.imgFile;
	$scope.mimgFile = $scope.imgFile;

	$scope.clear = function(type){
		switch(type){
			case 'parents':
				clearParForm()
				break;
			case 'sibling':
				clearSibForm()
				break;
			case 'spouse':
				clearSpoForm()
				break;
			case 'offspring':
				clearOFForm()
				break;
			default:
				break;
		}
		
	}

	var clearParForm = function(){
		$scope.$broadcast('show-errors-reset');
		$scope.parents = {
	    	fFirstName: '',
	    	fLastName: '',
	    	fPOB: '',
	    	fEmail: '',
	    	fDOB: '',
	    	mpicFile: '',
	    	mFirstName: '',
	    	mLastName: '',
	    	mPOB: '',
	    	mEmail: '',
	    	mDOB: '',
	    	mpicFile: ''
		};
		$scope.psuccess = '';
		$scope.pberror = '';
		$scope.flblpicFile = '';
		$scope.mlblpicFile = '';
		$scope.fimgFile = "api/v1/getProfImg.php?id=0";
		$scope.mimgFile = "api/v1/getProfImg.php?id=0";
    	$scope.frmAddParent.$setPristine();
	}

	var clearSibForm = function(){
		$scope.$broadcast('show-errors-reset');
		$scope.sibling = {
	    	fName: '',
	    	lName: '',
	    	POB: '',
	    	email: '',
	    	DOB: '',
	    	picFile: ''
		};
		$scope.sbsuccess = '';
		$scope.sberror = '';
		$scope.lblpicFile = '';
		$scope.imgFile = "api/v1/getProfImg.php?id=0";
    	$scope.frmAddSibling.$setPristine();
	}

	var clearSpoForm = function(){
		$scope.$broadcast('show-errors-reset');
		$scope.spouse = {
	    	fName: '',
	    	lName: '',
	    	POB: '',
	    	email: '',
	    	DOB: '',
	    	picFile: '',
		};
		$scope.spsuccess = '';
		$scope.sperror = '';
		$scope.lblpicFile = '';
		$scope.imgFile = "api/v1/getProfImg.php?id=0";
    	$scope.frmAddSpouse.$setPristine();
	}

	var clearOFForm = function(){
		$scope.$broadcast('show-errors-reset');
		$scope.children = {
	    	fName: '',
	    	lName: '',
	    	POB: '',
	    	email: '',
	    	DOB: '',
	    	picFile: '',
		};
		$scope.csuccess = '';
		$scope.cerror = '';
		$scope.lblpicFile = '';
		$scope.imgFile = "api/v1/getProfImg.php?id=0";
    	$scope.frmAddChildren.$setPristine();
	}


	$scope.generateThumb = function(file,role) {
		if (!!file) {
			$scope.result = null;
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
		} else {
			file.result = "JPG and JPEG only.";
		}
	}

   $scope.addParent=function(){
   		$scope.$broadcast('show-errors-check-validity');
   		if ($scope.frmAddParent.$valid) {
   			$scope.ploading = true;
   			memberService.addParent($scope.parents).then(function(data) {
				uploadPic($scope.parents.fpicFile, data.ids.father_id, $scope.relation.treeID);
				uploadPic($scope.parents.mpicFile, data.ids.mother_id, $scope.relation.treeID);
				if(data.status == "success"){
					$scope.psuccess = data.message;
				} else {
					$scope.perror = data.message;
				}
				$scope.ploading = false;
			}, function(error) {
	               $scope.perror = "Error, please contact the administrator.";
	               $scope.ploading = false;
	         });
   		}

	};
  
   $scope.addSibling=function(){
   	console.log($scope.sibling);
   		$scope.$broadcast('show-errors-check-validity');
   		if ($scope.frmAddSibling.$valid) {
   			$scope.sbloading = true;
	   		memberService.addSibing($scope.sibling).then(function(data) {
	   			uploadPic($scope.sibling.picFile, data.ids.sibling_id, $scope.relation.treeID);
	   			if(data.status == "success"){
	   				$scope.sbsuccess = data.message;
				} else {
					$scope.sberror = data.message;
				}
				$scope.sbloading = false;
	   		});
	   	}
	};
  
  
	$scope.addChildren=function(){
		$scope.$broadcast('show-errors-check-validity');
		if ($scope.frmAddChildren.$valid) {
			$scope.cloading = true;
			memberService.addChildren($scope.children).then(function(data) {
	   			uploadPic($scope.children.picFile, data.ids.offspring_id, $scope.relation.treeID);
	   			if(data.status == "success"){
	   				$scope.csuccess = data.message;
				} else {
					$scope.cerror = data.message;
				}
				$scope.cloading = false;
	   		});
	   	}
	};


	$scope.addSpouse=function(){
		$scope.$broadcast('show-errors-check-validity');
		if ($scope.frmAddSpouse.$valid) {
			$scope.sploading = true;
	   		memberService.addSpouse($scope.spouse).then(function(data) {
	   			uploadPic($scope.spouse.picFile, data.ids.spouse_id, $scope.relation.treeID);
	   			if(data.status == "success"){
	   				$scope.spsuccess = data.message;
				} else {
					$scope.sperror = data.message;
				}
				$scope.sploading = false;
	   		});
	   	}
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
					if (response.data.status == 'error'){
						file.errorMsg = response.data.message;
					}else{
						file.result = true;
					};
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