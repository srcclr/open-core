import CommunityRequest from 'discourse/views/static'

export default CommunityRequest.extend({
  templateName: 'submit-recipe',

  didInsertElement: function() {
    var self = this;

    Discourse.ajax('/recipe_subcategories').then(function(result) {
      self.get('controller').set('categories', result);
    });
  }
});
