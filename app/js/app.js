'use strict';

var app = angular.module('ohanaApp', ['ngRoute','ngDialog']);

app.config(['$routeProvider', 'ngDialogProvider', 
  function ($routeProvider, ngDialogProvider) {
  	$routeProvider.
        when('/login', {
            title: 'Login',
            templateUrl: 'partials/login.html',
            controller: 'authCtrl'
        }).
        when('/logout', {
             title: 'Logout',
             templateUrl: 'partials/login.html',
             controller: 'logoutCtrl'
        }).
        when('/signup', {
             title: 'Signup',
             templateUrl: 'partials/signup.html',
             controller: 'authCtrl'
		}).
		when('/dashboard', {
             title: 'Dashboard',
             templateUrl: 'partials/dashboard.html',
             controller: 'dashboardCtrl'
        }).
         when('/profile/:profID', {
             title: 'Profile',
             templateUrl: 'partials/profile.html',
             controller: 'profileCtrl'
        }).
        when('/', {
             title: 'Login',
             templateUrl: 'partials/login.html',
             controller: 'authCtrl'
         }).
        otherwise({
             redirectTo: '/login'
         });
    ngDialogProvider.setDefaults({
        className: 'ngdialog-theme-default',
        plain: false,
        showClose: true,
        closeByDocument: true,
        closeByEscape: true,
        appendTo: false
    });
 }]);


app.run(function($rootScope, $location, sessionService, treeService){

    //global variable
    $rootScope.apiVersion = 'api/v1/';

    $rootScope.flowchart = treeService.getTreeData();

    $rootScope.$on('$routeChangeStart', function(){

        jsPlumb.ready(function(){
            //detah all connectors
            jsPlumb.detachEveryConnection();
        });

        $rootScope.auth = sessionService.get('unqid'); // check if auth, show hide nav bar
        if($location.path() != '/signup'){
            if(!sessionService.get('unqid')){
                $location.path('/login');
            }
        }
    });
});



