class AddIndexToRefereceInInvoice < ActiveRecord::Migration[5.2]
  def change
    add_index :invoices, :reference, unique: true
  end
end
