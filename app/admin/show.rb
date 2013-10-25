ActiveAdmin.register Show do
  scope :all
  scope :active, :default => true
  scope :archived
  
  filter :title
  filter :people
  config.sort_order = "title_asc"

  index do
    column "Show" do |show|
      link_to show.title, admin_show_path(show)
    end
    column("Hosts") {|show| show.hosts_formatted}
    column("Archived") {|show| status_tag((show.archived ? 'yes' : 'no'), (show.archived ? :error : :ok)) }
  end

  form do |f|
      f.inputs "Show" do
        f.input :title, :as => :title
        f.input :short_description
        f.input :long_description
      end
      f.inputs "Social" do
        f.input :facebook_page_username
        f.input :twitter_username
        f.input :email
        f.input :website_url
      end
      f.inputs "Genres" do
        f.input :genre_list
      end
      f.inputs "Avatar" do
        f.input :avatar
      end
      f.inputs "Hosts" do
      	f.input :people, as: :chosen
      end
      f.actions
    end
end
