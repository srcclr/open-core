Em.Handlebars.helper('formatted-date', function(date, format) {
  return moment(date).format(format);
});
