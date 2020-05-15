class ChangingRefColumns < ActiveRecord::Migration[5.2]
  def change
  	rename_column :collections, :reference_name, :reference
  	rename_column :invoices, :reference_name, :reference
  end
end
