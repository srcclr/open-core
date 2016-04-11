angular.module('SC.routes', [
  'SC.routes.root'
])
.config(function($urlRouterProvider, $stateProvider) {
  'use strict';


  /**
   * Remove trailing `/` from our URLs.
   * 
   * Unsure why, but ui-router freaks out when this is below the first $stateProvider declarations...
   * Hence, I'm leaving it up here.
   */
  $urlRouterProvider.rule(function ($injector, $location) {
    var path = $location.url();

    // check to see if the path has a trailing slash
    if ('/' === path[path.length - 1]) {
      return path.replace(/\/$/, '');
    }

    if (path.indexOf('/?') > 0) {
      return path.replace('/?', '?');
    } else {
      // we only really have the home route, so any paths should redirect to the home path
      $location.path('/');
    }

    return;
  });


  $stateProvider
    .state('404', {
      templateUrl: '/404.html',
      controller: function($rootScope) {
        $rootScope.isAppLoading = false;
      },
      data: {
        pageTitle: 'Page not found - SourceClear',
        pageClass: 'four-oh-four'
      }
    });

  $urlRouterProvider.otherwise(function($injector, $location) {
     var state = $injector.get('$state');
     state.go('404');
     return $location.path();
  });


}).run(function($rootScope, $state) {
  'use strict';

  $rootScope.$on('$stateChangeError', function(event, toState, toParams, fromState, fromParams, error){ 
    console.log('$stateChangeError: ', error); 
    $state.go('404');
  });

});