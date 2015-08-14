import TaxonomyRoute from "discourse/plugins/Discourse reports/discourse/routes/taxonomy"

export default TaxonomyRoute.extend({
  controllerName: 'taxonomy',
  templateName: 'taxonomy',

  params: function(transition) {
    return transition.params.taxonomyFilter;
  }
})
