Discourse.BBCode.register('part', {noWrap: true}, function(contents) {
  return ['div', {'class': 'part'}].concat(contents);
});
Discourse.BBCode.register('chapter', {noWrap: true}, function(contents) {
  return ['div', {'class': 'chapter'}].concat(contents);
});
Discourse.BBCode.replaceBBCode('sections', function(contents) {
  return ['div', {'class': 'sections'}].concat(contents);
});

Discourse.BBCode.replaceBBCode('related', function(contents) {
  return ['div', {'class': 'related'}].concat(contents);
});

Discourse.Markdown.whiteListTag('div', 'class', /^(part|chapter|sections|related)$/ );
