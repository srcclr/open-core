export default Discourse.Section = Discourse.Model.extend({ });

Discourse.Section.reopenClass({
  makeSection: function(section) {
    return Discourse.Section.create({
      id: section.id,
      name: section.title
    });
  }
});
