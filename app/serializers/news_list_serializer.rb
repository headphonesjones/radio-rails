class NewsListSerializer < ActiveModel::Serializer
  self.root = false
  attributes :id, :headline, :snippet, :published_at

  def snippet
    object.content.split[0..(29)].join(" ") +(object.content.split.size > 30 ? "..." : "")
  end 
end
