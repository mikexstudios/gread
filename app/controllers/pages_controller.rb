class PagesController < HighVoltage::PagesController
  #force_ssl :except => :all

  skip_before_filter :authenticate_user!
  before_filter :check_redirect

  layout :layout_for_page

  protected
    def layout_for_page
      case params[:id]
      when 'home'
        'home'
      else
        'reader'
      end
    end

    # The point of this filter is to check if the id is 'home'. If so, and if
    # the user is already logged in, redirects user to the dashboard page.
    def check_redirect
      if params[:id] == 'home' and user_signed_in?
        #redirect_to page_path('dashboard')
        redirect_to feeds_path
      end
    end
end

