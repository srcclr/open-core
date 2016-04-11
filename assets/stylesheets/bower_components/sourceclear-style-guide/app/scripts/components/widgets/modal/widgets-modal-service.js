angular.module('SC.components.widgets.modal')
    .service('WidgetsModal', function($modal, $log) {
      'use strict';

      var self = this;

      this.open = function (modalInstanceObject) {
        if (typeof self._instance === 'undefined') {
          $log.info('opening modal');

          self._instance = $modal.open(modalInstanceObject);
          self._instance.result.then(self.closeOkHandler, self.closeCancelHandler);
        }
      };

      this.closeOkHandler = function () {
        self._instance.dismiss(); // auto-dismiss on submission for now
        self._instance = undefined;
      };

      this.closeCancelHandler = function () {
        self._instance = undefined;
      };

      this.verifyModalInstance = function () {
        if (typeof self._instance !== 'undefined') {
          return true;
        }

        return false;
      };

    });
