class CategoryReasonSerializer < ActiveModel::Serializer
  attributes :id, :category_id, :category_name, :reason

  def category_id
    object.category.id
  end

  def category_name
    object.category.name
  end
end
