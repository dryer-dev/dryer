class Admin::PagesController < AdminController
  before_action :set_admin_page, only: %i[ edit update destroy ]

  # GET /admin/pages or /admin/pages.json
  def index
    @admin_pages = Page.all
  end

  # GET /admin/pages/1 or /admin/pages/1.json
  def show
  end

  # GET /admin/pages/new
  def new
    @admin_page = Page.new
  end

  # GET /admin/pages/1/edit
  def edit
  end

  # POST /admin/pages or /admin/pages.json
  def create
    @admin_page = Page.new(admin_page_params)

    respond_to do |format|
      if @admin_page.save
        format.html { redirect_to admin_page_url(@admin_page), notice: "Page was successfully created." }
        format.json { render :show, status: :created, location: @admin_page }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @admin_page.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/pages/1 or /admin/pages/1.json
  def update
    respond_to do |format|
      if @admin_page.update(admin_page_params)
        format.html { redirect_to admin_page_url(@admin_page), notice: "Page was successfully updated." }
        format.json { render :show, status: :ok, location: @admin_page }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @admin_page.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/pages/1 or /admin/pages/1.json
  def destroy
    @admin_page.destroy

    respond_to do |format|
      format.html { redirect_to admin_pages_url, notice: "Page was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_page
      @admin_page = Page.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def admin_page_params
      params.require(:page)
          .permit(
            :title
          )
    end
end
