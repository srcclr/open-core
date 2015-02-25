import TextField from 'discourse/components/text-field'

export default TextField.extend({
  classNames: ['date-filter'],

  applyDatepicker: function() {
    $(this.get('element')).datepicker();
  }.on('didInsertElement')
});
