class PersonSerializer < ActiveModel::Serializer

  attributes :id, :photo_medium, :major, :bio, :influences, :class_year, :email, :class_year, :major, :hometown

  attribute :first_last_name, key: :name
  attribute :facebook_username, key: :facebook
  attribute :twitter_username, key: :twitter
  attribute :linkedin_username, key: :linkedin
  attribute :website_url, key: :website

  has_many :shows, serializer: ShowPersonSerializer

    def photo_medium
        object.avatar.square.medium.url
    end

end
