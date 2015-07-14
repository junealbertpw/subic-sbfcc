class Article < ActiveRecord::Base

	enum status: [ :draft, :review, :trash, :publish]

  has_attached_file :cover, :styles => { :medium => "600x600>", :small => "300x300", :thumb => "100x100>" } # , :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :cover, :content_type => /\Aimage\/.*\Z/

  before_save :save_default

   def save_default
    self.slug = self.title.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
    self.published_at = Time.new

    self.company_id = self.company_id == nil ? 0 : self.company_id
    self.category_id = self.category_id == nil ? 0 : self.category_id

    if self.status == "draft"
      self.published_by = nil
      self.published_at = nil
    end
  end

  def self.by_company_id(company_id)
    if company_id == 0
      return self.all
    end

    return self.where(["company_id = %s", company_id])
  end

end
