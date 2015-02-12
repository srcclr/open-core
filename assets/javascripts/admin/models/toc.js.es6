export default Discourse.Toc = Discourse.Model.extend({
  delete: function() {
    return Discourse.ajax('/admin/part', {type: 'DELETE', data: {id: this.get('id')}});
  }
});

Discourse.Toc.reopenClass({
  findAll: function() {
    return Discourse.ajax("/admin/toc").then(function(data) {
      return data.map(function(d) {
        return Discourse.Toc.create(d);
      });
    });
  },
});
