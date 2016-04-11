angular.module('SC.components.utils.filters')
.filter('yesNo', function() {
  'use strict';

  return function(text, length, end) {
    if (text) {
      return 'Yes';
    }
    return 'No';
  };
});