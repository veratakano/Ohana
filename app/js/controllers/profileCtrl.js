
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
			controller: 'uploadCtrl'
		});
  };
     
}]);

// Open Popup Controller
app.controller('uploadCtrl', ['$scope','$rootScope','$timeout','$upload', function($scope,$rootScope,$timeout,$upload){

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




