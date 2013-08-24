class EventSerializer < ActiveModel::Serializer
  attributes :location, :title, :first_line, :second_line
  
end
