class ShowScheduleSerializer < ActiveModel::Serializer
  attributes :id, :title, :photo_small, :short_description
  attribute :genres_formatted, key: :genres
  has_many :people, serializer: PersonListSerializer, key: :hosts

    def photo_small
        object.avatar.square.small.url
    end
end
