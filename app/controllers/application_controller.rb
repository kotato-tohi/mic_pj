class ApplicationController < ActionController::Base
    before_action :authenticate_user!, if: :use_auth?

    def after_sign_in_path_for(resource)
        storage_list_path
      end
    
      def after_sign_out_path_for(resource)
        top_path
      end

      # topコントローラのindexアクションの場合trueを返し、before_actionを除外する。
      def use_auth?
        unless controller_name == 'top' && action_name == 'index'
          true
        end
      end


end
