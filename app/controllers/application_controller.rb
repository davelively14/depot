class ApplicationController < ActionController::Base
  before_action :set_i18n_locale_from_params
  before_action :authorize

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

  # Sets the locale from the params, but only if htere is a locale in the params. Otherwise, it leaves the current
  # locale alone.
  def set_i18n_locale_from_params
    if params[:locale]
      if I18n.available_locales.map(&:to_s).include?(params[:locale])
        I18n.locale = params[:locale]
      else
        flash.now[:notice] = "#{params[:locale]} translation not available"
        logger.error flash.now[:notice]
      end
    end
  end

  # Provides a hash of URL options that are to be considered as present whenever they aren't otherwise provided. In
  # this case, we are providing a value for the :locale parameter. This is needed when a view on a page that does not
  # have the locale specified attempts to construct a link to a page that does.
  def default_url_options
    { locale: I18n.locale }
  end

  def authorize
    unless User.find_by(id: session[:user_id])
      redirect_to login_url, notice: "Please log in"
    end
  end
end
