module PermissionsConcern
    def is_admin?
        self.permission_level === 3
    end
end