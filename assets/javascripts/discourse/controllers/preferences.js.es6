import PreferencesController from 'discourse/controllers/preferences';

function statckexchange() {
  return _(Em.get('Discourse.LoginMethod.all')).find(function(provider){
    return provider.name == 'stackexchange';
  });
}

export default PreferencesController.reopen({
  hasStackExchange: Em.computed.alias('model.hasStackExchange'),

  stackexchangeEnabled: Em.computed(function() {
    return Discourse.SiteSettings.enable_stackexchange_logins;
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
