class AddDefaultToAboutLinkInLinks < ActiveRecord::Migration
  def change
  	change_column_default :links, :about_link, "No details given"
  end
end
