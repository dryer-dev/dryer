# frozen_string_literal: true

class PagesController < ApplicationController
  before_action :set_page, only: %i[show]

  def index
    @pages = Page.all
    render "#{current_tenant.subdomain}/index" if current_tenant
  end

  # GET /pages/1 or /pages/1.json
  def show; end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_page
    @page = Page.find(params[:id])
  end
end
