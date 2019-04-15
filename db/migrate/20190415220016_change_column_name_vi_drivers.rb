class ChangeColumnNameViDrivers < ActiveRecord::Migration[5.2]
  def change
    rename_column :drivers, :vi, :vin
  end
end
