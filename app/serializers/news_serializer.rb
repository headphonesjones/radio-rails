class NewsSerializer < ActiveModel::Serializer
  attributes :id, :headline, :author, :content, :published_at

  def content
  	RDiscount.new(object.content, :smart, :filter_html).to_html.html_safe
  end 

  def author
  	object.person.first_last_name
  end

end
