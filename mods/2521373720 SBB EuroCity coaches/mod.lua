local global = require "eatglobal_v2_29"
local modutils = global.modutils

local modId = "hundertdampf_sbb_ec"
local modData = {
    general = {
        hideFiles = { "vehicle/waggon/sbb_ec_set.mdl", "vehicle/waggon/sbb_ec_fake_set.mdl", },
    },
    userSelection = {
        files = {
            {
                key = "sbb_ec_eurocity",
                name = "*_name",
                tooltip = "*_tooltip",
                default = true,
                values = { "hd_display", "hd_hide" },
                modelFiles = {
                    "vehicle/waggon/sbb_ec_bpm_eurocity_normal.mdl",
                    "vehicle/waggon/sbb_ec_bpm_eurocity_behig.mdl",
                    "vehicle/waggon/sbb_ec_bpm_eurocity_velo.mdl",
                    "vehicle/waggon/sbb_ec_apm_eurocity.mdl",
                    "vehicle/waggon/sbb_ec_apm_pano_eurocity.mdl",
                },
            },
            {
                key = "sbb_ec_refit",
                name = "*_name",
                tooltip = "*_tooltip",
                default = true,
                values = { "hd_display", "hd_hide" },
                modelFiles = {
                    "vehicle/waggon/sbb_ec_bpm_refit_normal.mdl",
                    "vehicle/waggon/sbb_ec_bpm_refit_behig.mdl",
                    "vehicle/waggon/sbb_ec_bpm_refit_velo.mdl",
                    "vehicle/waggon/sbb_ec_apm_refit.mdl",
                    "vehicle/waggon/sbb_ec_apm_pano_refit.mdl",
                    "vehicle/waggon/sbb_ec_apm_pano_gopex.mdl",
                },
            },
            {
                key = "sbb_ec_behig",
                name = "*_name",
                tooltip = "*_tooltip",
                default = true,
                values = { "hd_display", "hd_hide" },
                modelFiles = {
                    "vehicle/waggon/sbb_ec_bpm_behig_normal.mdl",
                    "vehicle/waggon/sbb_ec_bpm_behig_behig.mdl",
                    "vehicle/waggon/sbb_ec_bpm_behig_velo.mdl",
                    "vehicle/waggon/sbb_ec_apm_behig.mdl",
                    "vehicle/waggon/sbb_ec_apm_pano_behig.mdl",
                },
            },
            {
                key = "sbb_ec_cis",
                name = "*_name",
                tooltip = "*_tooltip",
                default = false,
                values = { "hd_display", "hd_hide" },
                modelFiles = {
                    "vehicle/waggon/sbb_ec_apm_cis.mdl",
                    "vehicle/waggon/sbb_ec_bpm_cis.mdl",
                },
            },
            {
                key = "sbb_ec_excis",
                name = "*_name",
                tooltip = "*_tooltip",
                default = false,
                values = { "hd_display", "hd_hide" },
                modelFiles = {
                    "vehicle/waggon/sbb_ec_apm_excis.mdl",
                    "vehicle/waggon/sbb_ec_bpm_excis.mdl",
                },
            },
            {
                key = "sbb_ec_em08",
                name = "*_name",
                tooltip = "*_tooltip",
                default = false,
                values = { "hd_display", "hd_hide" },
                modelFiles = {
                    "vehicle/waggon/sbb_ec_bpm_eurocity_em08.mdl",
                },
            },
        },
        autoFiles = {
            {
                key = "sbb_ec_fake",
                name = "hd_fake_name",
                tooltip = "hd_fake_tooltip",
                default = false,
                values = { "hd_display", "hd_hide" },
                autoString = "_fake",
            },
        },
        disableStartYear = {
            key = "sbb_ec_startyear",
            name = "hd_startyear_name",
            tooltip = "hd_startyear_tooltip",
            default = false,
            values = { "hd_1850", "Default" },
        },
        disableEndYear = {
            key = "sbb_ec_endyear",
            name = "hd_endyear_name",
            tooltip = "hd_endyear_tooltip",
            default = false,
            values = { "hd_infinite", "Default" },
        },
    },
}
local myModUtils = modutils.userSettings.create(modId, modData)

local function generateParams(params)
    local size = #modData.userSelection.files + #modData.userSelection.autoFiles + 2 + 3;

    if (#params < size) then
        params[#params + 1] = {
            key = "sbb_ec_routentafel",
            name = _("sbb_ec_routentafel_name"),
            tooltip = _("sbb_ec_routentafel_tooltip"),
            uiType = "COMBOBOX",
            values = { "EC Vauban", "EC Rätia", "EC Hans Dampf", "EC Albert Einstein", "EC Rembrandt", "EC Transalpin", "EC Hermann Hesse", _("hd_random"), _("hd_routentafel_empty") },
            defaultIndex = 7,
        };

        params[#params + 1] = {
            key = "sbb_cis_routentafel",
            name = _("sbb_cis_routentafel_name"),
            tooltip = _("sbb_cis_routentafel_tooltip"),
            uiType = "COMBOBOX",
            values = { "Cisalpino Cinque Terre", _("hd_routentafel_empty") },
            defaultIndex = 0,
        };

        params[#params + 1] = {
            key = "hd_display_bikes",
            name = _("hd_display_bikes_name"),
            tooltip = _("hd_display_bikes_tooltip"),
            uiType = "CHECKBOX",
            values = { "0", "1" },
        };

        params[#params + 1] = {
            key = "sbb_ec_is_train_sound_mod_installed",
            name = _("hd_is_train_sound_mod_installed_name"),
            tooltip = _("hd_is_train_sound_mod_installed_tooltip"),
            uiType = "CHECKBOX",
            values = { "0", "1" },
        };
    end
    return params;
end

local function randomRoutentafel()
    local eurocitys = { "ec_vauban", "ec_raetia", "ec_h_dampf", "ec_a_einstein", "ec_rembrandt", "ec_transalpin", "ec_h_hesse", }
    return eurocitys[math.random(0, #eurocitys)]
end

function data()
    return {
        info = {
            minorVersion = 1,
            severityAdd = "NONE",
            severityRemove = "WARNING",
            name = _("sbb_ec_mod_name"),
            description = _("sbb_ec_mod_desc"),
            authors = {
                {
                    name = "HundertDampf",
                    role = "CREATOR",
                    steamProfile = "104822099",
                    tfnetId = 21066,
                },
            },
            tags = { "passenger", },
            visible = true,
            params = generateParams(myModUtils.myParams.params),
        },

        runFn = function(settings, modParams)
            local params = modParams[getCurrentModId()]

            if params then
                myModUtils.execute(params)
            end

            local function metadataHandler(fileName, data)
                local ecValues = { "ec_vauban", "ec_raetia", "ec_h_dampf", "ec_a_einstein", "ec_rembrandt", "ec_transalpin", "ec_h_hesse", randomRoutentafel(), "routentafel_ec_leer", }
                game.config.sbb_ec_routentafel = ecValues[params["sbb_ec_routentafel"] + 1];

                local cisValues = { "cis_c_terre", "routentafel_cis_leer", }
                game.config.sbb_cis_routentafel = cisValues[params["sbb_cis_routentafel"] + 1];

                game.config.hundertdampf_display_bikes = game.config.hundertdampf_display_bikes or params["sbb_ec_display_bikes"] == 1;
                game.config.hd_is_train_sound_mod_installed = game.config.hd_is_train_sound_mod_installed or params["sbb_ec_is_train_sound_mod_installed"] == 1;
                return data
            end

            addModifier("loadModel", metadataHandler)
        end
    }
end
