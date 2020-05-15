# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# new_invoices = {
#   "brand_manager":"Kelly Mosciski",
#   "narration":"transition 24/365 schemas",
#   "invoice_date":"2017-01-20",
#   "amount":163082.0,
#   "customer_name":"Hahn, Smith and Toy",
#   "reference":"CES/OWB/16-17/01 176"
# }

# collections = {
#   "amount":-334650.0,
#   "reference":"CES/OWB/16-17/12 189",
#   "collection_date":"2017-01-20"
# }

new_collections = File.open(Rails.public_path.join("samples", "collections.json").to_s).read
new_collections = JSON.parse(new_collections)

new_invoices = File.open(Rails.public_path.join("samples", "new_invoices.json").to_s).read
new_invoices = JSON.parse(new_invoices)

new_invoices.each do |invoice_hash|
  Invoice.create(
    brand_manager: invoice_hash["brand_manager"],
    narration: invoice_hash["narration"],
    invoice_date: invoice_hash["invoice_date"],
    amount: invoice_hash["amount"],
    customer_name: invoice_hash["customer_name"],
    reference: invoice_hash["reference"],
    pending_amount: invoice_hash["amount"]
  )
end

new_collections.each do |collection_hash|
  inv = Invoice.find_by_reference(collection_hash["reference"])
  inv.collections.create(
    amount: collection_hash["amount"],
    reference: collection_hash["reference"],
    collection_date: collection_hash["collection_date"]
  ) if inv
end
