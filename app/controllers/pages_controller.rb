class PagesController < ApplicationController
  skip_before_action :authenticate
  
  def invalid_url
  end
end
