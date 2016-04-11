'use strict';

/**
 * @ngdoc function
 * @name SourceClear.controller:AppCtrl
 * @description
 * # AppCtrl
 * Controller of the SourceClear
 */
angular.module('SourceClear')
  .controller('AppCtrl', function ($scope, $state, $rootScope, $timeout, ngToast, $location, $anchorScroll, WidgetsModal) {

    // provide some view help with our state object
  	$rootScope.$state = $state;
    $rootScope.showLoadingPage = false;

    $scope.showLoadPage = function () {
      $rootScope.showLoadingPage = true;
      $timeout(function () {
        $rootScope.showLoadingPage = false;
      }, 2000);
    };

    $scope.showToast = function (alertType) {
      ngToast.create({
        content: 'This is a sample ' + alertType + ' notification!',
        class: alertType,
        dismissButton: true,
        dismissButtonHtml: '<i class="sci sci--fw sci__close sci--sm"></i>'
      });
    };

    $scope.scrollTo = function(id) {
      $location.hash(id);
      $anchorScroll();
    }

    $scope.showModal = function() {
      var modal = {
        templateUrl: '/scripts/routes/root/modal.html'
      };
      WidgetsModal.open(modal);
    };
  });
