ActiveAdmin.register Person do

  scope_to :current_person, :unless => proc{ current_person.admin? }

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
    column("Admin") {|person| status_tag((person.admin ? 'yes' : 'no'), (person.admin ? :error : :ok)) }
    column("Archived") {|person| status_tag((person.archived ? 'yes' : 'no'), (person.archived ? :error : :ok)) }

  end

  form do |f|
      f.inputs "Bio" do
        f.input :first_name
        f.input :last_name
        f.input :nickname
        f.input :bio, :input_html => { :rows => 10 }
        f.input :influences, :input_html => { :rows => 10 }
        f.input :major
        f.input :class_year
        f.input :hometown
      end

      f.inputs "Social" do
        f.input :email
        f.input :phone
        f.input :facebook_username
        f.input :linkedin_username
        f.input :twitter_username
        f.input :tumblr_username
        f.input :website_url
      end

      f.inputs "Interests" do
        f.input :favorite_artists, :input_html => { :rows => 3 }
        f.input :favorite_films, :input_html => { :rows => 3 }
        f.input :favorite_tv_shows, :input_html => { :rows => 3 }
      end

      f.inputs "Avatar" do
        f.input :avatar
      end


      if current_person.admin?  
        f.inputs "Admin" do
          f.input :archived
        end

      end
      f.actions

    end
end
