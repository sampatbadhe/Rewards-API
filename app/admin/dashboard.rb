ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    div class: "blank_slate_container", id: "dashboard_default_message" do
      span class: "blank_slate" do
        span "Welcome to iHero Admin"
      end
    end

    columns do
      column do
        panel 'Top 5 Heros of last Month' do
          heros = User.heroes_of_the_last_month.limit(5)
          table_for heros do |user|
            column 'Name', &:full_name
            column 'Total Badges', &:badges_count
            column 'Gold', &:gold
            column 'Silver', &:silver
            column 'Bronze', &:bronze
          end
        end
      end

      column do
        panel 'Overall Top 5 Heros' do
          heros = User.top_contributors_by_rank.limit(5)
          table_for heros do |user|
            column 'Name', &:full_name
            column 'Total Badges', &:badges_count
            column 'Gold', &:gold
            column 'Silver', &:silver
            column 'Bronze', &:bronze
          end
        end
      end
    end
  end # content
end
