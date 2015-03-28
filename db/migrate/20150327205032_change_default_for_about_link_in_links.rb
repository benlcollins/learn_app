class ChangeDefaultForAboutLinkInLinks < ActiveRecord::Migration
  def change
  	change_column_default :links, :about_link, "No details given yet"
  end
end
