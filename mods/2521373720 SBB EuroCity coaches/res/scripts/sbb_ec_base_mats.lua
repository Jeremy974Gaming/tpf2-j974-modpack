--- sbb_ec_base_mat
-- @module sbb_ec_base_mats
--

local sbb_ec_base_mats = {}

local dirt_rust = {
    age = 0,
    dirtColor = { 0.321568608284, 0.29833108186722, 0.24842751026154, },
    dirtOpacity = 0.050000000745058,
    dirtScale = 0.15000000596046,
    rustColor = { 0.3254901766777, 0.23894807696342, 0.18125334382057, },
    rustOpacity = 0.20999999344349,
    rustScale = 1,
};

local cblend = {
    albedoScales = { 0.60000002384186, },
    colors = {
        { 1, 1, 1, },
    },
}

function sbb_ec_base_mats.exterior_mat (name_albedo, name_mgao)
    return {
        order = 0,
        params = {
            albedo_scale = {
                albedoScale = { 1, 1, 1, },
            },
            color_blend = cblend,
            dirt_rust = dirt_rust,
            fade_out_range = {
                fadeOutEndDist = 20000,
                fadeOutStartDist = 10000,
            },
            map_albedo = {
                fileName = "models/vehicle/waggon/sbb_ec/" .. name_albedo .. "_albedo.dds",
                type = "TWOD",
                wrapS = "REPEAT",
                wrapT = "REPEAT",
            },
            map_cblend_dirt_rust = {
                fileName = "models/vehicle/waggon/sbb_ec/" .. name_albedo .. "_cblend.dds",
                type = "TWOD",
            },
            map_dirt = {
                fileName = "models/vehicle/dirt_albedo.dds",
                type = "TWOD",
                wrapS = "REPEAT",
                wrapT = "REPEAT",
            },
            map_dirt_normal = {
                fileName = "models/vehicle/dirt_normal.dds",
                redGreen = true,
                type = "TWOD",
                wrapS = "REPEAT",
                wrapT = "REPEAT",
            },
            map_metal_gloss_ao = {
                fileName = "models/vehicle/waggon/sbb_ec/" .. name_mgao .. "_mgao.dds",
                type = "TWOD",
            },
            map_normal = {
                fileName = "models/vehicle/waggon/sbb_ec/" .. name_mgao .. "_nrml.dds",
                redGreen = true,
                type = "TWOD",
            },
            map_rust = {
                fileName = "models/vehicle/rust_albedo.dds",
                type = "TWOD",
                wrapS = "REPEAT",
                wrapT = "REPEAT",
            },
            map_rust_normal = {
                fileName = "models/vehicle/rust_normal.dds",
                redGreen = true,
                type = "TWOD",
                wrapS = "REPEAT",
                wrapT = "REPEAT",
            },
            normal_scale = {
                normalScale = 1,
            },
            polygon_offset = {
                factor = 0,
                forceDepthWrite = false,
                units = 0,
            },
            two_sided = {
                flipNormal = true,
                twoSided = false,
            },
        },
        type = "PHYSICAL_NRML_MAP_CBLEND_DIRT",
    }
end

function sbb_ec_base_mats.interior_mat (name_albeod, name_mgao)
    return {
        order = 7,
        params = {
            albedo_scale = {
                albedoScale = { 1, 1, 1, },
            },
            alpha_scale = {
                alphaScale = 1,
            },
            alpha_test = {
                alphaThreshold = 0.5,
                cutout = false,
            },
            fade_out_range = {
                fadeOutEndDist = 20000,
                fadeOutStartDist = 10000,
            },
            map_albedo = {
                fileName = "models/vehicle/waggon/sbb_ec/" .. name_albeod .. "_albedo.dds",
                type = "TWOD",
                wrapS = "REPEAT",
                wrapT = "REPEAT",
            },
            map_metal_gloss_ao = {
                fileName = "models/vehicle/waggon/sbb_ec/" .. name_mgao .. "_mgao.dds",
                type = "TWOD",
            },
            map_normal = {
                fileName = "models/vehicle/waggon/sbb_ec/" .. name_mgao .. "_nrml.dds",
                redGreen = true,
                type = "TWOD",
            },
            normal_scale = {
                normalScale = 1,
            },
            polygon_offset = {
                factor = 0,
                forceDepthWrite = false,
                units = 0,
            },
            two_sided = {
                flipNormal = true,
                twoSided = false,
            },
        },
        type = "PHYSICAL_NRML_MAP",
    }
