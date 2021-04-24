ActiveAdmin.register Reward do
  scope :all
  scope :pending, default: true
  scope :approved
  scope :rejected
  scope :withdrawn

  filter :user, as: :select, collection: User.all
  filter :activity_date
  filter :status, as: :select, collection: %i[pending approved rejected withdrawn]
  filter :category, as: :select, collection: Category.all

  permit_params :user_id, :activity_date, :category_id, :category_reason_id, :comments, :status

  show do
    attributes_table do
      row :user
      row :activity_date
      row :category
      row :category_reason
      row :comments
      tag_row :status
    end
  end

  index do
    column :user
    column :activity_date
    column :category
    column :category_reason
    column :comments
    tag_column :status, interactive: true
    actions
  end

  form(html: { autocomplete: :off }) do |f|
    f.inputs do
      f.input :user
      f.input :activity_date, as: :datepicker,
              datepicker_options: {
                min_date: 1.month.ago.to_date,
                max_date: "+0D"
              }
      f.input :category_id, as: :nested_select,
              level_1: { attribute: :category_id, collection: Category.all },
              level_2: { attribute: :category_reason_id, collection: CategoryReason.all }
      f.input :comments
    end
    f.actions
  end
end
