# frozen_string_literal: true

# admin namespace
module Admin
  # sections
  class SectionsController < ApplicationController
    before_action :set_admin_section, only: %i[edit update destroy]

    # GET /admin/sites/new
    def new
      @admin_section = Section.new
    end

    # GET /admin/sites/1/edit
    def edit; end

    # POST /admin/sites or /admin/sites.json
    def create
      @admin_section = Section.new(admin_section_params)

      respond_to do |format|
        if @admin_section.save
          format.json { render :show, status: :created, location: @admin_section }
        else
          format.json { render json: @admin_section.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /admin/sites/1 or /admin/sites/1.json
    def update
      respond_to do |format|
        if @admin_section.update(@admin_section_params)
          format.json { render :show, status: :ok, location: @admin_section }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @admin_section.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /admin/sites/1 or /admin/sites/1.json
    def destroy
      @admin_section.destroy

      respond_to do |format|
        format.json { head :no_content }
      end
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_admin_section
      @admin_ = Section.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def admin_section_params
      params.require(:section)
            .permit(
              :parent_id,
              :name
            )
    end
  end
end
