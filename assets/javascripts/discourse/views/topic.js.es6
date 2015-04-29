import TopicView from 'discourse/views/topic';
import ArchetypeTemplate from 'discourse/plugins/Discourse reports/discourse/mixins/archetype-template';

function toggleSection(expandedClass, collapsedClass) {
  return function (event) {
    var section = $(event.currentTarget).next();
    var icon = $(event.currentTarget).find('i')

    if ($(event.target).is('i')) {
      event.stopImmediatePropagation();
      event.stopPropagation();
      event.preventDefault();
    }

    if (section.is(':hidden')) {
      icon.removeClass(collapsedClass);
      icon.addClass(expandedClass);

      section.removeClass('hidden');
    } else {
      icon.removeClass(expandedClass);
      icon.addClass(collapsedClass);

      section.addClass('hidden');
    }
  }
}

export default TopicView.reopen({
  templateName: function() {
    return ArchetypeTemplate.get(this.get('topic'), 'topic');
  }.property('topic.archetype').cacheable(),

  onChangeArchetype: function() {
    if (this.topic && this.topic.archetype) {
      this.rerender();
    }
  }.observes('topic.archetype'),

  bindTocExpandable: function() {
    if(this.get('topic.archetype') != 'toc') { return; }

    setTimeout(function () {
      var expandableParts = $('h2:has(".fa-minus-square-o")');
      var expandableChapters = $('.sections > a');

      expandableParts.on('click', toggleSection('fa-minus-square-o', 'fa-plus-square-o'));
      expandableChapters.on('click', toggleSection('fa-minus-circle', 'fa-plus-circle'));
    }, 2000);

  }.on('didInsertElement'),

  unbindTocExpandable: function() {
    if(this.get('topic.archetype') != 'toc') { return; }

    var expandableParts = $('h2:has(".fa-minus-square-o")');
    var expandableChapters = $('.sections > a');

    expandableParts.off('click', toggleSection('fa-minus-square-o', 'fa-plus-square-o'));
    expandableChapters.off('click', toggleSection('fa-minus-circle', 'fa-plus-circle'));
  }.on('willClearRender')

});
