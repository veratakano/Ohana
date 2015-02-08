<!DOCTYPE html>
<html lang="en" ng-app="ohanaApp">

  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1">

    <title>Ohana</title>
    
    <!-- Bootstrap and CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" rel="stylesheet">
    <link href="css/bootstrap_custom.css" rel="stylesheet">
    <link href="css/ngDialog.min.css" rel="stylesheet">
    <link href="css/ngDialog.min.css" rel="stylesheet">
    <link href="css/ngDialog-theme-default.min.css" rel="stylesheet">
    <link href="css/ngDialog-theme-custom.css" rel="stylesheet">
    <link href="css/ohana_custom.css" rel="stylesheet">
    <link href="css/tree_custom.css" rel="stylesheet">

  </head>

  <body>
    
	
	
	<!--Tree, Test_final_3  -->
    <nav role="navigation" ng-include="'partials/Tree.php'" ng-controller="navController"></nav>
    <div class="views" ng-view></div>
  </body>
  
  <!-- Libs -->
  <script type="text/javascript" src="scripts/angular.min.js"></script>
  <script type="text/javascript" src="scripts/angular-route.min.js"></script>

  <script type="text/javascript" src="scripts/jquery-1.11.1.min.js"></script>
  <script type="text/javascript" src="scripts/jquery.jsPlumb-1.7.2-min.js"></script>

  <script type="text/javascript" src="scripts/bootstrap.min.js"></script>

  <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyA5AZXdDIGFkixMBrTjQsctwDJ8wHW7Pdo"></script>
  <script type="text/javascript" src="scripts/markerclusterer_compiled.js"></script>

  <script type="text/javascript" src="scripts/ngDialog.min.js"></script>

  <script type="text/javascript" src="js/app.js"></script>

  <script type="text/javascript" src="js/controllers/navCtrl.js"></script>
  <script type="text/javascript" src="js/controllers/authCtrl.js"></script>
  <script type="text/javascript" src="js/controllers/logoutCtrl.js"></script>
  <script type="text/javascript" src="js/controllers/dashboardCtrl.js"></script>
  <script type="text/javascript" src="js/controllers/profileCtrl.js"></script>

  <script type="text/javascript" src="js/directives/nodesRepeatDrc.js"></script>
  <script type="text/javascript" src="js/directives/mapDrc.js"></script>

  <script type="text/javascript" src="js/services/loginService.js"></script> 
  <script type="text/javascript" src="js/services/sessionService.js"></script>
  <script type="text/javascript" src="js/services/treeService.js"></script>
  <script type="text/javascript" src="js/services/fbService.js"></script>
</html>