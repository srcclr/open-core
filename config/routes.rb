DiscourseReports::Engine.routes.draw do
  scope '/t/:topic_id', as: 'topic', module: 'topics' do
    resource :archetype, only: %i(update destroy)
  end
end
