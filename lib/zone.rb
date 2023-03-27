require "active_support"
require "./lib/eplus_object.rb"
class Zone < EplusObject
	attr_reader :lighting, :heating, :cooling, :walls
	def initialize data 
		super data
		@walls	= {}
	end
	def setLighting lighting
		@lighting	= lighting
	end
	def setHeating heating
		@lighting	= heating
	end
	def setCooling cooling
		@lighting	= cooling
	end
	def addWall wall
		@walls[wall[:ID]] = wall
	end
end