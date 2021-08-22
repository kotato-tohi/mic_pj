class ApplicationController < ActionController::Base
    # before_action :authenticate_user!
    def after_sign_in_path_for(resource)
        test_path
      end
    
      def after_sign_out_path_for(resource)
        top_path
      end


end
