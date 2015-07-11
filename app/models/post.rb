class Post < ActiveRecord::Base

  include GlobalHelper

  attr_accessor :user

  enum status: [:draft, :review, :publish, :trash]

  has_attached_file :cover, :styles => { :medium => "600x600>", :small => "300x300", :thumb => "100x100>" } # , :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :cover, :content_type => /\Aimage\/.*\Z/
  # validates :image, :attachment_presence => true

  before_save :save_default

  # has_attached_file :image,
  # :default_url => '/images/foto.jpg',
  # :default_style => :medium,
  # :use_timestamp => false,
  # :url => '/system/:access_token/foto_:style.:extension',
  # :path => ':rails_root/public:url',
  # :styles => { :medium => "470x320", :small => "162x107" }

  # validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  def save_default
    self.slug = self.title.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
    self.published_at = Time.new
    
    if self.category_id.nil?
      self.category_id = 0
    end

    if self.status == "draft"
      self.published_by = nil
      self.published_at = nil
    end
  end

  def self.latest_publish_with_limit(limit)
    return Post.select("posts.*, categories.name as category_name, categories.slug as category_slug, 
                        companies.id as company_id, companies.name as company_name")
                .joins("left outer join categories on categories.id = posts.category_id")
                .joins("left outer join companies on companies.user_id = posts.user_id")
                .order("published_at DESC")
                .limit(limit)
  end

  def self.by_user(user)
    if display_on_super_and_admin(user['role'])
      return self.all.order('id desc')
    end
  end

end
