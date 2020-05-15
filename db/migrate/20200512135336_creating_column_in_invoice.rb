class CreatingColumnInInvoice < ActiveRecord::Migration[5.2]
  def change
  	add_column :invoices, :reference_name, :string  	
  end
end
