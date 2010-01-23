module CommonThread
  module Filters
    protected

    # Filter method to enforce a SSL requirement.
    #
    # To require SSL for all actions, use this in your controllers:
    #
    #   before_filter :ssl_required
    #
    # To require SSL for specific actions, use this in your controllers:
    #
    #   before_filter :ssl_required, :only => [ :edit, :update ]
    #
    # To skip this in a subclassed controller:
    #
    #   skip_before_filter :ssl_required
    #
    def ssl_required
      if RAILS_ENV == 'production' and !request.ssl?
        redirect_to "https://" + request.host + request.request_uri
        return false
      end
    end

    # Filter method to enforce that no one is logged in. Requires that you have logged_in? implemented.
    #
    # To require anonomous for all actions, use this in your controllers:
    #
    #   before_filter :anonomous_required
    #
    # To require anonomous for specific actions, use this in your controllers:
    #
    #   before_filter :anonomous_required, :only => [ :edit, :update ]
    #
    # To skip this in a subclassed controller:
    #
    #   skip_before_filter :anonomous_required
    #
    def anonomous_required
      !logged_in? || redirect_back_or_default('/')
    end
  end
end
