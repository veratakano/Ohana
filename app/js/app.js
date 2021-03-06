'use strict';

var app = angular.module('ohanaApp', ['ngRoute' ,'ngDialog','ngFileUpload','ngAutocomplete','mgcrea.ngStrap']);

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
        when('/forget_password', {
            title: 'Login',
            templateUrl: 'partials/forget_password.html',
            controller: 'authCtrl'
        }).
		when('/dashboard', {
             title: 'Dashboard',
             templateUrl: 'partials/dashboard.html',
             controller: 'dashboardCtrl'
        }).
        when('/map', {
             title: 'Map',
             templateUrl: 'partials/map.html'
        }).
        when('/profile/:profID', {
             title: 'Profile',
             templateUrl: 'partials/profile.html',
             controller: 'profileCtrl',
             resolve : {
                memberDetails : function(memberService,$route) {
                    return memberService.memberGet($route.current.params.profID).then(function(data) {
                            return data;
                    });
                }
             }
        }).
        when('/create_member/:memID', {
             title: 'Create Member',
             templateUrl: 'partials/create_member.html',
             controller: 'insertionCtrl',
             resolve : {
                memberRelation : function(memberService,$route) {
                    return memberService.getMemberRelation($route.current.params.memID).then(function(data) {
                            return data;
                    });
                }
             }
        }).
        when('/invite', {
             title: 'Invite Member',
             templateUrl: 'partials/invite.html',
             controller: 'inviteCtrl'
        }).
		when('/search_profile/:ss', {
             title: 'Search Profile',
             templateUrl: 'partials/search_profile.html',
             controller: 'searchCtrl'
        }).
        when('/profile_not_found', {
             title: 'Profile Not Found',
             templateUrl: 'partials/profile_not_found.html'
        }).
        when('/setting', {
             title: 'Settings',
             templateUrl: 'partials/setting.html',
             controller: 'settingCtrl'
        }).
        when('/', {
             title: 'Login',
             templateUrl: 'partials/login.html',
             controller: 'authCtrl'
         }).
        when('/page_not_found', {
             title: '404 Page not found',
             templateUrl: 'partials/page_not_found.html',
         }).
        otherwise({
             redirectTo: '/page_not_found'
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


app.config(function($datepickerProvider,ngDialogProvider) {
  angular.extend($datepickerProvider.defaults, {
    dateFormat: 'dd/MM/yyyy',
    startView: 2,
    autoclose: true
  });
})


app.run(function($rootScope, $location, $window, fbService, sessionService){

    $window.fbAsyncInit = function() {
        // Executed when the SDK is loaded

        FB.init({ 
            /* The app id of the web app; */
            appId: '1437114279844383', 
            /* Parse XFBML */
            xfbml: true,
            /* Parse XFBML */
            version    : 'v2.2'
        });

        //fbService.watchAuthenticationStatusChange();
    };

    (function(d, s, id){
        var js, fjs = d.getElementsByTagName(s)[0];
        if (d.getElementById(id)) {return;}
            js = d.createElement(s); js.id = id;
            js.src = "//connect.facebook.net/en_US/sdk.js";
            fjs.parentNode.insertBefore(js, fjs);
    }(document, 'script', 'facebook-jssdk'));

        
    $rootScope.fblogout = function(){
            fbService.logout();
    }

   //global variable
   $rootScope.apiVersion = 'api/v1/';

      $rootScope.$on('$routeChangeStart', function(){

          $rootScope.auth = sessionService.get('unqid'); // check if auth, show hide nav bar
          if(!($location.path()=='/signup' || $location.path()=='/invite' || $location.path()=='/profile_not_found' || $location.path()=='/forget_password' || $location.path()=='/page_not_found')){ 
              if(!sessionService.get('unqid')){
                 $location.path('/login');
              }
          }
     });
});

