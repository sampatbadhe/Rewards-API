ActiveAdmin.register CategoryReason do
  filter :category, as: :select, collection: Category.all

  permit_params :category_id, :reason, :badge

  show do
    attributes_table do
      row :category
      row :reason
      row :badge do |i|
        status_tag i.badge
      end
    end
  end

  index do
    column :category
    column :reason
    column :badge do |i|
      status_tag i.badge
    end
    actions
  end

  form(html: { autocomplete: :off }) do |f|
    f.inputs
    f.actions
  end
end
