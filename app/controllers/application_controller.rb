class ApplicationController < ActionController::Base
     layout :layout_by_resource

     private

     def layout_by_resource
        
          if devise_controller?
               "devise"        
          end
     end

     def authenticate_edit_profile!
          redirect_to profiles_path if current_user.profile.status === "completado" && !current_user.is_admin?
     end

     def authenticate_index_profile!
          redirect_to edit_profile_path(current_user.profile) if current_user.profile.status === "incompleto" && !current_user.is_admin?
     end

     def authenticate_admin
          redirect_to user_root_path unless user_signed_in? && current_user.is_admin? 
     end

     def verify_consulta!
          if recharge_params[:type_payment] === "Post-pago"
               if current_user.recharges.where(number: recharge_params[:number], type_operation: "consultation").any?
                    respond_to do |format|
                         format.json {head :no_content}
                         format.js { render :deneged_consulta}
                    end
               end
          end
     end

     def authenticate_user_register!
          redirect_to edit_profile_path(current_user.profile) unless current_user.profile.status === "completado" || current_user.is_admin?
     end
end
