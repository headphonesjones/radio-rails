class ShowSerializer < ActiveModel::Serializer
    attributes :id, :title, :genres, :long_description, :email, :photo_medium
    attribute :facebook_page_username, key: :facebook
    attribute :twitter_username, key: :twitter
    attribute :website_url, key: :website
    attribute :genres_formatted, key: :genres
    attribute :get_scheduled_slots, key: :scheduled_slots
    attribute :get_podcasts, key: :podcasts

    has_many :people, serializer: PersonListSerializer, key: :hosts

    def photo_medium
        object.avatar.square.medium.url
    end

end