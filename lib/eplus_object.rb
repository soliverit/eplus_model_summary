class EplusObject
	def initialize data
		@data	= data
	end
	def []key
		@data[key.to_sym]
	end
end