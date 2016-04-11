
/**
 * @ngdoc overview
 * @name SourceClear
 * @description
 * # SourceClear
 *
 * Main module of the application.
 */
angular.module('SC.config', [])
  .config(function ($locationProvider, cfpLoadingBarProvider) {
    'use strict';

    $locationProvider.html5Mode(true);

    cfpLoadingBarProvider.includeSpinner = false;

  }).run(function ($rootScope) {
    'use strict';

    $rootScope.isAppLoading = true;

  });