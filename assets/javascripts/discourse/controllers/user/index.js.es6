import PreferencesController from 'discourse/controllers/preferences';

function findField(name) {
  return function(field) { return field.field.name == name }
}

export default PreferencesController.extend({
  companyField: Em.computed(function() {
    return _.find(this.get('userFields'), findField('Company'));
  }),

  jobTitleField: Em.computed(function() {
    return _.find(this.get('userFields'), findField('Job title'));
  }),

  customSignatureField: Em.computed(function() {
    return  _.find(this.get('userFields'), findField('Custom signature'));
  }),

});
