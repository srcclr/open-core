import DiscoveryRoute from 'discourse/routes/discovery-route';

export default DiscoveryRoute.reopen({
  state: null,

  beforeModel: function(transition) {
    this._super.apply(this, arguments);
    this.state = (Ember.keys(transition.params)[2] || '').split('.')[1]
  },

  renderTemplate: function() {
    if (this.state !== 'homepage') { this._super(); }
  },

  actions: {
    willTransition: function() {
      this._super.apply(this, arguments);
      this.refresh();
    }
  }
});
