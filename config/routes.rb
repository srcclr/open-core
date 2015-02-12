DiscourseReports::Engine.routes.draw do
  scope '/t/:topic_id', as: 'topic', module: 'topics' do
    resource :archetype, only: %i(update destroy)
  end

  resource :homepage, only: :show
  root to: 'homepages#show', as: 'homepage_root'

  get 'terms-of-use' => 'homepages#show'
  get 'supporters' => 'homepages#show'
  get 'privacy-policy' => 'homepages#show'
  get 'contributors' => 'homepages#show'
  get 'communities' => 'homepages#show'
  get 'contact' => 'homepages#show'
  get 'about-site' => 'homepages#show'

  namespace :admin, constraints: StaffConstraint.new do
    resource :toc, constraints: AdminConstraint.new do
    end
  end
end
