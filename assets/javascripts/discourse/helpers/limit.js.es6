Em.Handlebars.helper('limit', function (arr, limit) {
  if (!_.isArray(arr)) { return []; }
  return arr.slice(0, limit);
});
