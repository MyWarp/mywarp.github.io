###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

# With alternative layout
# page "/path/to/file.html", layout: :otherlayout

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", locals: {
#  which_fake_page: "Rendering a fake page with a local variable" }

# General configuration

# Reload the browser automatically whenever files change
configure :development do
  activate :livereload
end

# Always use autoprefixer
activate :autoprefixer

###
# Helpers
###

# Methods defined in the helpers block are available in templates
 helpers do
  # ====================================
  #   Obfuscate email
  #   Adapted from: http://stackoverflow.com/q/483212/1692291
  #   Usage: = mailto('hi@email.com', 'Get in touch', 'btn btn--nav')
  # ====================================
  MAIL_TO = 'mailto:'
  AT = ' [at] '
  DOT = ' [dot] '

  def mailto email="user@example.com", string=email, classes=""
    comp = email.split("@")

    # process string, if it is an email address
    if string.include?("@") then
      string.gsub!("@", AT + "&zwnj;").gsub!(".", DOT)
    end

    return "<a class=\"#{classes}\" href='javascript:void(0)' rel='nofollow' onclick='str1=\"#{comp[0]}\";str2=\"#{comp[1]}\";this.href=\"#{MAIL_TO}\" + str1 + \"@\" + str2'>#{string}</a>"
  end
 end

# Build-specific configuration
configure :build do

  # Minify CSS, HTML & Javascript on build
  activate :minify_css
  activate :minify_html
  activate :minify_javascript

  # Optimize images on build
  # activate :imageoptim

  # Create favicons
  activate :favicon_maker do |f|
    f.icons = {
      "_favicon_template.svg" =>  [
        { icon: "apple-touch-icon-180x180-precomposed.png" },             # Same as apple-touch-icon-57x57.png, for iPhone 6+
        { icon: "apple-touch-icon-152x152-precomposed.png" },             # Same as apple-touch-icon-57x57.png, for retina iPad with iOS7.
        { icon: "apple-touch-icon-144x144-precomposed.png" },             # Same as apple-touch-icon-57x57.png, for retina iPad with iOS6 or prior.
        { icon: "apple-touch-icon-120x120-precomposed.png" },             # Same as apple-touch-icon-57x57.png, for retina iPhone with iOS7.
        { icon: "apple-touch-icon-114x114-precomposed.png" },             # Same as apple-touch-icon-57x57.png, for retina iPhone with iOS6 or prior.
        { icon: "apple-touch-icon-76x76-precomposed.png" },               # Same as apple-touch-icon-57x57.png, for non-retina iPad with iOS7.
        { icon: "apple-touch-icon-72x72-precomposed.png" },               # Same as apple-touch-icon-57x57.png, for non-retina iPad with iOS6 or prior.
        { icon: "apple-touch-icon-60x60-precomposed.png" },               # Same as apple-touch-icon-57x57.png, for non-retina iPhone with iOS7.
        { icon: "apple-touch-icon-57x57-precomposed.png" },               # iPhone and iPad users can turn web pages into icons on their home screen. Such link appears as a regular iOS native application. When this happens, the device looks for a specific picture. The 57x57 resolution is convenient for non-retina iPhone with iOS6 or prior. Learn more in Apple docs.
        { icon: "apple-touch-icon-precomposed.png", size: "57x57" },      # Same as apple-touch-icon.png, expect that is already have rounded corners (but neither drop shadow nor gloss effect).
        { icon: "apple-touch-icon.png", size: "57x57" },                  # Same as apple-touch-icon-57x57.png, for "default" requests, as some devices may look for this specific file. This picture may save some 404 errors in your HTTP logs. See Apple docs
        { icon: "favicon-196x196.png" },                                  # For Android Chrome M31+.
        { icon: "favicon-160x160.png" },                                  # For Opera Speed Dial (up to Opera 12; this icon is deprecated starting from Opera 15), although the optimal icon is not square but rather 256x160. If Opera is a major platform for you, you should create this icon yourself.
        { icon: "favicon-96x96.png" },                                    # For Google TV.
        { icon: "favicon-32x32.png" },                                    # For Safari on macOS.
        { icon: "favicon-16x16.png" },                                    # The classic favicon, displayed in the tabs.
        { icon: "favicon.png", size: "16x16" },                           # The classic favicon, displayed in the tabs.
        { icon: "favicon.ico", size: "64x64,32x32,24x24,16x16" },         # Used by IE, and also by some other browsers if we are not careful.
        { icon: "mstile-70x70.png", size: "70x70" },                      # For Windows 8 / IE11.
        { icon: "mstile-144x144.png", size: "144x144" },
        { icon: "mstile-150x150.png", size: "150x150" },
        { icon: "mstile-310x310.png", size: "310x310" },
        { icon: "mstile-310x150.png", size: "310x150" }
      ]
    }
  end

  # Generate sitemap
  set :url_root, 'http://my-website.com' # change this!
  activate :search_engine_sitemap

end

# Deploy configuration
activate :deploy do |deploy|
  deploy.deploy_method   = :ftp
  deploy.host            = 'ftp.my-website.com' # change this!
  deploy.path            = '/'
  deploy.user            = 'USER' # change this!
  deploy.password        = 'PASSWORD' # change this!
  # optional
  deploy.build_before = true
end
