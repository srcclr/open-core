export default Discourse.AdminTocRoute = Discourse.Route.extend({

  model: function() {
    return Discourse.Toc.findAll();
  }
});
