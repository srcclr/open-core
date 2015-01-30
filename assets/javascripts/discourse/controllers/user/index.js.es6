import PreferencesController from 'discourse/controllers/preferences';

function findField(name) {
  return function(field) { return field.field.name == name }
}

export default PreferencesController.extend({
  companyField: Em.computed('userFields', function() {
    return _.find(this.get('userFields'), findField('Company'));
  }),

  jobTitleField: Em.computed('userFields', function() {
    return _.find(this.get('userFields'), findField('Job title'));
  }),

  customSignatureField: Em.computed('userFields', function() {
    return  _.find(this.get('userFields'), findField('Custom signature'));
  }),

  // user_fields is a plain js object and it's updating
  // through user_fields[key] = value. In order to observe
  // those changes, we have added an extra property 'viewRenderedAt'
  // that is updating on each transition into user overview page
  //
  userFields: Em.computed('viewRenderedAt', function() {
    return this._super();
  })
});
