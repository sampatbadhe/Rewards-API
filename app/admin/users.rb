ActiveAdmin.register User do
  actions :index, :show

  filter :first_name
  filter :last_name
  filter :email

end
