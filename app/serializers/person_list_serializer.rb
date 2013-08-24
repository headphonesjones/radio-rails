class PersonListSerializer < ActiveModel::Serializer
  attributes :id, :photo_thumb
  attribute :first_last_name, key: :name
  attribute :shows_formatted, key: :shows

	def photo_thumb
	    object.avatar.square.thumb.url
	end
end
