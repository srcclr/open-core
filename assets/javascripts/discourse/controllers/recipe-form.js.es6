var TAGS_FILTER_REGEXP = /[<\\\/\>\.\#\?\&\s]/;

function cantSubmitPost(raw) {
  return !raw || raw.length < 1;
}

function prepareTag(tag) {
  var key = tag.toLowerCase().replace(TAGS_FILTER_REGEXP, '');

  return { id: key, value: tag };
}

export default Ember.Controller.extend({
  loading: false,

  languages: Em.computed(function() {
    return _.map(Discourse.SiteSettings.languages.split('|'), prepareTag);
  }),

  technologies: Em.computed(function() {
    return _.map(Discourse.SiteSettings.technologies.split('|'), prepareTag);
  }),

  replyValidation: function() {
    const raw = this.get('model.raw');

    if (cantSubmitPost(raw)){
      return Discourse.InputValidation.create({
        reason: I18n.t('composer.error.post_missing'),
        failed: true
      });
    }

  }.property('model.raw'),

  actions: {
    submitRecipe: function() {
      var attrs = { archetype: 'recipe' };

      if (!this.get('model.category')) {
        var first_category = _.first(this.get('categories'));
        attrs.category = first_category && first_category.parent_category_id;
      }

      this.get('model').setProperties(attrs);

      if (cantSubmitPost(this.get('model.raw'))) {
        this.set('showReplyTip', new Date);
        return;
      }

      this.get('model').save().then(function(opts) {
        return Discourse.URL.routeTo(opts.get('url'));
      }, function(error) {
        bootbox.alert(error.responseJSON.errors.join('.<br/>'));
      });
    }
  }
});
