angular.module('SC.components.utils.directives')
.directive('setWidth', function() {
  return {
    restrict: 'A',
    scope: {
      setWidth: '@'
    },
    link: function(scope, element, attr) {

      // Get parent elmenets width and subtract fixed width
      element.css({ 
        width: scope.setWidth
      });

    }
  }
});