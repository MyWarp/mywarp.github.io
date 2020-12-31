set :url_root, 'https://mywarp.github.com'

# Activate and configure extensions
# https://middlemanapp.com/advanced/configuration/#configuring-extensions

#
activate :aria_current

activate :autoprefixer do |prefix|
  prefix.browsers = "last 2 versions"
end

# See https://github.com/suresh44t/middleman-pagination#usage
activate :pagination do
  pageable_set :development_builds do
    # After 3.1.1-SNAPSHOT+Travis-b1930.git-10b9684e31, MyWarp switched its CI from Travis to Github actions. Build numbers started over from 0.
    # Here, we sort the list by (a) CI (alphabetically, i.e. Github Actions comes first) and (b) by build number (higher ones come first).
    data.builds.sort_by { |file_name, content| [content.build.by, -content.build.number.to_i]}
  end
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

data.builds.each do |id, info|
  # see https://github.com/middleman/middleman/issues/1246#issuecomment-163596912
  proxy "/builds/#{info.build.number}.html", "single_build_information", :locals => {:info => info, :title => "Build No. #{info.build.number}" }, :ignore => true
end

# Helpers
# Methods defined in the helpers block are available in templates
# https://middlemanapp.com/basics/helper-methods/

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

# Build-specific configuration
# https://middlemanapp.com/advanced/configuration/#environment-specific-settings

configure :development do
  activate :livereload
end

# Build-specific configuration
configure :build do

  # Minify CSS, HTML & Javascript on build
  activate :minify_css
  activate :minify_html
  activate :minify_javascript

  # Optimize images on build
  activate :imageoptim
  
  # Generate robots.txt
  activate :robots, 
  :rules => [
    {:user_agent => '*', :allow => %w(/)}
  ],
  :sitemap => config.url_root + "/sitemap.xml"

end
