angular.module('SC.components.widgets.off-canvas')
  .directive('offCanvasContainer', function() {
    'use strict';

    return {
      restrict: 'A',
      link: function(scope, element, attrs, ngModelCtrl) {
        
      }
    };

  })
  .directive('offCanvasMain', function() {
    'use strict';

    return {
      restrict: 'A',
      link: function(scope, element, attrs, ngModelCtrl) {
        
      }
    };

  })
  .directive('offCanvasSidebar', function() {
    'use strict';

    return {
      restrict: 'A',
      link: function(scope, element, attrs, ngModelCtrl) {
        
      }
    };

  })
  .service('$offCanvas', function() {
    'use strict';

    var defaults = {
      position: 'left',
      
    };

  });