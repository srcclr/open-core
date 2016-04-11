// 
// Modified via
// https://github.com/paulyoder/angular-bootstrap-show-errors
// 
// MIT License
// 
(function () {
  'use strict';

  var showErrorsModule;
  showErrorsModule = angular.module('ui.bootstrap.showErrors', []);
  showErrorsModule.directive('showErrors', [
    '$timeout',
    'showErrorsConfig',
    function ($timeout, showErrorsConfig) {
      var getShowSuccess, linkFn;
      getShowSuccess = function (options) {
        var showSuccess;
        showSuccess = showErrorsConfig.showSuccess;
        if (options && options.showSuccess !== null) {
          showSuccess = options.showSuccess;
        }
        return showSuccess;
      };
      linkFn = function (scope, el, attrs, formCtrl) {
        var blurred, inputEl, inputName, inputNgEl, options, showSuccess, toggleClasses;
        blurred = false;
        options = scope.$eval(attrs.showErrors);
        showSuccess = getShowSuccess(options);
        inputEl = el[0].querySelector('[name]');
        inputNgEl = angular.element(inputEl);
        inputName = inputNgEl.attr('name');
        if (!inputName) {
          throw 'show-errors element has no child input elements with a \'name\' attribute';
        }
        inputNgEl.bind('blur', function () {
          blurred = true;
          return toggleClasses(formCtrl[inputName].$invalid);
        });
        scope.$watch(function () {
          return formCtrl[inputName] && formCtrl[inputName].$invalid;
        }, function (invalid) {
          return toggleClasses(invalid);
        });
        scope.$on('show-errors-check-validity', function () {
          return toggleClasses(formCtrl[inputName].$invalid);
        });
        scope.$on('show-errors-reset', function () {
          return $timeout(function () {
            el.removeClass('has-error');
            el.removeClass('has-success');
            blurred = false;
            return blurred;
          }, 0, false);
        });
        toggleClasses = function (invalid) {

          if (!blurred) {
            return;
          }
          if(!inputNgEl.hasClass('ng-dirty')) {
            return;
          }

          el.toggleClass('has-error', invalid);
          
          if (showSuccess) {
            return el.toggleClass('has-success', !invalid);
          }
        };
        return toggleClasses;
      };
      return {
        restrict: 'A',
        require: '^form',
        compile: function (elem, attrs) {
          if (!elem.hasClass('form-group')) {
            throw 'show-errors element does not have the \'form-group\' class';
          }
          return linkFn;
        }
      };
    }
  ]);
  showErrorsModule.provider('showErrorsConfig', function () {
    var _showSuccess;
    _showSuccess = false;
    this.showSuccess = function (showSuccess) {
      _showSuccess = showSuccess;
      return _showSuccess;
    };
    this.$get = function () {
      return { showSuccess: _showSuccess };
    };
  });
}.call(this));