import Composer from 'discourse/controllers/composer'

function makeSections(results) {
  return _.map(results,
    function(topic) {
      return Em.Object.create({ id: topic.id, name: topic.title })
    });
}

export default Composer.reopen({
  sectionList: [],

  chapterList: Em.computed(function() {
    return _.map(
      Discourse.Site.currentProp('chapters'),
      function(chapter) { return Em.Object.create(chapter); }
    )
  }),

  getSectionsByChapter: Em.observer('model.chapter_id', function() {
    var chapter_id = this.get('model.chapter_id'),
        self = this;

    if (_.isUndefined(chapter_id)) { return; }

    return Discourse.ajax('/sections', { data: { chapter_id: chapter_id } }).then(function(results) {
      self.set('sectionList', makeSections(results));
    });
  })
});
