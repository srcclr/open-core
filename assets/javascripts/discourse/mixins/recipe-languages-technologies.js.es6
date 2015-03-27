var TAGS_FILTER_REGEXP = /[<\\\/\>\.\#\?\&\s]/g;

function prepareTag(tag) {
  var key = tag.toLowerCase().replace(TAGS_FILTER_REGEXP, '');

  return { id: key, value: tag };
}

export default {
  languages: Em.computed(function() {
    return _.map(Discourse.SiteSettings.languages.split('|'), prepareTag);
  }),

  technologies: Em.computed(function() {
    return _.map(Discourse.SiteSettings.technologies.split('|'), prepareTag);
  }),

  tags: Em.computed('model.tags', function() {
    var languages = this.get('languages').map(function(item) { return item.id });
    var technologies = this.get('technologies').map(function(item) { return item.id });
    var tags = this.get('model.tags');

    return _.difference(tags, languages, technologies);
  })
}
