angular.module('SC.components.utils.directives')
  .directive('dropdownPosition', function() {
    'use strict';
    // will handle the positioning of any dropdown regardless of width or parent width

    return {
      restrict: 'A',
      link: function(scope, element, attr) {
        // when attr is left, dropdown is positioned appropriately
        // when attr is right, align the dropdown with the edge of the parent element
        // when attr is center, align the center of the dropdown with the center of the parent element
        var elementWidth = element[0].offsetWidth,
            parentWidth = element.parent()[0].offsetWidth,
            dropdown = {
              right: -elementWidth + parentWidth,
              center: -elementWidth/2 + parentWidth/2,
              left: 0
            };

        element.css({
          left: dropdown[attr.dropdownPosition]
        });

      }
    };
  });