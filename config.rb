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

# Pagination
# see: https://github.com/suresh44t/middleman-pagination#usage
activate :pagination do
  pageable_set :dev_builds do
    data.builds.sort.reverse
  end
end

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
data.builds.each do |id, info|
  proxy "/builds/#{info.commit.short_hash}.html", "single_build_information", :locals => {:info => info}, :ignore => true
end

# General configuration

# Reload the browser automatically whenever files change
configure :development do
  activate :livereload
end

# Always use autoprefixer
activate :autoprefixer

# Build-specific configuration
configure :build do

  # Ignore bitters test page
  ignore 'bitters.*'

  # Minify CSS, HTML & Javascript on build
  activate :minify_css
  activate :minify_html
  activate :minify_javascript

  # Optimize images on build
  activate :imageoptim

  # Create favicons
  activate :favicon_maker do |f|
    f.template_dir  = 'source/images'
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
  set :url_root, 'https://mywarp.github.io'
  activate :search_engine_sitemap
  
  # Generate robots.txt
  activate :robots, 
  :rules => [
    {:user_agent => '*', :allow => %w(/)}
  ],
  :sitemap => "https://mywarp.github.io/sitemap.xml" # change this!

end

after_build do |builder|
  builder.thor.create_file(config[:build_dir] + "/.nojekyll", "Deactivate Jekyll for this repository.", false)
end

###
# Helpers
###

# Methods defined in the helpers block are available in templates
 helpers do
  GITHUB_URL = 'https://github.com/MyWarp/MyWarp/commit/'
  
  def link_to_commit(commitHash)
    return link_to commitHash, GITHUB_URL + commitHash
  end

  def artifact_url(buildInfo, binaryName)
    return "/files/#{buildInfo.build.number}_#{buildInfo.commit.short_hash}/#{binaryName}"
  end

  def artifact_size(buildInfo, binaryName, format="%.2f")
    path = "source/files/#{buildInfo.build.number}_#{buildInfo.commit.short_hash}/#{binaryName}"
    return format % (File.size(path).to_f / 2**20)
  end
 end
