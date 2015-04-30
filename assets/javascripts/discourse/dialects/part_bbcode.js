Discourse.BBCode.register('part', {noWrap: true}, function(contents) {
  return ['div', {'class': 'part'}].concat(contents);
});

Discourse.BBCode.register('expandable', {noWrap: true}, function(contents) {
  return ['span', {'data-toggle': 'collapse'}].concat(contents);
});

Discourse.BBCode.register('chapter', {noWrap: true}, function(contents) {
  return ['div', {'class': 'chapter'}].concat(contents);
});

Discourse.BBCode.replaceBBCode('expandable-icon-square', function(contents) {
  return ['i', {'class': 'fa fa-minus-square-o'}].concat(contents);
});

Discourse.BBCode.replaceBBCode('expandable-icon-circle', function(contents) {
  return ['i', {'class': 'fa fa-plus-circle'}].concat(contents);
});

Discourse.BBCode.replaceBBCode('sections', function(contents) {
  return ['div', {'class': 'sections'}].concat(contents);
});

Discourse.BBCode.replaceBBCode('section', function(contents) {
  return ['div', {'class': 'collapsable-section hidden'}].concat(contents);
});

Discourse.BBCode.replaceBBCode('related', function(contents) {
  return ['div', {'class': 'related'}].concat(contents);
});

Discourse.BBCode.replaceBBCode('num', function(contents) {
  return ['span', {'class': 'num'}].concat(contents);
});

Discourse.BBCode.replaceBBCode('incomplete', function(contents) {
  return ['span', {'class': 'incomplete-topic'}].concat(contents);
});

Discourse.BBCode.replaceBBCode('started-topic', function(contents) {
  return ['span', {'class': 'started-topic'}].concat(contents);
});

Discourse.Markdown.whiteListTag('div', 'class', /^(part|chapter|sections|collapsable-section hidden|related)$/ );
Discourse.Markdown.whiteListTag('span', 'data-toggle', /^(collapse)$/ );
Discourse.Markdown.whiteListTag('i', 'class', /^(fa fa-minus-square-o|fa fa-plus-circle)$/ );
Discourse.Markdown.whiteListTag('span', 'class', /^(num|incomplete-topic|started-topic)$/ );
