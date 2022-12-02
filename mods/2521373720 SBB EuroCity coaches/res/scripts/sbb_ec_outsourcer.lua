--- GroupAdder
-- @module sbb_ec_outsourcer
--

local sbb_ec_outsourcer = {}

local seat_spacing = 2.055;
local seat_spacing_pano = 2.11939;
local seat_height = 1.25;
local seat_height_pano = 1.7;
local initial_pano_seats_x_position_forward = 9.13433;
local initial_pano_seats_x_position_backwards = 7.8224;
local initial_second_class_seats_x_position_forward = 9.88;
local initial_second_class_seats_x_position_backwards = 8.63;
local second_class_seats_outer_y_position = 0.97;
local second_class_seats_inner_y_position = 0.5;
local first_class_seats_inner_y_position = 0.373747;

local function generateSecondClassSeatTransfs (tranf, starting_row, end_row)
    for i = starting_row, end_row, 1 do
        tranf[#tranf + 1] = { -0.981, -0.173, 0.087, 0, 0.174, -0.985, 0, 0, 0.086, 0.015, 0.996, 0, initial_second_class_seats_x_position_forward - (seat_spacing * i), second_class_seats_outer_y_position, seat_height, 1, };
        tranf[#tranf + 1] = { -1, 0, 0, 0, -0, -1, 0, 0, 0, 0, 1, 0, initial_second_class_seats_x_position_forward - (seat_spacing * i), second_class_seats_inner_y_position, seat_height, 1, };
        tranf[#tranf + 1] = { -0.981, 0.173, 0.087, 0, -0.174, -0.985, 0, 0, 0.086, -0.015, 0.996, 0, initial_second_class_seats_x_position_forward - (seat_spacing * i), -second_class_seats_outer_y_position, seat_height, 1, };
        tranf[#tranf + 1] = { -1, 0, 0, 0, -0, -1, 0, 0, 0, 0, 1, 0, initial_second_class_seats_x_position_forward - (seat_spacing * i), -second_class_seats_inner_y_position, seat_height, 1, };

        tranf[#tranf + 1] = { 0.936, -0.341, 0.087, 0, 0.3078, 0.940, 0, 0, -0.082, -0.030, 0.996, 0, initial_second_class_seats_x_position_backwards - (seat_spacing * i), second_class_seats_outer_y_position, seat_height, 1, };
        tranf[#tranf + 1] = { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, initial_second_class_seats_x_position_backwards - (seat_spacing * i), second_class_seats_inner_y_position, seat_height, 1, };
        tranf[#tranf + 1] = { 0.936, 0.341, 0.087, 0, -0.3078, 0.940, 0, 0, -0.082, -0.030, 0.996, 0, initial_second_class_seats_x_position_backwards - (seat_spacing * i), -second_class_seats_outer_y_position, seat_height, 1, };
        tranf[#tranf + 1] = { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, initial_second_class_seats_x_position_backwards - (seat_spacing * i), -second_class_seats_inner_y_position, seat_height, 1, };
    end
    return tranf
end

function sbb_ec_outsourcer.generateSecondClassNormalSeatTransfs ()
    local tranf = {};

    tranf[#tranf + 1] = { -0.981, -0.173, 0.087, 0, 0.174, -0.985, 0, 0, 0.086, 0.015, 0.996, 0, initial_second_class_seats_x_position_forward - (seat_spacing * 0), second_class_seats_outer_y_position, seat_height, 1, };
    tranf[#tranf + 1] = { -1, 0, 0, 0, -0, -1, 0, 0, 0, 0, 1, 0, initial_second_class_seats_x_position_forward - (seat_spacing * 0), second_class_seats_inner_y_position, seat_height, 1, };
    tranf[#tranf + 1] = { -0.981, 0.173, 0.087, 0, -0.174, -0.985, 0, 0, 0.086, -0.015, 0.996, 0, initial_second_class_seats_x_position_forward - (seat_spacing * 0), -second_class_seats_outer_y_position, seat_height, 1, };

    tranf[#tranf + 1] = { 0.936, -0.341, 0.087, 0, 0.3078, 0.940, 0, 0, -0.082, -0.030, 0.996, 0, initial_second_class_seats_x_position_backwards - (seat_spacing * 0), second_class_seats_outer_y_position, seat_height, 1, };
    tranf[#tranf + 1] = { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, initial_second_class_seats_x_position_backwards - (seat_spacing * 0), second_class_seats_inner_y_position, seat_height, 1, };
    tranf[#tranf + 1] = { 0.936, 0.341, 0.087, 0, -0.3078, 0.940, 0, 0, -0.082, -0.030, 0.996, 0, initial_second_class_seats_x_position_backwards - (seat_spacing * 0), -second_class_seats_outer_y_position, seat_height, 1, };
    tranf[#tranf + 1] = { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, initial_second_class_seats_x_position_backwards - (seat_spacing * 0), -second_class_seats_inner_y_position, seat_height, 1, };

    tranf[#tranf + 1] = { -0.981, -0.173, 0.087, 0, 0.174, -0.985, 0, 0, 0.086, 0.015, 0.996, 0, initial_second_class_seats_x_position_forward - (seat_spacing * 9), second_class_seats_outer_y_position, seat_height, 1, }
    tranf[#tranf + 1] = { -1, 0, 0, 0, -0, -1, 0, 0, 0, 0, 1, 0, initial_second_class_seats_x_position_forward - (seat_spacing * 9), second_class_seats_inner_y_position, seat_height, 1, }
    tranf[#tranf + 1] = { -0.981, 0.173, 0.087, 0, -0.174, -0.985, 0, 0, 0.086, -0.015, 0.996, 0, initial_second_class_seats_x_position_forward - (seat_spacing * 9), -second_class_seats_outer_y_position, seat_height, 1, }
    tranf[#tranf + 1] = { -1, 0, 0, 0, -0, -1, 0, 0, 0, 0, 1, 0, initial_second_class_seats_x_position_forward - (seat_spacing * 9), -second_class_seats_inner_y_position, seat_height, 1, }

    tranf[#tranf + 1] = { 0.936, -0.341, 0.087, 0, 0.3078, 0.940, 0, 0, -0.082, -0.030, 0.996, 0, initial_second_class_seats_x_position_backwards - (seat_spacing * 9), second_class_seats_outer_y_position, seat_height, 1, }
    tranf[#tranf + 1] = { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, initial_second_class_seats_x_position_backwards - (seat_spacing * 9), second_class_seats_inner_y_position, seat_height, 1, }
    tranf[#tranf + 1] = { 0.936, 0.341, 0.087, 0, -0.3078, 0.940, 0, 0, -0.082, -0.030, 0.996, 0, initial_second_class_seats_x_position_backwards - (seat_spacing * 9), -second_class_seats_outer_y_position, seat_height, 1, }

    tranf = generateSecondClassSeatTransfs(tranf, 1, 8)

    return tranf, #tranf, seat_spacing, initial_second_class_seats_x_position_forward, initial_second_class_seats_x_position_backwards, second_class_seats_outer_y_position, second_class_seats_inner_y_position;
end

function sbb_ec_outsourcer.generateSecondClassBehigSeatTransfs ()
    local tranf = {};

    tranf[#tranf + 1] = { -0.981, -0.173, 0.087, 0, 0.174, -0.985, 0, 0, 0.086, 0.015, 0.996, 0, initial_second_class_seats_x_position_forward - (seat_spacing * 0), second_class_seats_outer_y_position, seat_height, 1, };
    tranf[#tranf + 1] = { -1, 0, 0, 0, -0, -1, 0, 0, 0, 0, 1, 0, initial_second_class_seats_x_position_forward - (seat_spacing * 0), second_class_seats_inner_y_position, seat_height, 1, };
    tranf[#tranf + 1] = { -0.981, 0.173, 0.087, 0, -0.174, -0.985, 0, 0, 0.086, -0.015, 0.996, 0, initial_second_class_seats_x_position_forward - (seat_spacing * 0), -second_class_seats_outer_y_position, seat_height, 1, };

    tranf[#tranf + 1] = { 0.936, -0.341, 0.087, 0, 0.3078, 0.940, 0, 0, -0.082, -0.030, 0.996, 0, initial_second_class_seats_x_position_backwards - (seat_spacing * 0), second_class_seats_outer_y_position, seat_height, 1, };
    tranf[#tranf + 1] = { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, initial_second_class_seats_x_position_backwards - (seat_spacing * 0), second_class_seats_inner_y_position, seat_height, 1, };
    tranf[#tranf + 1] = { 0.936, 0.341, 0.087, 0, -0.3078, 0.940, 0, 0, -0.082, -0.030, 0.996, 0, initial_second_class_seats_x_position_backwards - (seat_spacing * 0), -second_class_seats_outer_y_position, seat_height, 1, };
    tranf[#tranf + 1] = { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, initial_second_class_seats_x_position_backwards - (seat_spacing * 0), -second_class_seats_inner_y_position, seat_height, 1, };

    tranf[#tranf + 1] = { -0.981, -0.173, 0.087, 0, 0.174, -0.985, 0, 0, 0.086, 0.015, 0.996, 0, initial_second_class_seats_x_position_forward - (seat_spacing * 9), second_class_seats_outer_y_position, seat_height, 1, }
    tranf[#tranf + 1] = { -1, 0, 0, 0, -0, -1, 0, 0, 0, 0, 1, 0, initial_second_class_seats_x_position_forward - (seat_spacing * 9), second_class_seats_inner_y_position, seat_height, 1, }

    tranf[#tranf + 1] = { 0.936, -0.341, 0.087, 0, 0.3078, 0.940, 0, 0, -0.082, -0.030, 0.996, 0, initial_second_class_seats_x_position_backwards - (seat_spacing * 9), second_class_seats_outer_y_position, seat_height, 1, }
    tranf[#tranf + 1] = { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, initial_second_class_seats_x_position_backwards - (seat_spacing * 9), second_class_seats_inner_y_position, seat_height, 1, }
    tranf[#tranf + 1] = { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, initial_second_class_seats_x_position_backwards - (seat_spacing * 9), -0.065, seat_height, 1, }

    tranf = generateSecondClassSeatTransfs(tranf, 1, 8)

    return tranf, #tranf, seat_spacing, initial_second_class_seats_x_position_forward, initial_second_class_seats_x_position_backwards, second_class_seats_outer_y_position, second_class_seats_inner_y_position;
end

function sbb_ec_outsourcer.generateSecondClassVeloSeatTransfs ()
    local tranf = {};

    tranf[#tranf + 1] = { -0.981, -0.173, 0.087, 0, 0.174, -0.985, 0, 0, 0.086, 0.015, 0.996, 0, initial_second_class_seats_x_position_forward - (seat_spacing * 9), second_class_seats_outer_y_position, seat_height, 1, }
    tranf[#tranf + 1] = { -1, 0, 0, 0, -0, -1, 0, 0, 0, 0, 1, 0, initial_second_class_seats_x_position_forward - (seat_spacing * 9), second_class_seats_inner_y_position, seat_height, 1, }

    tranf[#tranf + 1] = { 0.936, -0.341, 0.087, 0, 0.3078, 0.940, 0, 0, -0.082, -0.030, 0.996, 0, initial_second_class_seats_x_position_backwards - (seat_spacing * 9), second_class_seats_outer_y_position, seat_height, 1, }
    tranf[#tranf + 1] = { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, initial_second_class_seats_x_position_backwards - (seat_spacing * 9), second_class_seats_inner_y_position, seat_height, 1, }
    tranf[#tranf + 1] = { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, initial_second_class_seats_x_position_backwards - (seat_spacing * 9), -0.065, seat_height, 1, }

    tranf = generateSecondClassSeatTransfs(tranf, 2, 8)

    return tranf, #tranf, seat_spacing, initial_second_class_seats_x_position_forward, initial_second_class_seats_x_position_backwards, second_class_seats_outer_y_position, second_class_seats_inner_y_position;
end

function sbb_ec_outsourcer.generateFirstClassSeatTransfs ()
    local tranf = {};
    for i = 0, 9, 1 do
        tranf[#tranf + 1] = { -0.981, -0.173, 0.087, 0, 0.174, -0.985, 0, 0, 0.086, 0.015, 0.996, 0, initial_second_class_seats_x_position_forward - (seat_spacing * i), second_class_seats_outer_y_position, seat_height, 1, };
        tranf[#tranf + 1] = { -1, 0, 0, 0, -0, -1, 0, 0, 0, 0, 1, 0, initial_second_class_seats_x_position_forward - (seat_spacing * i), first_class_seats_inner_y_position, seat_height, 1, };
        tranf[#tranf + 1] = { -0.981, 0.173, 0.087, 0, -0.174, -0.985, 0, 0, 0.086, -0.015, 0.996, 0, initial_second_class_seats_x_position_forward - (seat_spacing * i), -second_class_seats_outer_y_position, seat_height, 1, };

        tranf[#tranf + 1] = { 0.936, -0.341, 0.087, 0, 0.3078, 0.940, 0, 0, -0.082, -0.030, 0.996, 0, initial_second_class_seats_x_position_backwards - (seat_spacing * i), second_class_seats_outer_y_position, seat_height, 1, };
        tranf[#tranf + 1] = { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, initial_second_class_seats_x_position_backwards - (seat_spacing * i), first_class_seats_inner_y_position, seat_height, 1, };
        tranf[#tranf + 1] = { 0.936, 0.341, 0.087, 0, -0.3078, 0.940, 0, 0, -0.082, -0.030, 0.996, 0, initial_second_class_seats_x_position_backwards - (seat_spacing * i), -second_class_seats_outer_y_position, seat_height, 1, };
    end

    return tranf, #tranf, seat_spacing, initial_second_class_seats_x_position_forward, initial_second_class_seats_x_position_backwards, second_class_seats_outer_y_position, first_class_seats_inner_y_position;
end

function sbb_ec_outsourcer.generatePanoSeatTransfs ()
    local tranf = {};
    for i = 0, 8, 1 do
        tranf[#tranf + 1] = { -0.981, -0.173, 0.087, 0, 0.174, -0.985, 0, 0, 0.086, 0.015, 0.996, 0, initial_pano_seats_x_position_forward - (seat_spacing_pano * i), second_class_seats_outer_y_position, seat_height_pano, 1, };
        tranf[#tranf + 1] = { -1, 0, 0, 0, -0, -1, 0, 0, 0, 0, 1, 0, initial_pano_seats_x_position_forward - (seat_spacing_pano * i), first_class_seats_inner_y_position, seat_height_pano, 1, };
        tranf[#tranf + 1] = { -0.981, 0.173, 0.087, 0, -0.174, -0.985, 0, 0, 0.086, -0.015, 0.996, 0, initial_pano_seats_x_position_forward - (seat_spacing_pano * i), -second_class_seats_outer_y_position, seat_height_pano, 1, };

        tranf[#tranf + 1] = { 0.936, -0.341, 0.087, 0, 0.3078, 0.940, 0, 0, -0.082, -0.030, 0.996, 0, initial_pano_seats_x_position_backwards - (seat_spacing_pano * i), second_class_seats_outer_y_position, seat_height_pano, 1, };
        tranf[#tranf + 1] = { 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, initial_pano_seats_x_position_backwards - (seat_spacing_pano * i), first_class_seats_inner_y_position, seat_height_pano, 1, };
        tranf[#tranf + 1] = { 0.936, 0.341, 0.087, 0, -0.3078, 0.940, 0, 0, -0.082, -0.030, 0.996, 0, initial_pano_seats_x_position_backwards - (seat_spacing_pano * i), -second_class_seats_outer_y_position, seat_height_pano, 1, };
    end

    return tranf, #tranf, seat_spacing_pano, initial_pano_seats_x_position_forward, initial_pano_seats_x_position_backwards, second_class_seats_outer_y_position, first_class_seats_inner_y_position;
end

function sbb_ec_outsourcer.getDatesForEurocityApm ()
    return 1989, 2014;
end

function sbb_ec_outsourcer.getDatesForCisalpino ()
    return 2004, 2009;
end

function sbb_ec_outsourcer.getDatesForExCisalpino ()
    return 2009, 2014;
end

function sbb_ec_outsourcer.getDatesForEurocityBpmNormal ()
    return 1990, 2014;
end

function sbb_ec_outsourcer.getDatesForEurocityBpmSpecial ()
    return 1991, 2014;
end

function sbb_ec_outsourcer.getDatesForEurocityPano ()
    return 1991, 2013;
end

function sbb_ec_outsourcer.getDatesForRefitPano ()
    return 2012, 2017;
end

function sbb_ec_outsourcer.getDatesForGoPexPano ()
    return 2017, 2024;
end

function sbb_ec_outsourcer.getDatesForEurocityBpmEm08 ()
    return 2008, 2009;
end

function sbb_ec_outsourcer.getDatesForRefit ()
    return 2009, 2024;
end

function sbb_ec_outsourcer.getDatesForBehigBehig ()
    return 2020, 0000;
end

function sbb_ec_outsourcer.getDatesForBehigOthers ()
    return 2021, 0000;
end

function sbb_ec_outsourcer.getDatesForBehigPano ()
    return 2023, 0000;
end

function sbb_ec_outsourcer.getDoorAnimation ()
    local door_open = {
        params = {
            id = "vehicle/waggon/sbb_ec/door_open.ani",
        },
        type = "FILE_REF",
    };
    local door_close = {
        params = {
            id = "vehicle/waggon/sbb_ec/door_close.ani",
        },
        type = "FILE_REF",
    };
    return {
        open_doors_right = door_open,
        close_doors_right = door_close,
        open_all_doors = door_open,
        close_all_doors = door_close,
    }, {
        open_doors_left = door_open,
        close_doors_left = door_close,
        open_all_doors = door_open,
        close_all_doors = door_close,
    };
end

function sbb_ec_outsourcer.getTrittbrettAnimation ()
    local open_door = {
        params = {
            id = "vehicle/waggon/sbb_ec/trittbrett_open.ani",
        },
        type = "FILE_REF",
    };
    local close_door = {
        params = {
            id = "vehicle/waggon/sbb_ec/trittbrett_close.ani",
        },
        type = "FILE_REF",
    };
    return {
        open_doors_right = open_door,
        close_doors_right = close_door,
        open_all_doors = open_door,
        close_all_doors = close_door,
    }, {
        open_doors_left = open_door,
        close_doors_left = close_door,
        open_all_doors = open_door,
        close_all_doors = close_door,
    };
end

function sbb_ec_outsourcer.getPassengerInformationForEuroCity ()
    local routentafel = "ec_a_einstein"
    if (game) then
        local selectedTafel = game.config.sbb_ec_routentafel
        if (selectedTafel) then
            routentafel = selectedTafel;
        end
    end
    return "vehicle/waggon/sbb_ec/" .. routentafel .. ".mtl", {};
end

function sbb_ec_outsourcer.getPassengerInformationForCisalpino ()
    local routentafel = "cis_c_terre"
    if (game) then
        local selectedTafel = game.config.sbb_cis_routentafel
        if (selectedTafel) then
            routentafel = selectedTafel;
        end
    end
    return "vehicle/waggon/sbb_ec/" .. routentafel .. ".mtl", {};
end

function sbb_ec_outsourcer.getPassengerInformationForExCisalpino ()
    local routentafel = "ec_a_einstein"
    if (game) then
        local selectedTafel = game.config.sbb_ec_routentafel
        if (selectedTafel and selectedTafel == "routentafel_ec_leer") then
            routentafel = "routentafel_cis_leer";
        elseif selectedTafel then
            routentafel = selectedTafel;
        end
    end
    return "vehicle/waggon/sbb_ec/" .. routentafel .. ".mtl", {};
end


local regexParam={
    expr = "(\\b(IC|IR|RE|R|EC|EN|NJ|RJ|RJX|TGV|ICE|EXT|PE|CNL|ICN|VAE|TEE)(\\b\\s[0-9]{0,2}|[0-9]{0,2}))",
    replace="\\0",
};

local function getExteriorLabels(labelList, childId)

    table.insert(labelList, {
        type = "LINE_NAME",
        transf = { 0.1, 0, 0, 0, 0, 0, 0.1, 0, 0, -0.1, 0, 0, 0.20886, 0.002, 0.383726, 1, },
        size = { 01.5, 0.5 },
        color = { 247 / 255, 147 / 255, 33 / 255 },
        fitting = "CUT",
        alignment = "LEFT",
        renderMode = "EMISSIVE",
        filter = "CUSTOM",
        params = regexParam,
        childId = childId,
    })
    table.insert(labelList, {
        type = "NEXT_STOP",
        transf = { 0.1, 0, 0, 0, 0, 0, 0.1, 0, 0, -0.1, 0, 0, 0.20886, 0.002, 0.23, 1, },
        size = { 5.5231, 0.6 },
        color = { 247 / 255, 147 / 255, 33 / 255 },
        fitting = "CUT",
        alignment = "LEFT",
        renderMode = "EMISSIVE",
        params = {
            relative = true,
            offset = 3,
        },
        childId = childId,
    })
    table.insert(labelList, {
        type = "NEXT_STOP",
        transf = { 0.1, 0, 0, 0, 0, 0, 0.1, 0, 0, -0.1, 0, 0, 0.20886, 0.002, 0.303726, 1, },
        size = { 5.5231, 0.6 },
        color = { 247 / 255, 147 / 255, 33 / 255 },
        fitting = "CUT",
        alignment = "LEFT",
        renderMode = "EMISSIVE",
        params = {
            relative = true,
            offset = 2,
        },
        childId = childId,
    })

    if (commonapi ~= nil and commonapi.supports and commonapi.supports("LINE_DESTINATION")) then
        table.insert(labelList, {
            type = "LINE_DESTINATION",
            transf = { 0.1, 0, 0, 0, 0, 0, 0.1, 0, 0, -0.1, 0, 0, 0.20886, 0.002, 0.163726, 1, },
            size = { 5.5231, 0.6 },
            color = { 247 / 255, 147 / 255, 33 / 255 },
            fitting = "CUT",
            alignment = "LEFT",
            renderMode = "EMISSIVE",
            childId = childId,
        });
    else
        table.insert(labelList, {
            type = "NEXT_STOP",
            transf = { 0.1, 0, 0, 0, 0, 0, 0.1, 0, 0, -0.1, 0, 0, 0.20886, 0.002, 0.163726, 1, },
            size = { 5.5231, 0.6 },
            color = { 247 / 255, 147 / 255, 33 / 255 },
            fitting = "CUT",
            alignment = "LEFT",
            renderMode = "EMISSIVE",
            params = {
                relative = true,
                offset = 3,
                expr = "",
            },
            childId = childId,
        })
    end

    return labelList
end

local function getStationLabels(labelList, childId)
    table.insert(labelList, {
        type = "NEXT_STOP",
        transf = { 0, -0.1, 0, 0, 0, 0, 0.1, 0, -0.1, -0, 0, 0, 0, -0.022316, 0.081, 1, },
        size = { 5.5231, 0.4 },
        color = { 247 / 255, 147 / 255, 33 / 255 },
        fitting = "CUT",
        params = {
            relative = true,
            offset = 2,
            expr = "",
        },
        alignment = "LEFT",
        renderMode = "EMISSIVE",
        childId = childId,
    });
    table.insert(labelList, {
        type = "LINE_NAME",
        transf = { 0, -0.1, 0, 0, 0, 0, 0.1, 0, -0.1, -0, 0, 0, 0, -0.45, 0.081, 1, },
        size = { 01.5, 0.4 },
        color = { 247 / 255, 147 / 255, 33 / 255 },
        fitting = "CUT",
        alignment = "RIGHT",
        renderMode = "EMISSIVE",
        filter = "CUSTOM",
        params = regexParam,
        childId = childId,
    });
    table.insert(labelList, {
        type = "NEXT_STOP",
        transf = { 0, -0.1, 0, 0, 0, 0, 0.1, 0, -0.1, -0, 0, 0, 0, -0.022316, 0.05, 1, },
        size = { 5.5231, 0.25 },
        color = { 247 / 255, 147 / 255, 33 / 255 },
        fitting = "CUT",
        params = {
            relative = true,
            offset = 3,
            expr = "",
        },
        alignment = "LEFT",
        renderMode = "EMISSIVE",
        childId = childId,
    });

    if (commonapi ~= nil and commonapi.supports and commonapi.supports("LINE_DESTINATION")) then
        table.insert(labelList, {
            type = "LINE_DESTINATION",
            transf = { 0, -0.1, 0, 0, 0, 0, 0.1, 0, -0.1, -0, 0, 0, 0, -0.022316, 0.005, 1, },
            size = { 5.5231, 0.4 },
            color = { 247 / 255, 147 / 255, 33 / 255 },
            fitting = "CUT",
            alignment = "LEFT",
            renderMode = "EMISSIVE",
            childId = childId,
        });
    else
        table.insert(labelList, {
            type = "NEXT_STOP",
            transf = { 0, -0.1, 0, 0, 0, 0, 0.1, 0, -0.1, -0, 0, 0, 0, -0.022316, 0.005, 1, },
            size = { 5.5231, 0.4 },
            color = { 247 / 255, 147 / 255, 33 / 255 },
            fitting = "CUT",
            params = {
                relative = true,
                offset = 4,
                expr = "",
            },
            alignment = "LEFT",
            renderMode = "EMISSIVE",
            childId = childId,
        });

    end

    return labelList;
end

local function getInteriorLabels(labelList, childId)
    table.insert(labelList, {
        type = "NEXT_STOP",
        transf = { 0, -0.1, 0, 0, 0, 0, 0.1, 0, -0.1, -0, 0, 0, 0, -0.022316, 0.081, 1, },
        size = { 5.5231, 0.4 },
        color = { 247 / 255, 147 / 255, 33 / 255 },
        fitting = "CUT",
        params = {
            relative = true,
            offset = 2,
            expr = "",
        },
        alignment = "LEFT",
        renderMode = "EMISSIVE",
        childId = childId,
    });
    table.insert(labelList, {
        type = "LINE_NAME",
        transf = { 0, -0.1, 0, 0, 0, 0, 0.1, 0, -0.1, -0, 0, 0, 0, -0.45, 0.081, 1, },
        size = { 01.5, 0.4 },
        color = { 247 / 255, 147 / 255, 33 / 255 },
        fitting = "CUT",
        alignment = "RIGHT",
        renderMode = "EMISSIVE",
        filter = "CUSTOM",
        params = regexParam,
        childId = childId,
    });

    if (commonapi ~= nil and commonapi.supports and commonapi.supports("LINE_DESTINATION")) then
        table.insert(labelList, {
            type = "LINE_DESTINATION",
            transf = { 0, -0.1, 0, 0, 0, 0, 0.1, 0, -0.1, -0, 0, 0, 0, -0.022316, 0.03, 1, },
            size = { 5.5231, 0.4 },
            color = { 247 / 255, 147 / 255, 33 / 255 },
            fitting = "CUT",
            params = {
                relative = true,
                offset = 3,
                expr = "",
            },
            alignment = "LEFT",
            renderMode = "EMISSIVE",
            childId = childId,
        });
    else
        table.insert(labelList, {
            type = "NEXT_STOP",
            transf = { 0, -0.1, 0, 0, 0, 0, 0.1, 0, -0.1, -0, 0, 0, 0, -0.022316, 0.03, 1, },
            size = { 5.5231, 0.4 },
            color = { 247 / 255, 147 / 255, 33 / 255 },
            fitting = "CUT",
            params = {
                relative = true,
                offset = 3,
                expr = "",
            },
            alignment = "LEFT",
            renderMode = "EMISSIVE",
            childId = childId,
        });
    end

    return labelList;
end

function sbb_ec_outsourcer.getPassengerInformationForRefit ()
    local exterior_out = {
        params = {
            id = "vehicle/waggon/sbb_ec/digitalanzeige_exterior_open.ani",
        },
        type = "FILE_REF",
    };

    local exterior_in = {
        params = {
            id = "vehicle/waggon/sbb_ec/digitalanzeige_exterior_close.ani",
        },
        type = "FILE_REF",
    };

    local interior_in = {
        params = {
            id = "vehicle/waggon/sbb_ec/digitalanzeige_interior_in.ani",
        },
        type = "FILE_REF",
    };

    local interior_out = {
        params = {
            id = "vehicle/waggon/sbb_ec/digitalanzeige_interior_out.ani",
        },
        type = "FILE_REF",
    };

    local interior_station_out = {
        params = {
            id = "vehicle/waggon/sbb_ec/digitalanzeige_interior_station_out.ani",
        },
        type = "FILE_REF",
    };

    local interior_station_in = {
        params = {
            id = "vehicle/waggon/sbb_ec/digitalanzeige_interior_station_in.ani",
        },
        type = "FILE_REF",
    };

    local exteriorAnis = {
        open_all_doors = exterior_out,
        open_doors_right = exterior_out,
        open_doors_left = exterior_out,
        close_all_doors = exterior_in,
        close_doors_right = exterior_in,
        close_doors_left = exterior_in,
    };

    local interiorAnis = {
        open_all_doors = interior_in,
        open_doors_right = interior_in,
        open_doors_left = interior_in,
        close_all_doors = interior_out,
        close_doors_right = interior_out,
        close_doors_left = interior_out,
    };
    local stationAnis = {
        open_all_doors = interior_station_out,
        open_doors_right = interior_station_out,
        open_doors_left = interior_station_out,
        close_all_doors = interior_station_in,
        close_doors_right = interior_station_in,
        close_doors_left = interior_station_in,
    };

    local labelList = {}
    labelList = getExteriorLabels(labelList, "sbb_ec_digitalanzeige_ani_right");
    labelList = getExteriorLabels(labelList, "sbb_ec_digitalanzeige_ani_left");
    labelList = getInteriorLabels(labelList, "sbb_ec_interior_digitalanzeige_interior_ani_left")
    labelList = getInteriorLabels(labelList, "sbb_ec_interior_digitalanzeige_interior_ani_right")
    labelList = getStationLabels(labelList, "sbb_ec_interior_digitalanzeige_interior_station_ani_left")
    labelList = getStationLabels(labelList, "sbb_ec_interior_digitalanzeige_interior_station_ani_right")

    return labelList,
    exteriorAnis,
    interiorAnis,
    stationAnis;
end

function sbb_ec_outsourcer.getBikeTransfsBikeCoach (isRefitted)
    local transfs = {
        { -0.65404415130615, 0.65404367446899, 0.38006982207298, 0, -0.70710653066635, -0.70710706710815, -3.6593299057586e-08, 0, 0.26874959468842, -0.2687494456768, 0.92495632171631, 0, 9.345778465271, 0.7437881231308, 1.468999505043, 1, },
        { -0.68904441595078, 0.62792056798935, 0.36184740066528, 0, -0.67767465114594, -0.73521637916565, -0.014620592817664, 0, 0.25685518980026, -0.2552886903286, 0.93212115764618, 0, 8.6086339950562, 0.79025387763977, 1.4570257663727, 1, },
        { -0.64939904212952, 0.64939898252487, 0.39567866921425, 0, -0.707106590271, -0.70710670948029, 7.5528802767622e-08, 0, 0.27978673577309, -0.27978658676147, 0.91838753223419, 0, 7.8329358100891, 0.75663083791733, 1.4609882831573, 1, },
        { -0.65856158733368, 0.65856128931046, 0.36413383483887, 0, -0.70710653066635, -0.70710694789886, 7.433531834522e-08, 0, 0.25748124718666, -0.25748097896576, 0.9313451051712, 0, 7.0795164108276, 0.76004910469055, 1.4625248908997, 1, },
        { -0.68963521718979, 0.68963515758514, 0.22092142701149, 0, -0.70710670948029, -0.70710670948029, -7.7566284062414e-08, 0, 0.15621477365494, -0.15621487796307, 0.97529006004333, 0, 9.0882453918457, 0.69315892457962, 1.3629397153854, 1, },
        { -0.68963521718979, 0.68963515758514, 0.22092142701149, 0, -0.70710670948029, -0.70710670948029, -7.7566284062414e-08, 0, 0.15621477365494, -0.15621487796307, 0.97529006004333, 0, 8.3382453918457, 0.69315892457962, 1.3629397153854, 1, },
        { -0.68963521718979, 0.68963515758514, 0.22092142701149, 0, -0.70710670948029, -0.70710670948029, -7.7566284062414e-08, 0, 0.15621477365494, -0.15621487796307, 0.97529006004333, 0, 7.5882444381714, 0.69315892457962, 1.3629397153854, 1, },
        { -0.68649917840958, 0.68649876117706, 0.23966240882874, 0, -0.70710653066635, -0.70710700750351, 3.1146529799742e-09, 0, 0.16946674883366, -0.16946661472321, 0.97085481882095, 0, 6.8454375267029, 0.69215732812881, 1.3615915775299, 1, }
    };

    if (isRefitted) then
        for key, transf in ipairs(sbb_ec_outsourcer.getBikeTransfsRefitCoach()) do
            table.insert(transfs, transf)
        end
    end
    return transfs;
end

function sbb_ec_outsourcer.getBikeTransfsRefitCoach ()
    return {
        { -0.002774316817522, -0.018417255952954, 0.9998265504837, 0, 0.99681627750397, -0.079721733927727, 0.0012974535347894, 0, -0.079684011638165, -0.99664694070816, -0.018579794093966, 0, 10.820136070251, 1.2887270450592, 2.293509721756, 1, },
        { 0.015326842665672, -0.01146980933845, 0.99981677532196, 0, 0.99294167757034, -0.11744017153978, -0.016568712890148, 0, -0.11760869622231, -0.99301373958588, -0.0095888655632734, 0, 11.335344314575, 1.295224905014, 2.2882390022278, 1, }
    };
end

function sbb_ec_outsourcer.getBikeTransfsPanoCoach ()
    return {
        { 0.002774316817522, -0.018417166545987, 0.9998265504837, 0, -0.99681615829468, -0.079722046852112, 0.0012974545825273, 0, 0.07968433201313, -0.99664694070816, -0.018579704686999, 0, -10.820136070251, 1.2887270450592, 2.293509721756, 1, },
        { -0.015326961874962, -0.011469840072095, 0.99981677532196, 0, -0.99294155836105, -0.11744037270546, -0.016568837687373, 0, 0.11760890483856, -0.99301367998123, -0.0095888786017895, 0, -11.335344314575, 1.295224905014, 2.2882390022278, 1, }
    };
end

function sbb_ec_outsourcer.getSound ()
    if (game and game.config.hd_is_train_sound_mod_installed) then
        return {
            name = "sbb_ec_tsm",
        };
    else
        return {
            name = "sbb_ec_vanilla",
        };
    end
end

return sbb_ec_outsourcer;