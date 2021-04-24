ActiveAdmin.register Category do
  permit_params :name

  show do
    attributes_table do
      row :name
    end
  end

  index do
    column :name
    actions
  end

  form(html: { autocomplete: :off }) do |f|
    f.inputs
    f.actions
  end
end
