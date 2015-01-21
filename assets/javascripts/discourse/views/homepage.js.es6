var TOPBAR_LINKS_SELECTOR = '.top-bar-navigation a'
var NAVBAR_HEIGHT = 50;
var SCROLL_SPEED = 1000;

function initializeSmoothScroll() {
  var target = $(this).attr('href').substr(1);

  $('html, body').animate({
    scrollTop: $(target).offset().top - NAVBAR_HEIGHT
  }, SCROLL_SPEED);
}

export default Ember.View.extend(Discourse.ScrollTop, {
  didInsertElement: function() {
    $(TOPBAR_LINKS_SELECTOR).on('click', initializeSmoothScroll);
  },

  willDestroyElement: function() {
    $(TOPBAR_LINKS_SELECTOR).off('click', initializeSmoothScroll);
  }
});
