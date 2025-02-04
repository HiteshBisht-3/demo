class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  rescue_from ActionController::RoutingError, with: :render_404
  private
  def render_404
    render file: Rails.public_path.join("404.html"), status: :not_found, layout: false
  end
end
