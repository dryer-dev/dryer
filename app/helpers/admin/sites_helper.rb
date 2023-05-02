# frozen_string_literal: true

module Admin::SitesHelper
  def site_sections
    get_haml_filenames("app/views/subdomains/#{current_tenant.subdomain}/sections") | application_snippets
  end

  def site_sections
    get_haml_filenames('app/views/sections')
  end

  def get_haml_filenames(directory)
    Dir.entries(directory)
       .select { |f| f.end_with? 'html.haml' }
       .map { |f| f.chomp('.html.haml') }
       .sort!
  end
end
