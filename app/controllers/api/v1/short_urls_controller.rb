module Api::V1
  class ShortUrlsController < ApplicationController
    before_action :set_short_url, only: [:show, :update, :destroy]

    # GET api/v1/short_urls.json
    def index
      @short_urls = ShortUrl.all
      render json: @short_urls
    end

    # GET api/v1/short_urls/1.json
    def show
    end

    # POST api/v1/short_urls.json
    def create
      if short_url_params[:converted].blank?
        params[:short_url][:converted] = "http://localhost/#{ShortUrl.generate}"
      else
        params[:short_url][:converted] = "http://localhost/#{params[:short_url][:converted]}"
      end

      @short_url = ShortUrl.new(short_url_params)

      if @short_url.save
        render json: @short_url
      else
        render json: @short_url.errors, status: :unprocessable_entity
      end
    end

    def destroy
      @short_url.destroy
      respond_to do |format|
        head :no_content
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_short_url
        @short_url = ShortUrl.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def short_url_params
        params.require(:short_url).permit(:original, :converted)
      end
  end
end
