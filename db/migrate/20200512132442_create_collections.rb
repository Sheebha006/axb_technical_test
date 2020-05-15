class CreateCollections < ActiveRecord::Migration[5.2]
  def change
    create_table :collections do |t|
      t.float :amount
      t.string :reference_name
      t.date :collection_date
      t.belongs_to :invoice, foreign_key: true

      t.timestamps
    end
  end
end
