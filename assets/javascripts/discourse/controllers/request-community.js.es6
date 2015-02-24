export default Discourse.RequestCommunityController = Discourse.Controller.extend({
  sendRequestEmailDisabled: Em.computed.empty('email'),
  sentRequestEmail: false,
  country: 'United States',
  countries: Em.computed(function() {
    return Discourse.SiteSettings.countries.split('|');
  }),

  email: Em.computed(function() {
    return this.get('model').get('email');
  }),

  requestorCity: function() {
    return I18n.t('request_community.city');
  }.property(),

  requestorMeetupId: function() {
    return I18n.t('request_community.requestor_id');
  }.property(),

  requestorEmail: function() {
    return I18n.t('request_community.requestor_email');
  }.property(),

  requestText: function() {
    return I18n.t('request_community.request_text');
  }.property(),

  actions: {
    createRequest: function() {
      var attrs = this.getProperties('country', 'city', 'meetup_id', 'email', 'request_text'),
          self = this;

      return Discourse.ajax('communities/request_email', {
        type: 'POST',
        data: { fields: attrs }
      }).then(function () {
        self.set('sentRequestEmail', true);
      });
    }
  }
});
