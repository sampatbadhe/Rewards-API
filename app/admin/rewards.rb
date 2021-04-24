ActiveAdmin.register Reward do
  actions :all, except: [:destroy]

  scope :all
  scope :pending, default: true
  scope :approved
  scope :rejected
  scope :withdrawn

  filter :user, as: :select, collection: User.all
  filter :activity_date
  filter :status, as: :select, collection: %i[pending approved rejected withdrawn]
  filter :category, as: :select, collection: Category.all

  permit_params :category_reason_id, :status

  show do
    attributes_table do
      row :user
      row :activity_date
      row :category
      row :category_reason
      row :comments
      row :status do |i|
        status_tag i.status
      end
    end
  end

  index do |reward|
    column :user
    column :activity_date
    column :category
    column :category_reason
    column :comments
    column :status do |i|
      status_tag i.status
    end
    actions
  end

  form(html: { autocomplete: :off }) do |f|
    f.inputs do
      if f.object.new_record?
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
        f.input :status, collection: %i[approved rejected pending]
      else
        f.input :user, input_html: { readonly: true, disabled: true }
        f.input :activity_date, input_html: { readonly: true, disabled: true }
        f.input :category, input_html: { readonly: true, disabled: true }
        if f.object.category.name.downcase == 'others'
          f.input :category_reason, collection: CategoryReason.where(category_id: f.object.category_id)
        else
          f.input :category_reason, input_html: { readonly: true, disabled: true }
        end
        f.input :comments, input_html: { readonly: true, disabled: true }
        if f.object.status.downcase == 'pending'
          f.input :status, collection: %i[approved rejected pending]
        else
          f.input :status, input_html: { readonly: true, disabled: true }
        end
      end
    end
    f.actions
  end
end
