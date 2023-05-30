# frozen_string_literal: true

# admin namespace
module Admin
  # sites
  class SitesController < ApplicationController
    before_action :set_admin_site, only: %i[edit update destroy]

    # GET /admin/sites or /admin/sites.json
    def index
      @admin_sites = Site.all
    end

    # GET /admin/sites/1 or /admin/sites/1.json
    def show; end

    # GET /admin/sites/new
    def new
      @admin_site = Site.new
    end

    # GET /admin/sites/1/edit
    def edit; end

    # POST /admin/sites or /admin/sites.json
    def create
      @admin_site = Site.new(admin_site_params)

      respond_to do |format|
        if @admin_site.save
          format.html { redirect_to admin_sites_url, notice: 'Site was successfully created.' }
          format.json { render :show, status: :created, location: @admin_site }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @admin_site.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /admin/sites/1 or /admin/sites/1.json
    def update
      respond_to do |format|
        if @admin_site.update(admin_site_params)
          format.html { redirect_to admin_sites_url, notice: 'Site was successfully updated.' }
          format.json { render :show, status: :ok, location: @admin_site }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @admin_site.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /admin/sites/1 or /admin/sites/1.json
    def destroy
      @admin_site.destroy

      respond_to do |format|
        format.html { redirect_to admin_sites_url, notice: 'Site was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_admin_site
      @admin_site = Site.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def admin_site_params
      params.require(:site)
            .permit(
              :domain,
              :name,
              :subdomain
            )
    end
  end
end
