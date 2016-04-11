angular.module('SC.components.utils.filters')
  .filter('cut', function () {
    'use strict';

    // a filter used to truncate text
    // params are:
    // value: string to be truncated
    // wordwise: true/false - trim at end of word or in the middle
    // max: num of chars at which to trim
    // tail: string for appending to trimmed value string (ie: '...')
    return function (value, wordwise, max, tail) {
      var lastSpace;

      if (!value) {
        return '';
      }

      max = parseInt(max, 10);

      // no trimming neccessary if max is not defined or the length of the string is less than the defined max
      if (!max || value.length <= max) {
        return value;
      }

      value = value.substr(0, max);
      lastSpace = value.lastIndexOf(' ');

      // trim at beginning of word that falls at @max chars
      if (wordwise && lastSpace !== -1) {
        value = value.substr(0, lastSpace);
      }

      return value + (tail || ' …');
    };
  });