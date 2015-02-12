import Composer from 'discourse/controllers/composer'

export default Composer.reopen({
  chapterList: Em.computed(function() {
    return [
      Em.Object.create({name: 'Example 1', id: 1}),
      Em.Object.create({name: 'Example 2', id: 2}),
      Em.Object.create({name: 'Example 3', id: 3}),
      Em.Object.create({name: 'Example 4', id: 4})
    ]
  })
});