end
function sbb_ec_base_mats.exterior_glass_mat (name_albedo, name_mgao, order)
    return {
        order = order or 12,
        params = {
            albedo_scale = {
                albedoScale = { 1, 1, 1, },
            },
            alpha_scale = {
                alphaScale = 1,
            },
            alpha_test = {
                alphaThreshold = 0.5,
                cutout = false,
            },
            color_blend = cblend,
            dirt_rust = dirt_rust,
            fade_out_range = {
                fadeOutEndDist = 20000,
                fadeOutStartDist = 10000,
            },
            map_albedo_opacity = {
                fileName = "models/vehicle/waggon/sbb_ec/" .. name_albedo .. "_albedo.dds",
                type = "TWOD",
                wrapS = "REPEAT",
                wrapT = "REPEAT",
            },
            map_cblend_dirt_rust = {
                fileName = "models/vehicle/waggon/sbb_ec/" .. name_albedo .. "_cblend.dds",
                type = "TWOD",
            },
            map_dirt = {
                fileName = "models/vehicle/dirt_albedo.dds",
                type = "TWOD",
                wrapS = "REPEAT",
                wrapT = "REPEAT",
            },
            map_dirt_normal = {
                fileName = "models/vehicle/dirt_normal.dds",
                redGreen = true,
                type = "TWOD",
                wrapS = "REPEAT",
                wrapT = "REPEAT",
            },
            map_metal_gloss_ao = {
                fileName = "models/vehicle/waggon/sbb_ec/" .. name_mgao .. "_mgao.dds",
                type = "TWOD",
            },
            map_normal = {
                fileName = "models/vehicle/waggon/sbb_ec/" .. name_mgao .. "_nrml.dds",
                redGreen = true,
                type = "TWOD",
            },
            map_rust = {
                fileName = "models/vehicle/rust_albedo.dds",
                type = "TWOD",
                wrapS = "REPEAT",
                wrapT = "REPEAT",
            },
            map_rust_normal = {
                fileName = "models/vehicle/rust_normal.dds",
                redGreen = true,
                type = "TWOD",
                wrapS = "REPEAT",
                wrapT = "REPEAT",
            },
            normal_scale = {
                normalScale = 1,
            },
            polygon_offset = {
                factor = 0,
                forceDepthWrite = false,
                units = 0,
            },
            two_sided = {
                flipNormal = false,
                twoSided = false,
            },
        },
        type = "PHYS_TRANSPARENT_NRML_MAP_CBLEND_DIRT",
    }
end

function sbb_ec_base_mats.interior_glass_mat (name, mgao_name)
    return {
        order = 7,
        params = {
            albedo_scale = {
                albedoScale = { 1, 1, 1, },
            },
            alpha_scale = {
                alphaScale = 1,
            },
            alpha_test = {
                alphaThreshold = 0.01,
                cutout = true,
            },
            fade_out_range = {
                fadeOutEndDist = 20000,
                fadeOutStartDist = 10000,
            },
            map_albedo_opacity = {
                fileName = "models/vehicle/waggon/sbb_ec/" .. name .. "_albedo.dds",
                type = "TWOD",
                wrapS = "REPEAT",
                wrapT = "REPEAT",
            },
            map_metal_gloss_ao = {
                fileName = "models/vehicle/waggon/sbb_ec/" .. mgao_name .. "_mgao.dds",
                type = "TWOD",
            },
            map_normal = {
                fileName = "models/vehicle/waggon/sbb_ec/" .. mgao_name .. "_nrml.dds",
                redGreen = true,
                type = "TWOD",
            },
            normal_scale = {
                normalScale = 1,
            },
            polygon_offset = {
                factor = 0,
                forceDepthWrite = false,
                units = 0,
            },
            two_sided = {
                flipNormal = true,
                twoSided = false,
            },
        },
        type = "PHYS_TRANSPARENT_NRML_MAP",
    }
end

function sbb_ec_base_mats.routentafel (name)
    return {
        order = 0,
        params = {
            albedo_scale = {
                albedoScale = { 1, 1, 1, },
            },
            color_blend = {
                albedoScales = { 1, },
                colors = { },
            },
            dirt_rust = dirt_rust,
            fade_out_range = {
                fadeOutEndDist = 20000,
                fadeOutStartDist = 10000,
            },
            map_albedo = {
                fileName = "models/vehicle/waggon/sbb_ec/" .. name .. ".dds",
                type = "TWOD",
                wrapS = "REPEAT",
                wrapT = "REPEAT",
            },
            map_cblend_dirt_rust = {
                fileName = "models/vehicle/waggon/sbb_ec/routentafel_cblend.dds",
                type = "TWOD",
            },
            map_dirt = {
                fileName = "models/vehicle/dirt_albedo.dds",
                type = "TWOD",
                wrapS = "REPEAT",
                wrapT = "REPEAT",
            },
            map_dirt_normal = {
                fileName = "models/vehicle/dirt_normal.dds",
                redGreen = true,
                type = "TWOD",
                wrapS = "REPEAT",
                wrapT = "REPEAT",
            },
            map_metal_gloss_ao = {
                fileName = "models/vehicle/waggon/sbb_ec/routentafel_mgao.dds",
                type = "TWOD",
            },
            map_normal = {
                fileName = "models/vehicle/waggon/sbb_ec/routentafel_nrml.dds",
                redGreen = true,
                type = "TWOD",
            },
            map_rust = {
                fileName = "models/vehicle/rust_albedo.dds",
                type = "TWOD",
                wrapS = "REPEAT",
                wrapT = "REPEAT",
            },
            map_rust_normal = {
                fileName = "models/vehicle/rust_normal.dds",
                redGreen = true,
                type = "TWOD",
                wrapS = "REPEAT",
                wrapT = "REPEAT",
            },
            normal_scale = {
                normalScale = 1,
            },
            polygon_offset = {
                factor = 0,
                forceDepthWrite = false,
                units = 0,
            },
            two_sided = {
                flipNormal = true,
                twoSided = false,
            },
        },
        type = "PHYSICAL_NRML_MAP_CBLEND_DIRT",
    }
end

return sbb_ec_base_mats