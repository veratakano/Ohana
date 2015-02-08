'use strict';

app.directive('map', function() {
    return {
        restrict: 'E',
        replace: true,
        template: '<div></div>',
        link: function($scope, element, attrs) {

        	//Data
			var node = [
			    {
			        city : 'Toronto',
			        desc : 'This is the best city in the world!',
			        lat : 43.7000,
			        long : -79.4000
			    },
			    {
			        city : 'Toronto',
			        desc : 'This city is aiiiiite!',
			        lat : 40.6700,
			        long : -73.9400
			    },
			    {
			        city : 'Chicago',
			        desc : 'This is the second best city in the world!',
			        lat : 41.8819,
			        long : -87.6278
			    },
			    {
			        city : 'Los Angeles',
			        desc : 'This city is live!',
			        lat : 34.0500,
			        long : -118.2500
			    },
			    {
			        city : 'Las Vegas',
			        desc : 'Sin City...\'nuff said!',
			        lat : 36.0800,
			        long : -115.1522
			    }
			];

			var geocoder;
			var map;
			var latlng = new google.maps.LatLng(40.0000, -98.0000);
            
            var map_options = {
                zoom: 4,
                center: latlng
            };

            geocoder = new google.maps.Geocoder();
          
            // create map
            map = new google.maps.Map(document.getElementById(attrs.id), map_options);
            
            // info window
            var infoWindow = new google.maps.InfoWindow();

            //marker cluster
            var mcOptions = {gridSize: 50, maxZoom: 10};
    		var mc = new MarkerClusterer(map, [], mcOptions);

    		var geocodeAddress = function (node){

    			geocoder.geocode( {'address': node.city}, function(results, status) {
					if (status == google.maps.GeocoderStatus.OK) {

            			var marker = createMarker(results[0].geometry.location,node);
            			mc.addMarker(marker);

        			} else { 
            			alert("Geocode was not successful for the following reason: " + status); 
        			} 
    			});
			};

			//var min = .999999;
			//var max = 1.000001;

    		var createMarker = function (latlng,node) {

        		///get array of markers currently in cluster
        		var allMarkers = mc.getMarkers();

        		//final position for marker, could be updated if another marker already exists in same position
        		var finalLatLng = latlng;

        		//check to see if any of the existing markers match the latlng of the new marker
		        if (allMarkers.length != 0) {
		            for (i=0; i < allMarkers.length; i++) {
		                var existingMarker = allMarkers[i];
		                var pos = existingMarker.getPosition();

		                //if a marker already exists in the same position as this marker
		                if (latlng.equals(pos)) {

		                    //update the position of the coincident marker by applying a small multipler to its coordinates
		                    //var newLat = latlng.lat() * (Math.random() * (max - min) + min);
		                    //var newLng = latlng.lng() * (Math.random() * (max - min) + min);
		                    var newLat = latlng.lat() + (Math.random() -.10) / 1500;// * (Math.random() * (max - min) + min);
            				var newLng = latlng.lng() + (Math.random() -.10) / 1500;// * (Math.random() * (max - min) + min);

		                    finalLatLng = new google.maps.LatLng(newLat,newLng);

		                }                   
		            }
		        }

		        var marker = new google.maps.Marker({
		            position: finalLatLng,
		            title: node.city
		        });

		        marker.content = '<div class="infoWindowContent">' + node.desc + '</div>';     

		        google.maps.event.addListener(marker, 'click', function(){
            		infoWindow.setContent('<h2>' + marker.title + '</h2>' + marker.content);
            		infoWindow.open(map, marker);
        		});

		        return marker;
		    };

		    // loop marker
    		for (var i = 0; i < node.length; i++){
        		geocodeAddress(node[i]);
    		}
    		
       
        }
    }
});