# Activate and configure extensions
# https://middlemanapp.com/advanced/configuration/#configuring-extensions

activate :autoprefixer do |prefix|
  prefix.browsers = "last 2 versions"
end

# Layouts
# https://middlemanapp.com/basics/layouts/

# Per-page layout changes
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

# With alternative layout
# page '/path/to/file.html', layout: 'other_layout'

# Proxy pages
# https://middlemanapp.com/advanced/dynamic-pages/

# proxy(
#   '/this-page-has-no-template.html',
#   '/template-file.html',
#   locals: {
#     which_fake_page: 'Rendering a fake page with a local variable'
#   },
# )

# Helpers
# Methods defined in the helpers block are available in templates
# https://middlemanapp.com/basics/helper-methods/

# helpers do
#   def some_helper
#     'Helping'
#   end
# end

# Build-specific configuration
# https://middlemanapp.com/advanced/configuration/#environment-specific-settings

# configure :build do
#   activate :minify_css
#   activate :minify_javascript
# end
activate :directory_indexes
#Blog setting
activate :blog do |blog| 
  blog.name = "blog" 
  blog.prefix = "blog" 
  blog.paginate = true
  blog.per_page = 2
  blog.page_link = "page/{num}"
  blog.taglink = "tags/{tag}.html"
  blog.permalink = "{category}/{title}.html"
  blog.summary_separator = /(READMORE)/
  blog.layout = "article"
  blog.custom_collections = {
    category: {
      link: '/{category}.html',
      template: '/blog/category.html'
    }
  }
  blog.tag_template = "blog/tag.html"
  # blog.calendar_template = "calendar.html"
end 

activate :s3_sync do |s3_sync|
  s3_sync.bucket                     = 'bikes-xl' # The name of the S3 bucket you are targeting. This is globally unique.
  s3_sync.region                     = 'us-east-1'     # The AWS region for your bucket.
  s3_sync.aws_access_key_id          = ENV['S3_ACCESS_KEY']
  s3_sync.aws_secret_access_key      = ENV['S3_SECRET_ACCESS_KEY']
  s3_sync.delete                     = false # We delete stray files by default.
  s3_sync.after_build                = false # We do not chain after the build step by default.
  s3_sync.prefer_gzip                = true
  s3_sync.path_style                 = true
  s3_sync.reduced_redundancy_storage = false
  s3_sync.acl                        = 'public-read'
  s3_sync.encryption                 = false
  s3_sync.prefix                     = ''
  s3_sync.version_bucket             = false
  s3_sync.index_document             = 'index.html'
  s3_sync.error_document             = '404.html'
end
default_caching_policy max_age:(60 * 60 * 24 * 365) 

activate :dotenv

activate :inline