class CreateInvoices < ActiveRecord::Migration[5.2]
  def change
    create_table :invoices do |t|
      t.string :brand_manager
      t.string :narration
      t.date :invoice_date
      t.float :amount
      t.string :customer_name

      t.timestamps
    end
  end
end
