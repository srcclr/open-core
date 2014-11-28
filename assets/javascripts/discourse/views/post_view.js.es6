import ArchetypeTemplate from 'discourse/plugins/Discourse reports/discourse/mixins/archetype-template';

export default Discourse.PostView.reopen({
  templateName: function() {
    return ArchetypeTemplate.get(this.get('controller.content'), 'post');
  }.property().cacheable()
});
