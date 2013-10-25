class Show < ActiveRecord::Base
  attr_accessible :title, :short_description, :long_description, :facebook_page_username, :twitter_username, :email, :website_url, :attachments_attributes, :avatar, :remove_avatar, :avatar_cache, :remote_avatar_url, :genre_list, :hostings_attributes

  scope :active, where("shows.archived IS FALSE")
  scope :archived, where("shows.archived IS TRUE")


  # relationships
  has_many :hostings, :dependent => :destroy
  has_many :people, :through => :hostings
  has_many :slots
  has_many :attachments, :as => :attachable, :dependent => :destroy
  accepts_nested_attributes_for :attachments, :allow_destroy => true
  accepts_nested_attributes_for :hostings, :allow_destroy => true
  acts_as_taggable_on :genres

  # callbacks
  before_save :blanks_to_nils  

  mount_uploader :avatar, AvatarUploader
  
  validates :title, :presence => true, :uniqueness => true

  def convert_markdown(input)
    markdown = RDiscount.new(input)
    return markdown.to_html
  end

  def get_hosts 
    hosts = Array.new
    self.people.each do |person|
      hosts.push person 
    end
    return hosts
  end

  def hosts_formatted
    self.people.map(&:display_name).to_sentence
  end

  def genres_formatted
    self.genres.map(&:name).map(&:capitalize).to_sentence
  end

  def get_podcasts 
    attachments = Array.new
    self.attachments.each do |attachment|
      x = {:id => attachment.id, :title => attachment.title, :description => attachment.description, :contributors => attachment.contributors + " // " + attachment.description, :file_url => attachment.file.url}
      attachments.push x
    end
    return attachments
  end

  def get_scheduled_slots
    scheduled_slots = Array.new
    self.slots.each do |slot|
      if slot.quarter === Settings.active_schedule
        scheduled_slots.push :slot => slot.time_days
      end
    end
    return scheduled_slots
  end
  
  def blanks_to_nils
     self.short_description = nil if self.short_description.blank?
     self.long_description = nil if self.long_description.blank?
     self.facebook_page_username = nil if self.facebook_page_username.blank?
     self.twitter_username = nil if self.twitter_username.blank?
     self.email = nil if self.email.blank?
     self.website_url = nil if self.website_url.blank?
  end
  
  def as_json(options={})
       {id: self.id,
        title: self.title,
        genres: self.genre_list.each {|word| word.capitalize! }.join(", "),
        hosts: get_hosts,
        scheduled_slots: get_scheduled_slots,
        short_description: self.short_description || '',
        long_description: self.long_description || '',
        facebook: self.facebook_page_username || '',
        twitter: self.twitter_username || '',
        email: self.email || '',
        website: self.website_url || '',
        show_url: "http://radio.depaul.edu/show?id=#{self.id}",
        podcasts: get_podcasts,
        photo_thumb: self.avatar.square.thumb.url,
        photo_small: self.avatar.square.small.url,
        photo_medium: self.avatar.square.medium.url,
        photo_large: self.avatar.square.large.url }
   end
end
