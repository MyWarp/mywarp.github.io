---
layout: false
directory_index: false
---
# See https://gist.github.com/ls-lukebowerman/3287848#gistcomment-2363392
pages = sitemap.resources
  .reject{|r| r.is_a? Middleman::Sitemap::Extensions::RedirectResource }
  .find_all{|p| p.ext.casecmp?(".html") && !p.data.noindex == true }

xml.instruct! :xml, :version=>"1.0", :encoding=>"UTF-8"
xml.urlset "xmlns" => "http://www.sitemaps.org/schemas/sitemap/0.9" do

  pages.each do |page|

  xml.url do
    xml.loc config.url_root + page.url.gsub('/index.html','')
    xml.changefreq page.data.change_frequency || 'monthly'
    xml.priority page.data.priority || 0.5
  end
end
end
