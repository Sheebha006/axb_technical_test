class AddingColumnToInvoice < ActiveRecord::Migration[5.2]
  def change
  	add_column :invoices, :pending_amount, :float
  end
end
