class Company < ActiveRecord::Base

	enum member_type: [:golden_eagle, :emerald_tier, :silver_circle]
	enum status: [:draft, :activate, :block]

	belongs_to :users

	has_many :users, dependent: :destroy

	accepts_nested_attributes_for :users, allow_destroy: true

	has_attached_file :cover, :styles => { :medium => "180x180>", :small => "120x120", :thumb => "60x60>" } # , :default_url => "/images/:style/missing.png"
  	validates_attachment_content_type :cover, :content_type => /\Aimage\/.*\Z/
  	# validates :image, :attachment_presence => true

	before_save :save_default_values

	def save_default_values
		self.member_type = self.member_type == nil ? 0 : self.member_type
		self.slug = self.name.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
	end
end
