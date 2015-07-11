module ApplicationHelper

	include GlobalHelper
	
	@@partials = "pw/partials/"

	def name
		"SBFCC"
	end

	def logo_text
		"Subic Bay Freeport <br/> Chamber of Commerce "
	end

	def format_date(datetime, format)
		datetime.strftime(format)
	end

	def format_post_published_date(datetime)
		datetime.day.ordinalize + datetime.strftime(" %B, %Y ")
	end

	# ==== Member ============================================

	def member_by_types(businesses)
		@members = {}

		Company.member_types.each do |x, y|
      		remaining = []
      		members = []

      		businesses.each do |business|
        		if business.member_type == x
          			members.push(business)
          			next
        		end

          		remaining.push(business)
        	end

      		businesses = remaining
      		@members[x] = members
      	end

      	return @members
	end

	def member_type_text_by_enum(enum)
		member_type = Company.member_types.select{ |x, y| y == enum } 
		return member_type.keys[0].humanize
	end

	# ==== Post ============================================

	def post_default_category
		"general"
	end

	def post_category_path(slug)
		[blog_path, slug == nil ? post_default_category : slug].join("/")
	end

	def post_slug_path(category_slug, post_slug)
		[post_category_path(category_slug),  post_slug].join("/")
	end

	def stylesheets(*files)
		content_for(:stylesheets) { stylesheet_link_tag(*files) }
	end

	def javascripts(*files)
		content_for(:javascripts) { javascript_include_tag(*files) }
	end

	def body_class(class_name)
		content_for(:body_class) { class_name }
	end

	# ==== Pages ============================================

	def partials 
		{
			:header => @@partials + "header",
			:nav => @@partials + "nav",
			:footer => @@partials + "footer",
			:form => {
				:member => @@partials + "form_member",
				:article => @@partials + "form_article",
				:post => @@partials + "form_post"
			},
			:posts => {
				:category_selection => @@partials + "category_selection"
			}
		}
	end

end
