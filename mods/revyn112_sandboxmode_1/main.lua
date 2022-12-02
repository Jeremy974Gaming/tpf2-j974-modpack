local function metadataHandler(fileName, data)
  if data.metadata.cost and data.metadata.cost.price then
    data.metadata.cost.price = 0
  end

  if data.metadata.availability and data.metadata.availability.yearFrom then
    data.metadata.availability.yearFrom = 0
  end
  
  if data.metadata.availability and data.metadata.availability.yearTo then
    data.metadata.availability.yearTo = 0
  end  
  
  if data.metadata.maintenance and data.metadata.maintenance.runningCosts then
    data.metadata.maintenance.runningCosts = 0
  end
  
  if data.metadata.maintenance and data.metadata.maintenance.lifespan then
    data.metadata.maintenance.lifespan = 0
  end
  
  return data
end

local function dataHandler(fileName, data)
  if data.cost then
    data.cost = 0
  end
  
  if data.yearFrom then
    data.yearFrom = 0
  end
  
  if data.yearTo then
    data.yearTo = 0
  end
  
  return data
end

local function stationHandler(fileName, data)
  if data.buildingCosts then
    data.buildingCosts = 0
  end
  
  if data.platformCosts then
    data.platformCosts = 0
  end
  
  if data.yearFrom then
    data.yearFrom = 0
  end
  
  if data.yearTo then
    data.yearTo = 0
  end
  
  return data
end

local costs = game.config.costs
costs.terrainRaise           = 0
costs.terrainLower           = 0
costs.railroadTrack          = 0
costs.railroadHighSpeedTrack = 0
costs.railroadCatenary       = 0
costs.railroadSwitch         = 0
costs.railroadBridge         = 0
costs.railroadBridgeVol      = 0
costs.railroadTunnel         = 0
costs.railroadTunnelLen      = 0
costs.roadBusLane            = 0
costs.roadTramLane           = 0

local function bridgeHandler  (fileName,data) return dataHandler(fileName,data) end
local function crossingHandler(fileName,data) return dataHandler(fileName,data) end
local function streetHandler  (fileName,data) return dataHandler(fileName,data) end
local function tunnelHandler  (fileName,data) return dataHandler(fileName,data) end

addModifier( "loadModel",            metadataHandler )
addModifier( "loadBridge",           bridgeHandler   )
addModifier( "loadRailroadCrossing", crossingHandler )
addModifier( "loadStreet",           streetHandler   )
addModifier( "loadTrainStation",     stationHandler  )
addModifier( "loadTunnel",           tunnelHandler   )