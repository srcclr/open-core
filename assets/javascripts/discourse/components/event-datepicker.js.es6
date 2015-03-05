import TextField from 'discourse/components/text-field'

export default TextField.extend({
  classNames: ['date-filter'],

  applyDatepicker: function() {
    var $element = $(this.get('element'));
    var self = this;
    var value = Date.parse(this.get('value'));

    $element.datepicker().on('changeDate', function(event) {
      self.set('value', event.target.value);
    });

    if (value) {
      $element.data('datepicker').setValue(value);
    }
  }.on('didInsertElement'),

  removeDatepicker: function() {
    $(this.get('element')).datepicker('hide');
  }.on('willDestroyElement')
});
