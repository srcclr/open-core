NOT_ONLY_A_NUMBER = /.*[a-zA-Z_-]+.*/

DiscourseReports::Engine.routes.draw do
  scope '/t/:topic_id', as: 'topic', module: 'topics' do
    resource :archetype, only: %i(update destroy)
  end

  resource :table_contents, only: %i(show update)
  get 'table-of-contents', to: 'table_contents#show'

  resource :homepage, only: :show
  get 'recipes' => 'recipes#index'
  resources :recipes, only: %i(new edit), constraints: RecipeConstraint.new
  resources :communities, only: :index
  resources :blogs, only: :index

  resources :open_events, only: :index
  get 'communities/events' => 'open_events#index'
  get 'communities/groups' => 'communities#index'
  get 'communities/about' => 'communities#index'

  get 'users/:username/recipes' => 'user_recipes#index'
  get 'users/:username/blogs' => 'user_recipes#index'
  get 'posts/:username/recipes' => 'user_recipes#index'
  get 'posts/:username/blogs' => 'user_blogs#index'

  root to: 'homepages#show', as: 'homepage_root'

  get 'supporters' => 'homepages#show'
  get 'contributors' => 'homepages#show'
  get 'contact' => 'homepages#show'
  get 'about-site' => 'homepages#show'

  get 'community_request' => 'homepages#show'
  resource :community_request, only: :create

  namespace :admin, constraints: StaffConstraint.new do
    resources :parts, only: [:index, :create, :update, :destroy], constraints: AdminConstraint.new do
      resources :chapters, only: [:create, :update, :destroy], constraints: AdminConstraint.new
    end
    get 'toc' => 'parts#index'
  end

  get '/:part_slug/:chapter_slug/:topic_slug',
    to: 'topics#show',
    as: :part_chapter_topic,
    constraints: {
      part_slug: Regexp.new(SiteSetting.parts_constraint),
      chapter_slug: NOT_ONLY_A_NUMBER,
      topic_slug: NOT_ONLY_A_NUMBER
    }

  resources :static_contents, only: :show
  resources :recipe_subcategories, only: :index
end
