Discourse.BBCode.replaceBBCode('navigation', function(contents) {
  return ['span', {'class': 'bbcode-nav'}].concat(Discourse.BBCode.removeEmptyLines(contents));
});
Discourse.BBCode.replaceBBCode('next', function(contents) {
  return ['span', {'class': 'bbcode-nav-next'}].concat(contents).concat([['i', {'class': 'fa fa-chevron-circle-right'}]]);
});
Discourse.BBCode.replaceBBCode('prev', function(contents) {
  return ['span', {'class': 'bbcode-nav-prev'}, ['i', {'class': 'fa fa-chevron-circle-left'}]].concat(contents);
});

Discourse.Markdown.whiteListTag('span', 'class', /^bbcode-nav(-next|-prev)?$/ );
Discourse.Markdown.whiteListTag('i', 'class', /^fa fa-chevron-circle(-left|-right)$/ );
