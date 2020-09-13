class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?

    def after_sign_in_path_for(resource)
      case resource
      when Owner
        owners_top_path
      when Customer
        root_path
      end
    end

    def after_sign_out_path_for(resource)
      case resource
      when :owner
        new_owner_session_path
      when :customer
        root_path
      end
    end

    protected
    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name, :first_name, :last_furigana, :first_furigana, :postal_code, :address, :telephone_number])
    end

    def update_resource(resource, params)
        resource.update_without_password(params)
    end

    def after_update_path_for(resource)
      customer_path(resource)
    end
end
