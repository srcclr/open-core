import TopicView from 'discourse/views/topic';
import ArchetypeTemplate from 'discourse/plugins/Discourse reports/discourse/mixins/archetype-template';

export default TopicView.reopen({
  templateName: function() {
    return ArchetypeTemplate.get(this.get('topic'), 'topic');
  }.property('topic.archetype'),

  onChangeArchetype: function() {
    if (this.topic && this.topic.archetype) {
      this.rerender();
    }
  }.observes('topic.archetype'),
});
