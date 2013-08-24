class ManagerSerializer < ActiveModel::Serializer

  attributes :id, :photo, :position, :office_hours, :email

  attribute :phone_number, key: :phone

  def name
    object.person.first_last_name
  end

  def facebook
    object.person.facebook_username
  end

  def twitter
    object.person.twitter_username
  end

  def linkedin
    object.person.linkedin_username
  end

  def website
    object.person.website_url
  end

  def photo
      object.person.avatar.square.medium.url
  end

end

