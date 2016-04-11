angular.module('SC.components.utils.directives')
  .directive('selectOnClick', function () {
    'use strict';

    /*
     * Select On Click Directive
     * in HTML: <input type="text" select-on-click/>
     * on click event the directive will select all the chars in the element
     * making copy and paste a better experience for the user
     * code source: http://stackoverflow.com/questions/14995884/select-text-on-input-focus
     */

    return {
      restrict: 'A',
      link: function (scope, element, attrs) {
        element.on('click', function () {
          var selection = window.getSelection();
          var range = document.createRange();
          range.selectNodeContents(element[0]);
          selection.removeAllRanges();
          selection.addRange(range);
        });
      }

    };
  });