ActiveAdmin.register Event do
  menu :if => proc{ current_person.admin? }
  if proc{!current_person.admin? }
    actions :all, :except => [:destroy, :new, :edit]
  end

  filter :title
  filter :description
  filter :date

  index do

    column "Title" do |event|
      link_to event.title, admin_event_path(event)
    end

    column "Description" do |event|
      event.description
    end

    column "Date" do |event|
      event.date 
    end
  end

end