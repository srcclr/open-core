function toggleSection(expandedClass, collapsedClass) {
  return function (event) {
    var section = $(event.currentTarget).next();
    var icon = $(event.currentTarget).find('i')

    if ($(event.target).is('i')) {
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

export default {
  name: "expand-topic-links",
  initialize: function() {
    var $main = $('#main');
    var events = $._data($main.get(0), 'events').click;

    $main.on('click.discourse', '.cooked h2:has("i.fa")', toggleSection('fa-minus-square-o', 'fa-plus-square-o'));
    $main.on('click.discourse', '.sections > a', toggleSection('fa-minus-circle', 'fa-plus-circle'));

    events.unshift(events.pop(), events.pop());
  }
};
