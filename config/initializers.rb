# Welcome to Bridgetown!
#
# This configuration file is for settings which affect your whole site.
#
# For more documentation on using this initializers file, visit:
# https://www.bridgetownrb.com/docs/configuration/initializers/
#
# A list of all available configuration options can be found here:
# https://www.bridgetownrb.com/docs/configuration/options
#
# For technical reasons, this file is *NOT* reloaded automatically when you use
# `bin/bridgetown start`. If you change this file, please restart the server process.
#
# For reloadable site metadata like title, SEO description, social media
# handles, etc., take a look at `src/_data/site_metadata.yml`

# Jekyll slugifies the permalink :title placeholder with mode "pretty" and
# cased: true, so post URLs keep their original case and underscores
# (e.g. /2016/07/22/8_reasons_why_you_should_not_shoot_JPEG.html).
# Bridgetown's default slugify always downcases, which would break those
# URLs, so return the raw slug value (all slugs in this site are already
# URL-safe: letters, digits, hyphens, underscores).
Bridgetown::Resource::PermalinkProcessor.register_placeholder :slug, ->(resource) do
  { raw_value: resource.data.slug || resource.basename_without_ext }
end

# Jekyll never auto-titles pages: a page without a `title` in front matter
# renders with the site title. Bridgetown's ensure_default_data assigns
# `titleize_slug(slug)` ("Index", "About", "404", …), which would leak into
# <title> and the OG/Twitter metas. Remember whether the front matter really
# set a title, then drop the auto-assigned one for pages.
module JekyllPageTitleParity
  def data=(new_data)
    @front_matter_had_title = new_data&.key?("title")
    super
  end

  def front_matter_had_title?
    @front_matter_had_title
  end
end
Bridgetown::Resource::Base.prepend(JekyllPageTitleParity)

# Bridgetown strips the .html extension from resource URLs (its "pretty URL"
# convention), but this site's existing URLs include it — post links are
# /2015/06/04/slug.html, not /2015/06/04/slug. Only strip the index.html
# suffix, which Bridgetown and Jekyll agree on.
module JekyllHtmlExtensionParity
  private

  def format_url(url)
    url.to_s.sub(%r{index\.html?$}, "")
  end
end
Bridgetown::Resource::Base.prepend(JekyllHtmlExtensionParity)

# Jekyll's page URL rules, which Bridgetown does not reproduce by default:
# a page without a front matter permalink keeps its file path and gets the
# output extension appended (404.html → /404.html), whereas Bridgetown's
# "/:path/" pages permalink would emit the extensionless /404/.
Bridgetown::Hooks.register :resources, :post_read, reloadable: false do |resource|
  next unless resource.collection.label == "pages"

  resource.data.delete("title") unless resource.front_matter_had_title?

  permalink = resource.data["permalink"]
  if permalink.nil? && resource.basename_without_ext != "index"
    resource.data["permalink"] =
      "/#{resource.relative_path.to_s.chomp(resource.extname)}.html"
  end
end

# Jekyll pages append the output extension to the destination FILE when a
# front matter permalink lacks both a trailing slash and an extension
# (permalink: /about/resume writes about/resume.html while the page URL stays
# /about/resume). Bridgetown would write an extensionless file instead.
module JekyllPageDestinationParity
  def output_path
    path = super
    unless relative_url.end_with?("/") || relative_url.end_with?(final_ext)
      path = "#{path}#{final_ext}"
    end
    path
  end
end
Bridgetown::Resource::Destination.prepend(JekyllPageDestinationParity)

Bridgetown.configure do |config|
  # The base hostname & protocol for your site, e.g. https://example.com
  # (Set in bridgetown.config.yml instead — do not uncomment this line, it
  # would override the YAML value with an empty URL.)
  # url ""

  # Available options are `erb` (default), `serbea`, or `liquid`
  template_engine "liquid"

  # Other options you might want to investigate:

  # See list of timezone values here:
  # https://en.wikipedia.org/wiki/List_of_tz_database_time_zones
  #
  # timezone "America/Los_Angeles"

  # Add collection pagination features to your site. Documentation here:
  # https://www.bridgetownrb.com/docs/content/pagination
  #
  # pagination do
  #   enabled true
  # end

  # Configure the permalink style for pages and posts. Custom collections can be
  # configured separately under the `collections` key. Documentation here:
  # https://www.bridgetownrb.com/docs/content/permalinks
  #
  # permalink "simple"

  # Optionally host your site off a path, e.g. /blog. If you set this option,
  # ensure you use the `relative_url` helper for all links and assets in your HTML.
  # If you're using esbuild for frontend assets, edit `esbuild.config.js` to
  # update `publicPath`.
  #
  # base_path "/"

  # You can also modify options on this configuration object directly, like so:
  #
  # config.autoload_paths << "models"

  # If you find you're having trouble using the new Fast Refresh feature in development,
  # you can disable it to force full rebuilds instead:
  #
  # fast_refresh false

  # You can use `init` to initialize various Bridgetown features or plugin gems.
  # For example, you can use the Dotenv gem to load environment variables from
  # `.env`. Just `bundle add dotenv` and then uncomment this:
  #
  # init :dotenv
  #

  # Uncomment to use Bridgetown SSR (aka dynamic rendering of content via Roda):
  #
  # init :ssr
  #

  # RSS/Atom feed generation (/feed.xml)
  init :"bridgetown-feed"

  # SEO meta tags (title, description, canonical, Open Graph, Twitter cards)
  init :"bridgetown-seo-tag"

  # sitemap.xml generation
  init :"bridgetown-sitemap"

  # Add `sessions: true` if you need to use session data, flash, etc.
  #

  # Uncomment to use file-based dynamic template routing via Roda (make sure you
  # uncomment the gem dependency in your `Gemfile` as well):
  #
  # init :"bridgetown-routes"
  #
  # NOTE: you can remove `init :ssr` if you load this initializer
  #

  # We also recommend that if you're using Roda routes you include this plugin
  # so you can get a generated routes list in `.routes.json`. You can then run
  # `bin/bridgetown roda:routes` to print the routes. (This will require you to
  # comment your route blocks. See example in `server/routes/hello.rb.sample`.)
  #
  # only :server do
  #   init :parse_routes
  # end
  #

  # You can configure the inflector used by Zeitwerk and models. A few acronyms are provided
  # by default like HTML, CSS, and JS, so a file like `html_processor.rb` could be defined by
  # `HTMLProcessor`. You can add more like so:
  #
  # config.inflector.configure do |inflections|
  #   inflections.acronym "W3C"
  # end
  #
  # Bridgetown's inflector is based on Dry::Inflector so you can read up on how to add inflection
  # rules here: https://dry-rb.org/gems/dry-inflector/1.0/#custom-inflection-rules

  # For more documentation on how to configure your site using this initializers file,
  # visit: https://edge.bridgetownrb.com/docs/configuration/initializers/
end
