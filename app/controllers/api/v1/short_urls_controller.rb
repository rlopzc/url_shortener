module Api::V1
  class ShortUrlsController < ApplicationController
    load_and_authorize_resource

    # GET api/v1/short_urls.json
    def index
      @short_urls = @current_user.short_urls.all
      render json: @short_urls
    end

    # GET api/v1/short_urls/1.json
    def show
      render json: @short_url
    end

    # POST api/v1/short_urls.json
    def create
      if short_url_params[:converted].blank?
        params[:short_url][:converted] = "http://#{request.host_with_port}/b/#{ShortUrl.generate}"
      else
        params[:short_url][:converted] = "http://#{request.host_with_port}/b/#{params[:short_url][:converted]}"
      end

      @short_url = @current_user.short_urls.new(short_url_params)

      if @short_url.save
        render json: @short_url
      else
        render json: @short_url.errors, status: :unprocessable_entity
      end
    end

    def destroy
      @short_url.destroy
      head :no_content
    end

    private
      # Never trust parameters from the scary internet, only allow the white list through.
      def short_url_params
        params.require(:short_url).permit(:original, :converted)
      end
  end
end
