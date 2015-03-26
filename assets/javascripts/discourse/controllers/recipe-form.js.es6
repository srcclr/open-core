import RecipeLanguagesTechnologies from 'discourse/plugins/Discourse reports/discourse/mixins/recipe-languages-technologies'

function cantSubmitPost(raw) {
  return !raw || raw.length < 1;
}

export default Ember.Controller.extend(RecipeLanguagesTechnologies, {
  loading: false,

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
      var attrs = { archetype: 'recipe', tags: this.get('tags') };

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
