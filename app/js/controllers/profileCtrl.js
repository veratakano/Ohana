
'use strict';

app.controller('profileCtrl', ['$rootScope','$scope', '$routeParams','ngDialog', 'memberService', function($rootScope, $scope, $routeParams, ngDialog,memberService) {

	$scope.params = $routeParams;

	memberService.memberGet($scope.params.profID).then(function(data) {
		$scope.id = data.memberID; 
		$scope.tree = data.treeID;
		$scope.fullName = data.firstName + " " + data.lastName;
		$scope.dob = data.dateOfBirth;
		$scope.gender = data.gender;
		$scope.born = data.countryOfBirth;
		$scope.profilePic = $rootScope.apiVersion + 'getProfImg.php?id=' + $scope.id;
	});

	// Open Popup for members
  	$scope.uploadProfPic = function () {
		ngDialog.open({
        	template: 'uploadProfPic',
			className: 'ngdialog-theme-default ngdialog-theme-custom-profile',
			data: {id: $scope.id, tree: $scope.tree},
			controller: 'uploadProfCtrl'
		});
  	};

  	$scope.uploadGal = function () {
		ngDialog.open({
        	template: 'uploadGal',
			className: 'ngdialog-theme-default ngdialog-theme-custom-profile',
			data: {id: $scope.id, tree: $scope.tree},
			controller: 'uploadGalCtrl'
		});
  	};

  	memberService.memberGetGal($scope.params.profID).then(function(data) {
  		$scope.thumbnails = data;
	});
  
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




