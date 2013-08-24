class ScheduleSerializer < ActiveModel::Serializer
  attributes :start_time, :end_time
  attribute :get_days_airing, key: :days
  has_one :show, serializer: ShowScheduleSerializer
  def start_time
  	object.start_time.strftime("%I:%M%p %Z")
  end

  def end_time
  	object.end_time.strftime("%I:%M%p %Z")
  end 
end