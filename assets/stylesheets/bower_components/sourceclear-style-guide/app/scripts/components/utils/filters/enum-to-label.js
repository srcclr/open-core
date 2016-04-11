angular.module('SC.components.utils.filters')
.filter('enumToLabel', function() {
  'use strict';

  return function(text, length, end) {
    var enums = {
      'GITHUB': 'GitHub',
      'GEM': 'Ruby Gems',
      'MAVEN': 'Maven'
    };

    return enums[text];
  };
});