class Category < ActiveRecord::Base

	enum parent: [:general, :post, :article]
	
	before_save :save_default

	def save_default
		self.slug = self.name.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
	end

	def self.default
		"general"
	end

	def self.find_by_post
		general = Category.new

		general.name = default.titlecase
		general.slug = default
		general.id = 0

		categories = Category.post
		categories.unshift(general)

		# Category.post.each do |category|
      	# 	categories[category.id] = { name: category.name, slug: category.slug }
    	# end

    	return categories
	end

end
