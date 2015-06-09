class RemoveCoordinatesFromPlace < ActiveRecord::Migration
  def change
    remove_column :places, :latitude, :decimal
    remove_column :places, :longitude, :decimal
  end
end
