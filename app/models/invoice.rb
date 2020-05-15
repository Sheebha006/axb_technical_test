	class Invoice < ApplicationRecord
		has_many :collections, dependent: :destroy	
		attr_accessor :from_page         
		attr_accessor :collection_amount

		def update_pending_amount		
			self.update(pending_amount: (self.amount - self.total_collection_amount))
		end	

		def total_collection_amount
			self.collections.try(:sum, :amount).try(:abs)
		end
		
	end
