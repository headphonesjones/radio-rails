ActiveAdmin.register Person do
  config.sort_order = "first_name_asc"
  

  scope :all
  scope :active, :default => true
  scope :archived
 
  filter :first_name_or_last_name_contains, :as => :string, :label => 'Name'
  filter :shows

  index do
    column "Name" do |person|
      link_to person.display_name, admin_person_path(person)
    end
    column("Shows") {|person| person.shows_formatted}
    #column("Manager") {|person| status_tag((person.admin ? 'yes' : 'no'), (person.archived ? :error : :ok)) }
    column("Admin") {|person| status_tag((person.admin ? 'yes' : 'no'), (person.archived ? :error : :ok)) }
    column("Archived") {|person| status_tag((person.archived ? 'yes' : 'no'), (person.archived ? :error : :ok)) }

  end
end
