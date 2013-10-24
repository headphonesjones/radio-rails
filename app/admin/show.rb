ActiveAdmin.register Show do
  index do
    column :title
    column "Hosts", :people do |post|
      link_to post.title, admin_post_path(post)
    column :archived
  end

  form do |f|
      f.inputs "Show" do
        f.input :title
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
