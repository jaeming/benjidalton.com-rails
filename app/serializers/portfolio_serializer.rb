class PortfolioSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :image, :link_to_src, :link_to_site
end
