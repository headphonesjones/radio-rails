ActiveAdmin.register Show do
  form do |f|
      f.inputs "ID" do
        f.input :id
      end
      f.inputs "Title" do
        f.input :title
      end
      f.inputs "Short Description" do
        f.input :short_description
      end
      f.inputs "Long Description" do
        f.input :long_description
      end
      f.inputs "Facebook Page Username" do
        f.input :facebook_page_username
      end
      f.inputs "Twitter Username" do
        f.input :twitter_username
      end
      f.inputs "Email" do
        f.input :email
      end
      f.inputs "Website URL" do
        f.input :website_url
      end
      f.inputs "Facebook Page Username" do
        f.input :facebook_page_username
      end
      f.inputs "Genre List" do
        f.input :genre_list
      end
      f.inputs "Avatar" do
        f.input :avatar
      end
      f.inputs "Remove Avatar URL" do
        f.input :remote_avatar_url
      end
      f.inputs "Hosts" do
      	f.has_many :person
      end
      f.actions
    end
end
