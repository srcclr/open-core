Discourse.BBCode.register('chapter', {noWrap: true}, function(contents) {
  return ['div', {'class': 'chapter'}].concat(contents);
});
Discourse.BBCode.register('sections', {noWrap: true}, function(contents) {
  return ['div', {'class': 'sections'}].concat(contents);
});

Discourse.Markdown.whiteListTag('div', 'class', 'chapter' );
Discourse.Markdown.whiteListTag('div', 'class', 'sections' );
