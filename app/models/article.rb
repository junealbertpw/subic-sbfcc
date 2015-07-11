class Article < ActiveRecord::Base

	enum status: [ :draft, :review, :trash, :publish]

  before_create :set_default
  before_save :save_slug
  before_save :save_publish

  def set_default
    self.created_by = 0
  end

	def save_slug
    self.slug = self.title.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
  end

  def save_publish
    if self.status == "publish"
      self.published_at = Time.new
      self.published_by = 0
    end
  end

end
