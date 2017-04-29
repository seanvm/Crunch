class Issue < ApplicationRecord
	def sla_countdown
		# binding.pry
		SlaTimeService.call(self.severity,self.created_at)
	end
end
