class ManagerSerializer < ActiveModel::Serializer

  attributes :id, :photo, :position, :office_hours, :email, :name, :twitter,

  attribute :phone_number, key: :phone


  def facebook
    object.person.facebook_username
  end 

  def name
    object.person.first_last_name
  end

  def linkedin
    object.person.first_last_name
  end

  def twitter
    object.person.twitter_username
  end 

  def website
    object.person.website_url
  end

  def photo
      object.person.avatar.square.medium.url
  end

end

