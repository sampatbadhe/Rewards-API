ActiveAdmin.register Reward do
  actions :all, except: [:destroy]

  scope :all
  scope :pending, default: true
  scope :approved
  scope :rejected
  scope :withdrawn

  filter :user, as: :select, collection: User.all
  filter :activity_date
  filter :status, as: :select, collection: Reward.statuses #%i[pending approved rejected withdrawn]
  filter :category, as: :select, collection: Category.all

  permit_params :user_id, :activity_date, :category_id, :category_reason_id, :comments, :status

  show do
    attributes_table do
      row :user
      row :activity_date
      row :category
      row :category_reason
      row :badge do |reward|
        status_tag(reward.category_reason.badge)
      end
      row :comments
      row :status do |i|
        status_tag i.status
      end
    end
  end

  index do
    column :user
    column :activity_date
    column :category
    column :category_reason do |reward|
      if reward.category.name.downcase == "others"
        "*#{reward.category_reason.name}"
      else
        reward.category_reason.name
      end
    end
    column :badge do |reward|
      status_tag(reward.category_reason.badge)
    end
    column :comments
    tag_column :status
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

  member_action :approve, method: :put do
    resource.approved!
    redirect_to resource_path, notice: "Approved!"
  end

  member_action :reject, method: :put do
    resource.rejected!
    redirect_to resource_path, notice: "Rejected!"
  end

  member_action :reset, method: :put do
    resource.pending!
    redirect_to resource_path, notice: "Reset!"
  end

  action_item :approve, only: :show do
    link_to 'Approve!', approve_admin_reward_path(resource), method: :put if resource.pending?
  end

  action_item :reject, only: :show do
    link_to 'Reject!', reject_admin_reward_path(resource), method: :put if resource.pending?
  end

  action_item :reset, only: :show do
    link_to 'Reset!', reset_admin_reward_path(resource), method: :put if resource.approved? || resource.rejected?
  end
end
