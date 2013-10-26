class ChangeEvents < ActiveRecord::Migration
  def change
  	remove_column :events, :first_line
  	remove_column :events, :second_line
	  remove_column :events, :location
    add_column :events, :date, :date
  end
end
