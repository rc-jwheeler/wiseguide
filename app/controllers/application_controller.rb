class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!, :set_cache_buster

  rescue_from CanCan::AccessDenied do |exception|
    render :file => "#{Rails.root}/public/403", :formats => [:html], :status => 403
  end

  def test_exception_notification
    raise 'Testing, 1 2 3.'
  end

  private

  def set_cache_buster
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end
end
