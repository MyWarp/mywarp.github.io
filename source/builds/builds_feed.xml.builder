xml.instruct! :xml, :version=>"1.0", :encoding=>"UTF-8"

xml.rss :version => "2.0" do
  xml.channel do
    xml.title "MyWarp Development Builds"
    xml.description "Provides information about succesfull MyWarp builds."
    xml.link "mywarp.github.io/builds.html"

    data.builds.each do |id, info|
      xml.item do
        xml.title "Build No. #{info.build.number} (#{info.commit.short_hash})"
        xml.description info.commit.message
        xml.pubDate info.build.date
        xml.link "mywarp.github.io/builds/#{info.commit.short_hash}.html"
      end
    end

  end
end