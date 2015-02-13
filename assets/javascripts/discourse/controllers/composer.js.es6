import Composer from 'discourse/controllers/composer'

export default Composer.reopen({
  chapterList: Em.computed(function() {
    return _.map(
      Discourse.Site.currentProp('chapters'),
      function(chapter) { return Em.Object.create(chapter); }
    )
  })
});
