'use strict';

/**
 * @ngdoc overview
 * @name SourceClear
 * @description
 * # SourceClear
 *
 * Main module of the application.
 */
angular.module('SourceClear', [

  'ngAnimate',
  'ngCookies',
  'ngRoute',
  'ngSanitize',
  'ngTouch',
  'ngToast',

  'ui.router',
  'ui.bootstrap',
  'ui.utils',
  'ui.select',
  //'http-auth-interceptor',
  'ui.bootstrap.showErrors',

  'angular-loading-bar',

  'SC.config',
  'SC.routes',
  'SC.components'
]);
