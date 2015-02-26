'use strict';

app.directive('map', ['$compile','$location','memberService','$filter', 
	function($compile,$location,memberService,$filter) {
    return {
        restrict: 'E',
        replace: true,
        template: '<div></div>',
        link: function($scope, element, attrs) {

        	memberService.getMemberSetbyTreeID().then(function(data) {

	        	//Data
				var node = data;

				var geocoder, map;
				// info window
	            var infoWindow = new google.maps.InfoWindow();
	            //marker cluster
	            var mcOptions = {gridSize: 50, maxZoom: 10};
	    		var mc;
				//shopmap
				var initPlaceOfBirth;
				var mapShow = false;

				var map_options = {
					 zoom: 4
					                
				};
				// create map
				map = new google.maps.Map(document.getElementById(attrs.id), map_options);
				mc = new MarkerClusterer(map, [], mcOptions);
				
				for (var i = 0; i < node.length; ++i) {
					var initPlaceOfBirth = node[i].placeOfBirth;
					if(initPlaceOfBirth != null){
   						mapShow = true;
   						break;
 					}
				}

				if(mapShow){

					// Try HTML5 geolocation
  					if(navigator.geolocation) {
    					navigator.geolocation.getCurrentPosition(function(position) {
      						var pos = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);
							var infowindow = new google.maps.InfoWindow({
        						map: map,
        						position: pos,
        						content: 'Location found using HTML5.'
      						});
      						map.setCenter(pos);
      						for (var i = 0; i < node.length; i++){
			    				if(node[i].placeOfBirth != ''){
			    					geocodeAddress(node[i]);
			    				}
			    			}
    					}, function() {
      						setMapCenter(initPlaceOfBirth);
    					});
  					} else {
  						// Browser doesn't support Geolocation
    					setMapCenter(initPlaceOfBirth);
 					 }

					
				} else {
					var el = angular.element('<div/>');
					 el.append('<div class="container" style="margin-top: 70px;">' +
					 				'<div class="jumbotron text-center" style="background-color: transparent;">' +
					 					'<h1 style="color:#3c9bf2"><span class="fa-stack fa-lg"><i class="fa fa-map-marker fa-stack-1x"></i><i class="fa fa-ban fa-stack-2x"></i></span></h1>' +
					 					'<br />' +
					 					'<p>Please add a few family members and tag them with a location.</p>' +
					 				'</div>' +
					 			'</div>');
					$compile(el)($scope);
        			element.append(el);
				}

				function setMapCenter(address,callback) {
				    geocoder = new google.maps.Geocoder();
				    geocoder.geocode({
				        'address': address
				    }, function(results, status) {
				        if (status == google.maps.GeocoderStatus.OK) {
				        	map.setCenter(results[0].geometry.location);
					        for (var i = 0; i < node.length; i++){
					        	alert(node[i].placeOfBirth);
			    				if(node[i].placeOfBirth != ''){
			    					geocodeAddress(node[i]);
			    				}
			    			}
					     }
				    });
				};


	    		var geocodeAddress = function (node){
	    			geocoder = new google.maps.Geocoder();
	    			geocoder.geocode( {'address': node.placeOfBirth}, function(results, status) {
						if (status == google.maps.GeocoderStatus.OK) {

	            			var marker = createMarker(results[0].geometry.location,node);
	            			mc.addMarker(marker);

	        			} else { 
	            			alert("Geocode was not successful for the following reason: " + status); 
	        			} 
	    			});
				};

	    		var createMarker = function (latlng,node) {

	        		///get array of markers currently in cluster
	        		var allMarkers = mc.getMarkers();

	        		//final position for marker, could be updated if another marker already exists in same position
	        		var finalLatLng = latlng;

	        		//check to see if any of the existing markers match the latlng of the new marker
			        if (allMarkers.length != 0) {
			            for (var i=0; i < allMarkers.length; i++) {
			                var existingMarker = allMarkers[i];
			                var pos = existingMarker.getPosition();

			                //if a marker already exists in the same position as this marker
			                if (latlng.equals(pos)) {

			                    var newLat = latlng.lat() + (Math.random() -.10) / 1500;// * (Math.random() * (max - min) + min);
	            				var newLng = latlng.lng() + (Math.random() -.10) / 1500;// * (Math.random() * (max - min) + min);

			                    finalLatLng = new google.maps.LatLng(newLat,newLng);

			                }                   
			            }
			        }

			        var marker = new google.maps.Marker({
			            position: finalLatLng
			        });

			        var host = $location.host();
			        var protocol = $location.protocol();

			         marker.content = '<div class="infowindow">'+
									      '<div class="misc pull-left">'+
									      	'<img class="img-thumbnail" src="http://' + host +'/app/api/v1/getProfImg.php?id=' + node.memberID +'"/>' +
									      	'<div>' +
									      		'<a class="btn btn-outline-inverse" href="#/profile/' + node.memberID + '" type="button"><i class="fa fa-user"></i>&nbsp;&nbsp;View Profile</a>' +
									      	'</div>' +
									      	'<div class="gap"></div>' +
									      '</div>'+
									      '<div class="content pull-right">' +
									      	'<h3 id="firstHeading" class="firstHeading">' + node.firstName +' ' + node.lastName + '</h3>'+
									      	'<div class="bodyContent">'+
												'<p><strong>Born On</strong>: ' + $filter('checkUnknown')(node.dateOfBirth) + '</p>' +
										  		'<p><strong>Born In</strong>: ' + $filter('checkUnknown')(node.placeOfBirth) + '</p>' +
										  		'<p><strong>Gender</strong>: ' + $filter('gender')(node.gender) + '</p>' +
									      	'</div>'+
									      '</div>'+
								      '</div>';
   

			        google.maps.event.addListener(marker, 'click', function(){
	            		infoWindow.setContent(marker.content);
	            		infoWindow.open(map, marker);
	        		});

			        return marker;
			    };
       		});
        }
    }
}]);