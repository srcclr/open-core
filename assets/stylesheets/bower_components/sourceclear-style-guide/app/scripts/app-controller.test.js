'use strict';

describe('Controller: AppCtrl', function () {

  var AppCtrl = null,
      scope = null;

  // Initialize the controller and a mock scope
  beforeEach(function () {
    module('SourceClear');

    inject(function ($controller, $rootScope) {
      scope = $rootScope.$new();
      AppCtrl = $controller('AppCtrl', {
        $scope: scope
      });
    });
  });



});