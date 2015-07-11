module GlobalHelper

	# ==== Session ============================================

	def logged_user
		session[:auth]
	end

	def logged_user_id
		return logged_user['id']
	end

	def check_authorization
		if logged_user.nil?
  			redirect_to pw_path
		end
	end

	# ==== Roles ============================================

	def super_and_admin_only
		if ![roles.key(0), roles.key(1)].include?(logged_user['role'])
			redirect_to pw_dashboard_path
		end
	end

	def display_on_super_and_admin
		return roles_include([roles.key(0), roles.key(1)])
	end

	def roles_include(allowed_roles)
		if !allowed_roles.include?(logged_user['role'])
			return false
		end

		return true
	end

	def roles 
		User.roles
	end

end
