module GlobalHelper

	@@permission = nil

	# ==== Session ============================================

	def logged_user
		session[:auth]
	end

	def logged_user_id
		return logged_user['id']
	end

	def logged_user_role
		return logged_user['role']
	end

	def logged_company_id
		return logged_user['company_id']
	end
	# ==== Roles ============================================

	def permissions 
		{
			pw: {
				users: {
					allowed: [0, 1, 2]
				},
				articles: {
					allowed: [:all]
				},
				posts: {
					status: {
						publish: [0 ,1, 2],
						trash: [0 ,1, 2]
					},
					allowed: [:all]
				},
				members: {
					allowed: [0, 1]	
				},
				categories: {
					allowed: [0 ,1]
				},
				allowed: [:all]
			}
		}
	end

	def check_authorization
		if logged_user.nil?
  			redirect_to pw_path
  			return
		end

		permission = permissions.stringify_keys

		params[:controller].split('/').each do |key|
			if permission.has_key?(key)
				permission = permission[key].stringify_keys
			end
		end

		@@permission = permission.deep_symbolize_keys

		unless @@permission[:allowed] == [:all]
			unless @@permission[:allowed].include?(roles[logged_user_role])
				redirect_to pw_dashboard_path
  				return
  			end
		end
	end

	def super_and_admin_only
		unless display_on_super_and_admin
			redirect_to pw_dashboard_path
		end
	end

	def super_and_admin_roles
		return roles_include(roles.keys[0..1])
	end

	def roles_include(allowed_roles)
		return allowed_roles.include?(logged_user_role)
	end

	def roles 
		User.roles
	end

	# ==== Functions ============================================

	def insert(hash, path, value)
  		head, *tail = path
  		
  		if tail.empty?
    		hash.merge(head => nil)
  		else
    		h = insert(hash[head] || {}, tail, nil)
    		hash.merge(head => hash.has_key?(head) ? hash[head].merge(h) : h)
		end
	end

end
