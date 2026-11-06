# frozen_string_literal: true

# Base class for site builders in plugins/builders. Bridgetown instantiates
# every SiteBuilder descendant (and every explicitly registered builder) at
# boot, so subclass this class in plugins/builders to add site functionality.
class SiteBuilder < Bridgetown::Builder
end
