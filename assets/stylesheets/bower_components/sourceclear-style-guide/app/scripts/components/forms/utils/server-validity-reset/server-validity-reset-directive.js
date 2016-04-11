
angular.module('SC.components.forms.utils.server-validity-reset-directive')
.directive('serverValidityReset', function() {
  'use strict';

  return {
    restrict: 'A',
    require: '?ngModel',
    link: function(scope, element, attrs, ctrl) {
      element.on('input propertychange', function() {
      	scope.$apply(function() {
      		ctrl.$setValidity('server', true);
      	});
      });
    }
  };

});