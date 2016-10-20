# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "http://www.bigtalker.io"

SitemapGenerator::Sitemap.create do

  add '/about', :changefreq => 'weekly'
  add '/workshops', :changefreq => 'daily'

  #Add all talks
  Workshop.find_each do |workshop|
    add workshop_path(workshop), :lastmod => article.updated_at
  end

  add '/workshops/new'
  add '/contact', :changefreq => 'weekly'
  add '/signup', :changefreq => 'weekly'
  add '/signin', priority: 0.0



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
end
