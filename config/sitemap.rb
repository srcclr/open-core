# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "https://open.scrclr.com"
SitemapGenerator::Sitemap.sitemaps_path = '../../../public'
SitemapGenerator::Sitemap.create do
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/articles'
  #
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add all articles:
  #
  #   Article.find_each do |article|
  #     add article_path(article), :lastmod => article.updated_at
  #   end

  add "/guides"

  add "/latest"
  add "/new"
  add "/unread"
  add "/top"

  add "/categories"
  add "/c/general"
  add "/c/security-headers"
  add "/c/guides"
  add "/c/csp-reports"
  add "/c/bughunt"
  add "/c/ssl-reminder"

  add "/c/general/l/latest"
  add "/c/general/l/new"
  add "/c/general/l/unread"
  add "/c/general/l/top"
  add "/c/security-headers/l/latest"
  add "/c/security-headers/l/new"
  add "/c/security-headers/l/unread"
  add "/c/security-headers/l/top"
  add "/c/guides/l/latest"
  add "/c/guides/l/new"
  add "/c/guides/l/unread"
  add "/c/guides/l/top"
  add "/c/csp-reports/l/latest"
  add "/c/csp-reports/l/new"
  add "/c/csp-reports/l/unread"
  add "/c/csp-reports/l/top"
  add "/c/bughunt/l/latest"
  add "/c/bughunt/l/new"
  add "/c/bughunt/l/unread"
  add "/c/bughunt/l/top"
  add "/c/ssl-reminder/l/latest"
  add "/c/ssl-reminder/l/new"
  add "/c/ssl-reminder/l/unread"
  add "/c/ssl-reminder/l/top"

  add "/projects"
  add "/projects/security-headers"
  add "/projects/csp-reports"
  add "/projects/bughunt"
  add "/projects/ssl-reminder"

  add "/security-headers"
  add "/csp-reports"
  add "/bughunt"
  add "/ssl-reminder"

  add "/nwslttr"
  add "/nwslttr/latest"
end
