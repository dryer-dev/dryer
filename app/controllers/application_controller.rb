class ApplicationController < ActionController::Base
  set_current_tenant_by_subdomain_or_domain(:site, :subdomain, :domain)
end
