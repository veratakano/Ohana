<!DOCTYPE html>
<html lang="en" ng-app="ohanaApp">

  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1">

    <title>Ohana</title>
    
    <!-- Bootstrap and CSS -->
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/font-awesome.min.css">
    <link rel="stylesheet" href="css/bootstrap_custom.css">
    <link rel="stylesheet" href="css/ngDialog.min.css">
    <link rel="stylesheet" href="css/ngDialog-theme-default.min.css">
    <link rel="stylesheet" href="css/ngDialog-theme-custom.css" >
    <link rel="stylesheet" href="css/bootstrap-additions.min.css">
    <link rel="stylesheet" href="css/ohana_custom.css">
    <link rel="stylesheet" href="css/tree_custom.css">

  </head>

  <body>
	
    <nav class="navbar navbar-default navbar-fixed-top" role="navigation" ng-include="'partials/navbar.html'" ng-controller="navController"></nav>
    <div class="views" ng-view></div>

  </body>
  
  <!-- Libs -->
  <script type="text/javascript" src="scripts/angular.min.js"></script>
  <script type="text/javascript" src="scripts/angular-route.min.js"></script>
  
  <script src="http://crypto-js.googlecode.com/svn/tags/3.1.2/build/rollups/aes.js"></script>

   <script src="https://www.google.com/jsapi" type="text/javascript"></script>

  <script type="text/javascript" src="scripts/jquery-1.11.1.min.js"></script>

  <script type="text/javascript" src="scripts/bootstrap.min.js"></script>

  <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyA5AZXdDIGFkixMBrTjQsctwDJ8wHW7Pdo&libraries=places"></script>
  <script type="text/javascript" src="scripts/markerclusterer_compiled.js"></script>

  <script type="text/javascript" src="scripts/ngDialog.min.js"></script>
  <script type="text/javascript" src="scripts/angular-file-upload.min.js"></script>
  <script type="text/javascript" src="scripts/ngAutocomplete.js"></script>
  <script type="text/javascript" src="scripts/angular-strap.min.js"></script>
  <script type="text/javascript" src="scripts/angular-strap.tpl.min.js"></script>
  <script type="text/javascript" src="scripts/bootbox.min.js"></script>
  <!--<script type="text/javascript" src="scripts/find5.js"></script>-->
  
  <script type="text/javascript" src="js/app.js"></script>

  <script type="text/javascript" src="js/controllers/navCtrl.js"></script>
  <script type="text/javascript" src="js/controllers/authCtrl.js"></script>
  <script type="text/javascript" src="js/controllers/logoutCtrl.js"></script>
  <script type="text/javascript" src="js/controllers/dashboardCtrl.js"></script>
  <script type="text/javascript" src="js/controllers/profileCtrl.js"></script>
  <script type="text/javascript" src="js/controllers/insertionCtrl.js"></script>
  <script type="text/javascript" src="js/controllers/inviteCtrl.js"></script>
  <script type="text/javascript" src="js/controllers/searchCtrl.js"></script>
  <script type="text/javascript" src="js/controllers/settingCtrl.js"></script>
  
  <script type="text/javascript" src="js/directives/treeDrc.js"></script>
  <script type="text/javascript" src="js/directives/mapDrc.js"></script>
  <script type="text/javascript" src="js/directives/validationDrc.js"></script>

  <script type="text/javascript" src="js/filters/filters.js"></script>

  <script type="text/javascript" src="js/services/loginService.js"></script> 
  <script type="text/javascript" src="js/services/sessionService.js"></script>
  <script type="text/javascript" src="js/services/treeService.js"></script>
  <script type="text/javascript" src="js/services/fbService.js"></script>
  <script type="text/javascript" src="js/services/memberService.js"></script>
  <script type="text/javascript" src="js/services/inviteService.js"></script>
  <script type="text/javascript" src="js/services/searchService.js"></script>
 
</html>