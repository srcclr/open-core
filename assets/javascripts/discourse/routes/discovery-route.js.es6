import DiscoveryRoute from 'discourse/routes/discovery-route';

function targetName(transition) {
  return transition.targetName.split('.')[1]
}

export default DiscoveryRoute.reopen({
  state: null,

  beforeModel: function(transition) {
    this._super.apply(this, arguments);
    this.state = targetName(transition);
  },

  renderTemplate: function() {
    if (this.state !== 'homepage') { this._super(); }
  },

  actions: {
    willTransition: function(transition) {
      this._super.apply(this, arguments);
      var state = targetName(transition);

      if (this.state != state && _.contains([state, this.state], 'homepage')) {
        this.refresh();
      }
    }
  }
});
