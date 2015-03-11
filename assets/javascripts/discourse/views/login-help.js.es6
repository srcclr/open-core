export default Discourse.ModalBodyView.extend({
  templateName: 'modal/login_help',
  title: I18n.t('login_help.title'),

  didInsertElement: function() {
    var self = this;

    Discourse.ajax('/static_contents/login_help').then(function(result) {
      self.get('controller').set('loginHelpText', result);
    });
  }
});
