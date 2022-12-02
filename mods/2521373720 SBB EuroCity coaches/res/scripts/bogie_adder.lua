--- GroupAdder
-- @module bogie_adder
--

local bogie_adder = {}

function bogie_adder.addBogieToModel (model, axleDefinitions, group_lods)
    for i = 0, #model.lods, 1 do
        if group_lods[i] then
            model.lods[i].node.children[#model.lods[i].node.children + 1] = group_lods[i];
            model.metadata.railVehicle.configs[i].axles = axleDefinitions[i]
        end
    end
    return model
end

return bogie_adder