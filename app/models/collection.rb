	class Collection < ApplicationRecord
	  belongs_to :invoice
	  after_create do
	    self.invoice.update_pending_amount
	  end
	end
