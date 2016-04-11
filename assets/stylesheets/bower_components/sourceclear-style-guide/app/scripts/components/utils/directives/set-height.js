angular.module('SC.components.utils.directives')
  .directive('setHeight', function() {
    'use strict';

    return {
      restrict: 'A',
      link: function(scope, element, attr) {
        // first element in array is desired height
        // if second element is present (and truthy), scrollbar will be implemented
        var setHeightAttrs = attr.setHeight.split(':');
        element.css({
          'height': setHeightAttrs[0],
          'overflow-y': setHeightAttrs[1] ? 'scroll' : 'visible'
        });

      }
    };
  });