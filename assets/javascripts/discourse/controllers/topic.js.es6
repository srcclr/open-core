import TopicControler from 'discourse/controllers/topic';

export default TopicControler.reopen({
  actions: {
    makeBook: function() {
      this.get('content').makeBook();
    },

    makeDefaultArchetype: function() {
      this.get('content').makeDefaultArchetype();
    },

    makeRecipe: function() {
      this.get('content').makeRecipe();
    }
  }
});
