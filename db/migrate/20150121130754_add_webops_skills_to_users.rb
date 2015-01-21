class AddWebopsSkillsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :webops_skill, :text
  end
end
