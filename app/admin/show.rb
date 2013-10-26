ActiveAdmin.register Show do
  scope_to :current_person, :unless => proc{ current_person.admin? }

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

    column "Hosts" do |show|
      raw(show.people.map{|host| link_to host.display_name, admin_person_path(host)}.to_sentence)
    end

    column "Slots" do |show|
      show.get_scheduled_slots.count 
    end
    
    column("Archived") {|show| status_tag((show.archived ? 'yes' : 'no'), (show.archived ? :error : :ok)) }
  end
  
  show do |show|
    attributes_table do
      row :title
      row :short_description  
      row :long_description 
      row("Genres") { show.genre_list}
    end
    panel "Social" do
      attributes_table_for show do
        row "Facebook Page" do
          show.facebook_page_username ? (link_to show.facebook_page_username, show.facebook_page_username) : nil
        end
        row :twitter_username do
          show.twitter_username ? (link_to show.twitter_username, "http://www.twitter.com/" + show.twitter_username) : nil
        end
        row :email do
          show.email ? (link_to show.email, "mailto:" + show.email) : nil
        end
        row :website_url do
          show.website_url ? (link_to show.website_url, show.website_url) : nil
        end
      end
    end
end
  sidebar "Avatar", :only => :show do
    image_tag(show.avatar.square.medium.url)
  end
  sidebar "Hosts", :only => :show do
    ul do
      for host in show.people do
        li link_to host.display_name, admin_person_path(host)
      end
      if show.people.size == 0
        "None"
      end
    end
  end

  sidebar "Slots", :only => :show do
    ul do
      for slot in show.get_scheduled_slots do
        li slot[:slot]
      end
      if show.get_scheduled_slots.size == 0
        "None"
      end
    end
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
        f.input :genres, as: :chosen
      end
      f.inputs "Avatar" do
        f.input :avatar
      end
      f.inputs "Hosts" do
      	f.input :people, as: :chosen
      end
      f.inputs "Slots" do
        f.has_many :slots, :allow_destroy => true, :heading => 'Slots', :new_record => true do |cf|
          cf.input :quarter
          cf.input :start_time 
          cf.input :end_time
          cf.input :monday
          cf.input :tuesday
          cf.input :wednesday
          cf.input :thursday
          cf.input :friday
          cf.input :saturday
          cf.input :sunday
          cf.input :_destroy, :as=>:boolean, :required => false, :label=>'Remove'
        end
      end
    end
end
