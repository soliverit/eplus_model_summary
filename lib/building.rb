require "./lib/regression_data_set.rb"
require "./lib/zone.rb"
require "./lib/wall.rb"
require "./lib/window.rb"
class Building
	def initialize projectPath
		@path			= projectPath
		##
		# Data from Eplus
		##
		@coolingData	= parseData "cooling"
		@doorData		= parseData "doors"
		@endUseData		= parseData "end_uses"
		@heatingData	= parseData "heating"
		@lightingData	= parseData "lighting"
		@wallData		= parseData "walls"
		@windowData		= parseData "windows"
		@zoneData		= parseData "zones"
		
		@zones			= {}
		buildModel
	end
	def parseData filename
		RegressionDataSet.parseGemCSV @path + "/" + filename + ".csv"
	end
	def buildModel
		##
		# Zones and surfaces
		##
		@zoneData.each{|zoneData|
			zone = Zone.new zoneData
			@zones[zone[:ID]]	= zone
			@wallData.each{|wallData|
				zoneID	= wallData[:ID].split("_").first.to_i
				if zoneID == zone[:ID]
					wall	= Wall.new(wallData)
					zone.addWall wall
					
					@windowData.each{|windowData|
						wallID	= windowData[:ID].split("_")[0,5].join("_")
						if wall[:ID] == wallID
							wall.addWindow Window.new(windowData)
						end
					}
					@doorData.each{|doorData|
						wallID	= doorData[:ID].split("_")[0,5].join("_")
						if wall[:ID] == wallID
						puts doorData
							wall.addWindow Window.new(doorData)
						end
					}
				end
			}
		}
		##
		# Consumer stuff
		##

		@lightingData.each{|lighting|
			@zones[lighting[:Zone]].setLighting lighting
		}
		@heatingData.each{|heating|
			puts heating
			@zones[heating[:ID]].setHeating heating
		}
		@coolingData.each{|cooling|
			@zones[cooling[:ID]].setCooling cooling
		}
	end
end