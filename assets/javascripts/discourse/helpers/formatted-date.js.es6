Ember.Handlebars.registerBoundHelper('formatted-date', function(date, format) {
  return moment(date).format(format);
});
