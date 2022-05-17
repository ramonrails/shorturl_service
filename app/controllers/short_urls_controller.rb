class ShortUrlsController < ApplicationController
  before_action :set_short_url, only: %i[show edit update destroy]
  before_action :goto_original_url, only: :show
  before_action :set_history, only: :show

  # GET /short_urls or /short_urls.json
  def index
    @short_urls = ShortUrl.all
  end

  # GET /short_urls/1 or /short_urls/1.json
  def show; end

  # GET /short_urls/new
  def new
    @short_url = ShortUrl.new
  end

  # GET /short_urls/1/edit
  def edit; end

  # POST /short_urls or /short_urls.json
  def create
    @short_url = ShortUrl.new(short_url_params)

    respond_to do |format|
      if @short_url.save
        format.html { redirect_to short_url_url(@short_url), notice: 'Short url was successfully created.' }
        format.json { render :show, status: :created, location: @short_url }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @short_url.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /short_urls/1 or /short_urls/1.json
  def update
    respond_to do |format|
      if @short_url.update(short_url_params)
        format.html { redirect_to short_url_url(@short_url), notice: 'Short url was successfully updated.' }
        format.json { render :show, status: :ok, location: @short_url }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @short_url.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /short_urls/1 or /short_urls/1.json
  def destroy
    @short_url.destroy

    respond_to do |format|
      format.html { redirect_to short_urls_url, notice: 'Short url was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_short_url
      # NOTE: smart fetch by ID or shortcode
      @short_url = ShortUrl.fetch(params[:id])
    end

    # TODO: A user can access a /<shortcode> endpoint and be redirected to the URL associated with that shortcode, if it exists.
    # 
    def goto_original_url
      return unless request.path == "/#{@short_url.shortcode}" && @short_url.present?

      redirect_to @short_url.url, target: '_window', allow_other_host: true
    end

    # NOTE:
    # set the click history
    def set_history
      # no action when we are using edit or other path
      return unless request.path.match?(/stats\z/)

      # update last access timestamp
      @short_url.update_columns(last_accessed_at: DateTime.current)
      # reliably update counter column, without multi-threaded issues
      @short_url.increment!(:counts)
    end

    # Only allow a list of trusted parameters through.
    def short_url_params
      params.require(:short_url).permit(:url, :shortcode, :last_accessed_at, :counts)
    end
end
