xml.instruct! :xml, :version=>"1.0", :encoding=>"UTF-8"

xml.rss :version => "2.0" do
  xml.channel do
    xml.title "MyWarp Development Builds"
    xml.description "Provides information about succesfull MyWarp builds."
    xml.link "http://mywarp.github.io/builds/"
    xml.pubDate Date.strptime(data.builds.values.last.build.date, "%d/%m/%Y").rfc822
    xml.lastBuildDate DateTime.now.rfc822
    xml.image do
      xml.url "http://mywarp.github.io/favicon-32x32.png"
      xml.title "MyWarp Development Builds"
      xml.link "http://mywarp.github.io/builds/"
      xml.height "32"
      xml.width "32"
    end

    data.builds.each do |id, info|
      xml.item do
        xml.title "Build No. #{info.build.number} (#{info.commit.short_hash})"
        xml.description info.commit.message
        xml.pubDate Date.strptime(info.build.date, "%d/%m/%Y").rfc822
        xml.link "http://mywarp.github.io/builds/#{info.commit.short_hash}.html"
        xml.guid "http://mywarp.github.io/builds/#{info.commit.short_hash}.html", "isPermaLink" => "true" 
      end
    end

  end
end