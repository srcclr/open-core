export default Ember.Controller.extend({
  discussionsCategories: Ember.computed(function() {
    return ['Process', 'Design/Architecture', 'Coding', 'Testing/QA', 'Monitoring'];
  })
});
