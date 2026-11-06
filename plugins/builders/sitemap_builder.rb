# frozen_string_literal: true

# Generates /sitemap.xml at build time. Replaces the bridgetown-sitemap
# plugin, which labelled every URL hreflang="en" (including Spanish posts and
# stories) because it reads Bridgetown's `locale` data instead of the `lang`
# front matter key, and which stamped every entry's <lastmod> with the build
# time on CI.
#
# This builder emits a self-referential hreflang per URL based on the page's
# `lang` front matter ("en" by default, "es-MX" for Spanish content) and real
# post/story dates for <lastmod>. See sitemap.erb.
class Builders::SitemapBuilder < SiteBuilder
  def build
    hook :site, :pre_render, priority: :low do |site|
      sitemap = Bridgetown::GeneratedPage.new(
        site, site.source, "/", "sitemap.erb", from_plugin: true
      )
      sitemap.content = File.read(File.expand_path("sitemap.erb", __dir__))
      sitemap.data.permalink = "/sitemap.xml"
      sitemap.data.layout = "none"

      site.generated_pages << sitemap
    end
  end
end
