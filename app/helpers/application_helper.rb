# frozen_string_literal: true

#
# application level helper methods
#
module ApplicationHelper
  #
  # transport layer, subdomain, tld, port
  def url_sans_path
    request.url.gsub(request.path, '')
  end
end
