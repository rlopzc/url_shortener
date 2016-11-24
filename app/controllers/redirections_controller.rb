class RedirectionsController < ApplicationController
  skip_before_action :authenticate
  
  def redirect
    # Obtener la url corta
    @short_url = ShortUrl.find_by(converted: request.original_url)
    if @short_url
      ShortUrl.update_counters(@short_url.id, count: 1)
      redirect_to @short_url.original
    else
      redirect_to invalid_url_path
    end
  end
end
