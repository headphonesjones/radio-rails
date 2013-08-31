class ManagerSerializer < ActiveModel::Serializer

  attributes :id, :photo, :position, :office_hours, :email,

  attribute :phone_number, key: :phone

  attribute :facebook_username, key: :facebook

  attribute :twitter_username, key: :twitter

  attribute :linkedin_username, key: :linkedin

  attribute :first_last_name, key: :name

  attribute :website_url, key: :website

  def photo
      object.person.avatar.square.medium.url
  end

end

