angular.module('SC.components.utils.directives')
  .directive('fixOnScroll', function() {
    'use strict';

    return {
      restrict: 'A',
      link: function(scope, element, attrs) {
        $(window).on("scroll", function() {
          var setFixedAttrs = attrs.fixOnScroll.split(':');

          var elementToFix = $(setFixedAttrs[0])
            , elementToPush = $(setFixedAttrs[1])
            , columnsToPush = setFixedAttrs[2];

          if( $(window).scrollTop() > 170) {
            elementToFix.css({
              position: 'fixed',
              top: '10px',
              height: '100%',
              overflow: 'auto',
            })
            elementToPush.addClass('push--' + columnsToPush);
          } else {
            elementToFix.css({
              position: '',
              top: '',
            })
            elementToPush.removeClass('push--' + columnsToPush);
          }
        })
      }
    }

  });