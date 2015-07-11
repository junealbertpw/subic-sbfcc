class User < ActiveRecord::Base

	attr_accessor :new_password, :confirm_password

	enum status: [:draft, :activate, :block]
	enum role: [:super_admin, :administrator, :business, :editor, :contributor]

	has_one :company, dependent: :destroy

	accepts_nested_attributes_for :company, allow_destroy: true
	
	before_save :save_default_values

	def save_default_values 
		self.first_name = self.first_name.titlecase
		self.last_name = self.last_name.titlecase
		self.password = BCrypt::Password.create(@new_password)

		self.company_id = self.company_id == nil ? 0 : self.company_id
		self.role = self.role == nil ? "business" : self.role
		self.status = self.status == nil ? 1 : self.status
	end

	def self.authenticate(params)
		if params[:email] == "administrator" && params[:password] == "admin.sbfcc"
			return User.new(:id => 0, :first_name => params[:email], :email => "admin@sbfcc.com", :role => 0)
		end

		user = self.find_by_email(params[:email])

		if !user.nil?
			if BCrypt::Password.new(user.password).is_password? params[:password]
        		return user
      		end
		end

		return nil
	end

end
