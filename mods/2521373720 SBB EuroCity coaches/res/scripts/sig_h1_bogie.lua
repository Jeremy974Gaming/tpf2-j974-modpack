--- Sig H1 Bogie
-- @module sig_h1_bogie
--

local bogieAdder = require "bogie_adder"

local sig_h1_bogie = {}
local axleDefinitions= {{ "vehicle/waggon/sig_h1/sig_h1_axle_lod0.msh", },}

local function getBogieLods (transf)
    return {
        {
            children = {
                {
                    materials = { "vehicle/waggon/sig_h1/sig_h1.mtl", },
                    mesh = "vehicle/waggon/sig_h1/sig_h1_axle_lod0.msh",
                    name = "MSH_sig_h1_axle_lod0_1",
                    transf = { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 1.25, 0, 0.450724, 1, },
                },
                {
                    materials = { "vehicle/waggon/sig_h1/sig_h1.mtl", },
                    mesh = "vehicle/waggon/sig_h1/sig_h1_axle_lod0.msh",
                    name = "MSH_sig_h1_axle_lod0_2",
                    transf = { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, -1.25, 0, 0.450724, 1, },
                },
                {
                    materials = { "vehicle/waggon/sig_h1/sig_h1.mtl", },
                    mesh = "vehicle/waggon/sig_h1/sig_h1_bogie_lod0.msh",
                    name = "MSH_sig_h1_bogie_lod0_1",
                    transf = { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, -0, -0, 0.758132, 1, },
                },
            },
            name = "sig_h1_door_grp_3",
            transf = transf,
        },
        {
            children = {
                {
                    materials = { "vehicle/waggon/sig_h1/sig_h1.mtl", },
                    mesh = "vehicle/waggon/sig_h1/sig_h1_axle_lod1.msh",
                    name = "MSH_sig_h1_axle_lod0_1",
                    transf = { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 1.25, 0, 0.450724, 1, },
                },
                {
                    materials = { "vehicle/waggon/sig_h1/sig_h1.mtl", },
                    mesh = "vehicle/waggon/sig_h1/sig_h1_axle_lod1.msh",
                    name = "MSH_sig_h1_axle_lod0_2",
                    transf = { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, -1.25, 0, 0.450724, 1, },
                },
                {
                    materials = { "vehicle/waggon/sig_h1/sig_h1.mtl", },
                    mesh = "vehicle/waggon/sig_h1/sig_h1_bogie_lod1.msh",
                    name = "MSH_sig_h1_bogie_lod0_1",
                    transf = { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, -0, -0, 0.758132, 1, },
                },
            },
            name = "sig_h1_door_grp_3",
            transf = transf,
        },
    }
end

function sig_h1_bogie.addBogiesToModel (model,  ...)
    local args = {...}
    local addedModel = model
    for key, transf in ipairs(args)     do
        addedModel= bogieAdder.addBogieToModel(addedModel,axleDefinitions, getBogieLods(transf))
    end
    return addedModel
end

return sig_h1_bogie