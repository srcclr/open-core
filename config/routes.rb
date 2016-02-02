DiscourseReports::Engine.routes.draw do
  scope '/t/:topic_id', as: 'topic', module: 'topics' do
    resource :archetype, only: %i(update destroy)
  end

  resource :table_contents, only: %i(show update)
  get "guides", to: "table_contents#index"
  get "guides/:slug", to: "table_contents#show"

  resources :projects, only: %i(index show)
  resource :homepage, only: :show
  resources :howtos, only: :index
  resources :communities, only: :index
  resources :blogs, only: :index
  resources :taxonomies, only: :index
  get '/c/taxonomy' => 'taxonomies#index'
  get '/c/:parent_slug/taxonomy' => 'taxonomies#index'
  get '/c/taxonomy/filter/:letter' => 'taxonomies#index'
  get '/about' => 'about_site#show'

  resources :open_events, only: :index
  get 'communities/events' => 'open_events#index'
  get 'communities/groups' => 'communities#index'
  get 'communities/about' => 'communities#index'

  get 'users/:username/:archetype' => 'user_posts#index', constraints: { archetype: /blogs|how-tos/ }
  get 'posts/:username/:archetype' => 'user_posts#index', constraints: { archetype: /blogs|how-tos/ }

  root to: 'homepages#show', as: 'homepage_root'

  get 'supporters' => 'homepages#show'
  get 'contributors' => 'homepages#show'
  get 'contact' => 'homepages#show'
  get 'about-site' => 'homepages#show'

  get 'nwslttr' => 'homepages#show'
  get 'nwslttr/latest' => 'newsletters#latest'
  get 'nwslttr/:id' => 'newsletters#show'
  resources :newsletters, only: %W(index show) do
    member do
      get 'download' => 'newsletters#download'
    end
  end

  get 'community_request' => 'homepages#show'
  resource :community_request, only: :create

  namespace :admin, constraints: StaffConstraint.new do
    resources :parts, only: [:index, :create, :update, :destroy], constraints: AdminConstraint.new do
      resources :chapters, only: [:create, :update, :destroy], constraints: AdminConstraint.new
    end
    get 'toc' => 'parts#index'
  end

  get '/c/:category_slug/:slug',
    to: 'topic_urls#show',
    as: :topic_urls,
    constraints: DiscourseReports::SubCategoryConstraint.new

  resources :static_contents, only: :show
  resources :sections, only: :index

  post 'csp_reports', to: 'csp_reports#create'

  get "sitemap.xml", to: "sitemaps#index", format: :xml
end
