import MenuPanel from 'discourse/components/menu-panel';

export default MenuPanel.reopen({
  viewMode: 'drop-down',
  _layoutComponent() {
    if (!this.get('visible')) { return; }

    const $window = $(window);
    let width = this.get('maxWidth') || 300;
    const windowWidth = parseInt($window.width());

    if ((windowWidth - width) < 50) {
      width = windowWidth - 50;
    }

    const viewMode = this.get('viewMode');
    const $panelBody = this.$('.panel-body');
    const $buttonPanel = $('header ul.icons');
    if ($buttonPanel.length === 0) { return; }

    const buttonPanelPos = $buttonPanel.offset();

    const posTop = parseInt(buttonPanelPos.top + $buttonPanel.height() - $('header.d-header').offset().top);
    const posLeft = parseInt(buttonPanelPos.left + $buttonPanel.width() - width);

    this.$().css({ left: posLeft + "px", top: posTop + "px" });

    // adjust panel height
    let contentHeight = parseInt(this.$('.panel-body-contents').height());
    const fullHeight = parseInt($window.height());

    const offsetTop = this.$().offset().top;
    const scrollTop = $window.scrollTop();
    if (contentHeight + (offsetTop - scrollTop) + PANEL_BODY_MARGIN > fullHeight) {
      contentHeight = fullHeight - (offsetTop - scrollTop) - PANEL_BODY_MARGIN;
    }
    $panelBody.height(contentHeight);
    $('body').addClass('drop-down-visible');

    this.$().width(width);
  }
});
