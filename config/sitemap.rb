# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "http://www.bigtalker.io"

# SitemapGenerator.create_index = true

SitemapGenerator::Sitemap.public_path = 'tmp/sitemaps/'

SitemapGenerator::Sitemap.create do

  add '/workshops', :changefreq => 'daily'
  #add all talks
  Workshop.find_each do |workshop|
    add workshop_path(workshop.slug), :lastmod => workshop.updated_at,
    :changefreq => 'daily'
  end
  add '/about'
  add '/workshops/new'
  add '/contact'
  add '/signup'
  add '/signin', priority: 0.0
end
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

