set :url_root, 'https://mywarp.github.com'

config[:js_dir] = 'assets/javascripts'
config[:css_dir] = 'assets/stylesheets'

# Activate and configure extensions
# https://middlemanapp.com/advanced/configuration/#configuring-extensions

activate :aria_current
activate :inline_svg

activate :external_pipeline,
  name: :esbuild,
  command: build? ? 'npm run build:esbuild' : 'npm run watch:esbuild',
  source: ".tmp/javascripts"

activate :external_pipeline,
  name: :sass,
  command: build? ? 'npm run build:sass' : 'npm run watch:sass',
  source: ".tmp/stylesheets"

activate :pagination do
  # See https://github.com/suresh44t/middleman-pagination#usage
  pageable_set :development_builds do
    # After 3.1.1-SNAPSHOT+Travis-b1930.git-10b9684e31, MyWarp switched its CI from Travis to Github actions. Build numbers started over from 0.
    # Here, we sort the list by (a) CI (alphabetically, i.e. Github Actions comes first) and (b) by build number (higher ones come first).
    data.builds.sort_by { |file_name, content| [content.build.by, -content.build.number.to_i]}
  end
end

# With alternative layout
# page '/path/to/file.html', layout: 'other_layout'

# Proxy pages
# https://middlemanapp.com/advanced/dynamic-pages

data.builds.each do |id, info|
  # see https://github.com/middleman/middleman/issues/1246#issuecomment-163596912
  proxy "/builds/#{info.build.number}.html",
    "single_build_information",
    :locals => {:info => info, :title => "Build No. #{info.build.number}" },
    :ignore => true
end

activate :autoprefixer

# Build-specific configuration
# https://middlemanapp.com/advanced/configuration/#environment-specific-settings

configure :development do
 set :debug_assets, true
 activate :livereload
end

configure :build do
  activate :minify_html

  activate :imageoptim do |options|
    #do not use pngout and svgo, both are not part of image_optim_pack
    options.pngout = false 
    options.svgo = false
  end

  activate :favicon_maker do |f|
    f.template_dir  = 'source/images'
    f.icons = {
      "_favicon_small.svg" => [
        { icon: "favicon-32x32.png" },
        { icon: "favicon-16x16.png" },
        { icon: "favicon.ico", size: "48x48,32x32,16x16" },
      ],
      "_favicon_large.svg" => [
        { icon: "apple-touch-icon.png", size: "180x180" },
        { icon: "mstile-70x70.png", size: "70x70" },
        { icon: "mstile-144x144.png", size: "144x144" },
        { icon: "mstile-150x150.png", size: "150x150" },
        { icon: "mstile-310x310.png", size: "310x310" },
        { icon: "mstile-310x150.png", size: "310x150" },
        { icon: "android-chrome-192x192.png", size: "192x192" },
        { icon: "android-chrome-512x512.png", size: "512x512" }
      ]
    }
  end

  activate :robots, 
  :rules => [
    {:user_agent => '*', :allow => %w(/)}
  ],
  :sitemap => config.url_root + "/sitemap.xml"

end

# after_build hook
# https://middlemanapp.com/advanced/custom-extensions/#after_build

after_build do |builder|
  builder.thor.run 'npm run after_build'
end

# Helpers
# Methods defined in the helpers block are available in templates
# https://middlemanapp.com/basics/helper-methods

helpers do
  
  def link_to_commit(commitHash)
    truncatedHash = commitHash[0...7]
    return link_to truncatedHash, "https://github.com/MyWarp/MyWarp/commit/" + commitHash
  end

  def artifact_files(buildInfo, includePattern="*", excludePattern="")
    path = 'source/files/' + buildInfo.build.number.to_s + '_' + buildInfo.commit.short_hash.to_s + '/';
    files =  Dir.glob( path + includePattern )

    unless excludePattern.empty?
      files -= Dir.glob(path + excludePattern)
    end

    return files
  end

  def file_url(binary)
    absolute_path = Pathname.new(binary)
    project_root  = Pathname.new("source")
    return '/' + absolute_path.relative_path_from(project_root).to_s
  end

  def file_size(binary, format="%.2f")
    return format % (File.size(binary).to_f / 2**20)
  end

 end
