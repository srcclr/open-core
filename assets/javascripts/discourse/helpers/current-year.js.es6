Handlebars.registerHelper('current-year', function() {
  return new Handlebars.SafeString((new Date()).getFullYear());
});
