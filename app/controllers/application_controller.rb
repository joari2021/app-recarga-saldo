class ApplicationController < ActionController::Base
	layout :layout_by_resource

    private

    def layout_by_resource
        
        if devise_controller?
       		"devise"        
        end
   end

   def authenticate_edit_profile!
        redirect_to profiles_path if current_user.profile.status != "incompleto"
   end

   def authenticate_index_profile!
        redirect_to edit_profile_path(current_user.profile) unless current_user.profile.status != "incompleto"
   end
end
