class ShowListSerializer < ActiveModel::Serializer
  attributes :id, :title, :photo_thumb
  attribute :genres_formatted, key: :genres
  has_many :people, serializer: PersonListSerializer, key: :hosts
    def photo_thumb
        object.avatar.square.thumb.url
    end
end
