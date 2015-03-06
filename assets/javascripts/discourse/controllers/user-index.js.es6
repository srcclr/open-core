import PreferencesController from 'discourse/controllers/preferences';

function findField(name) {
  return function(field) { return field.field.name == name }
}

function statckexchange() {
  return _(Em.get('Discourse.LoginMethod.all')).find(function(provider){
    return provider.name == 'stackexchange';
  });
}

export default PreferencesController.extend({
  hasStackExchange: false,

  companyField: Em.computed('userFields', function() {
    return _.find(this.get('userFields'), findField('Company'));
  }),

  jobTitleField: Em.computed('userFields', function() {
    return _.find(this.get('userFields'), findField('Job title'));
  }),

  customSignatureField: Em.computed('userFields', function() {
    return  _.find(this.get('userFields'), findField('Custom signature'));
  }),

  stackexchangeEnabled: Em.computed(function() {
    return Discourse.SiteSettings.enable_stackexchange_logins;
  }),

  // user_fields is a plain js object and it's updating
  // through user_fields[key] = value. In order to observe
  // those changes, we have added an extra property 'viewRenderedAt'
  // that is updating on each transition into user overview page
  //
  userFields: Em.computed('viewRenderedAt', function() {
    return this._super();
  }),

  actions: {
    externalLogin: function() {
      var provider = statckexchange();
      var name = provider.get("name");
      var left = this.get('lastX') - 400;
      var top = this.get('lastY') - 200;

      var height = provider.get("frameHeight") || 400;
      var width = provider.get("frameWidth") || 800;

      window.open(
        Discourse.getURL("/auth/" + name), "_blank",
        "menubar=no,status=no,height=" + height + ",width=" + width +  ",left=" + left + ",top=" + top
      );
    }
  }
});
