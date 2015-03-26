var TAGS_FILTER_REGEXP = /[<\\\/\>\.\#\?\&\s]/;

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
}
