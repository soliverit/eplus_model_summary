require "./lib/eplus_object.rb"
class Wall < EplusObject
	def initialize data
		super data
		@windows	= {}
	end
	def addWindow window
		@windows[window[:ID]]	= window
	end
end