'use strict';

var app = angular.module('ohanaApp', ['ngRoute']);

app.config(['$routeProvider',
  function ($routeProvider) {
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
        when('/', {
             title: 'Login',
             templateUrl: 'partials/login.html',
             controller: 'authCtrl'
         }).
        otherwise({
             redirectTo: '/login'
         });
 }]);

app.run(function($rootScope, $location, sessionService){

    //global variable
    $rootScope.apiVersion = 'api/v1/';

    $rootScope.$on('$routeChangeStart', function(){

        $rootScope.auth = sessionService.get('unqid'); // check if auth, show hide nav bar

        if(!sessionService.get('unqid')){
            $location.path('/login');
        }else{
            $location.path('/dashboard');
        };
    });
});



