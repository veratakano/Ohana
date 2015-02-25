
'use strict';

app.controller('profileCtrl', ['memberDetails','$route','$location','$rootScope','$scope','ngDialog','memberService',
	function(memberDetails,$route,$location,$rootScope,$scope,ngDialog,memberService) {

	if(memberDetails == 'null'){
		$location.path('/profile_not_found')
	} else{
		$scope.profileExist = true;
	}

	$scope.member = memberDetails;
	$scope.fullName = $scope.member.firstName + " " + $scope.member.lastName;
	$scope.profilePic = $rootScope.apiVersion + 'getProfImg.php?id=' + $scope.member.memberID;

	// Get Gallery
	memberService.memberGetGal($scope.member.memberID).then(function(data) {
		$scope.thumbnails = data;
	});

	// Get Family Memebers
	memberService.getMemberFamily($scope.member.memberID,$scope.member.treeID).then(function(data) {
		$scope.family = data;
	});

	// Open Popup for editing of profile
	$scope.editProf = function () {
		ngDialog.open({
        	template: 'editProf',
			className: 'ngdialog-theme-default ngdialog-theme-custom-profile',
			scope: $scope,
			controller: 'editCtrl'
		});
  	};

	// Open Popup for uploading of Profile Pic
  	$scope.uploadProfPic = function () {
		ngDialog.open({
        	template: 'uploadProfPic',
			className: 'ngdialog-theme-default ngdialog-theme-custom-profile',
			data: {id: $scope.member.memberID, tree: $scope.member.treeID},
			controller: 'uploadProfCtrl'
		});
  	};

  	// Open Popup for uploading of Galllery Pictures
  	$scope.uploadGal = function () {
		ngDialog.open({
        	template: 'uploadGal',
			className: 'ngdialog-theme-default ngdialog-theme-custom-profile',
			data: {id: $scope.member.memberID, tree: $scope.member.treeID},
			controller: 'uploadGalCtrl',
			preCloseCallback: function() {
				$route.reload();
			}
		});
  	};
  
}]);

// Open Popup Controller
app.controller('editCtrl', ['$scope','$filter','memberService', function($scope,$filter,memberService){

	$scope.member.dateOfBirth = $filter('date')($scope.member.dateOfBirth, "dd/MM/yyyy");

	$scope.updateMember = function(member){
		$scope.$broadcast('show-errors-check-validity');
		if ($scope.frmEditMember.$valid) {
			$scope.loading = true;
			memberService.updateMember($scope.member).then(function(data) {
				if(data.status = "successful"){
					$scope.success = data.message;
				} else {
					$scope.error = data.message;
				}
				$scope.loading = false;
			});
		}
	}
 
}]);

// Open Popup Controller
app.controller('uploadProfCtrl', ['$scope','$rootScope','$timeout','$upload', function($scope,$rootScope,$timeout,$upload){

	 $scope.generateThumb = function(file) {
		if (file != null) {
			$scope.errorMsg = null;
			if (file.type.indexOf('image') > -1) {
				$timeout(function() {
					var fileReader = new FileReader();
					fileReader.readAsDataURL(file);
					fileReader.onload = function(e) {
						$timeout(function() {
							file.dataUrl = e.target.result;
						});
					}
				});
			}
		}
	}

	$scope.uploadPic = function(file) {
		$scope.formUpload = true;
		if (file != null) {
			file.upload = $upload.upload({
				url: $rootScope.apiVersion + 'upload_image.php',
				method: 'POST',
				headers: {
					'my-header' : 'my-header-value'
				},
				fields: {memberID: $scope.ngDialogData.id, treeID: $scope.ngDialogData.tree},
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

// Open Popup Controller
app.controller('uploadGalCtrl', ['$http','$scope','$rootScope','$timeout','$upload', function($http,$scope,$rootScope,$timeout,$upload){


	$scope.$watch('files', function(files) {
		$scope.formUpload = false;
		if (files != null) {
			for (var i = 0; i < files.length; i++) {
				$scope.errorMsg = null;
				(function(file) {
					generateThumb(file);
				})(files[i]);
			}
		}
	});
	
	$scope.upload = function() {
		for (var i = 0; i < $scope.files.length; i++) {
			$scope.errorMsg = null;
			uploadUsing$upload($scope.files[i]);
		}
	}

	$scope.remove = function(file) { 
  		var index = $scope.files.indexOf(file)
  		$scope.files.splice(index, 1);
	}
	
	var generateThumb = function(file) {
		if (file != null) {
			//if ($scope.fileReaderSupported && file.type.indexOf('image') > -1) {
				$timeout(function() {
					var fileReader = new FileReader();
					fileReader.readAsDataURL(file);
					fileReader.onload = function(e) {
						$timeout(function() {
							file.dataUrl = e.target.result;
						});
					}
				});
			//}
		}
	}
	
	function uploadUsing$upload(file) {
		file.upload = $upload.upload({
			url: $rootScope.apiVersion + 'upload_gal_image.php',
			method: 'POST',
			headers: {
				'my-header' : 'my-header-value'
			},
			fields: {memberID: $scope.ngDialogData.id, treeID: $scope.ngDialogData.tree},
			file: file,
			fileFormDataName: 'image',
		});

		file.upload.then(function(response) {
			$timeout(function() {
				if (response.data.status == 'error'){
					file.errorMsg = response.data.message;
				}
			});
		}, function(response) {
			if (response.data.status == 'error')
				file.errorMsg = response.data.status + ': ' + response.data.message;
		});

		file.upload.progress(function(evt) {
			// Math.min is to fix IE which reports 200% sometimes
			file.progress = Math.min(100, parseInt(100.0 * evt.loaded / evt.total));
		});

		file.upload.xhr(function(xhr) {
			// xhr.upload.addEventListener('abort', function(){console.log('abort complete')}, false);
		});
	}

		
	$scope.confirm = function() {
		return confirm('Are you sure? Your local changes will be lost.');
	}
	
	$scope.getReqParams = function() {
		return $scope.generateErrorOnServer ? "?errorCode=" + $scope.serverErrorCode + 
				"&errorMessage=" + $scope.serverErrorMsg : "";
	}

	angular.element(window).bind("dragover", function(e) {
		e.preventDefault();
	});
	angular.element(window).bind("drop", function(e) {
		e.preventDefault();
	});
 
}]);




