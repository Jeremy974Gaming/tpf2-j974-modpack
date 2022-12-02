--- Bikeadder
-- @module bike_adder
--

local bike_adder = {};

function bike_adder.getDefaultLoadConfig(amountOfSeats)
    return null, {
        cargoEntries = {
            {
                capacity = amountOfSeats,
                seats = { },
                type = "PASSENGERS",
            },
        },
        toHide = { },
    };
end

local function veloSlotGenerator (transfs)
    local veloMdls = {
        "asset/mav2002_bicyclestand/mav2002_bike_01.mdl",
        "asset/mav2002_bicyclestand/mav2002_bike_02.mdl",
        "asset/mav2002_bicyclestand/mav2002_bike_03.mdl",
        "asset/mav2002_bicyclestand/mav2002_bike_04.mdl",
        "asset/mav2002_bicyclestand/mav2002_bike_05.mdl",
        "asset/mav2002_bicyclestand/mav2002_bike_06.mdl",
        "asset/mav2002_bicyclestand/mav2002_bike_07.mdl",
        "hd_empty.mdl",
        "hd_empty.mdl",
        "hd_empty.mdl",
        "hd_empty.mdl",
        "hd_empty.mdl",
        "hd_empty.mdl",
        "hd_empty.mdl",
        "hd_empty.mdl",
        "hd_empty.mdl",
    };

    local slots = {};

    for key, transf in ipairs(transfs) do
        slots[#slots + 1] = {
            models = veloMdls,
            group = 1,
            transf = transf,
            randomId = key,
        };

    end
    return slots;
end

local function bikeCargoConfigGenerator (amountOfSeats, amountOfSlots)
    local slotLevels = { {}, };

    local function getNumbers()
        local masterNumbers = {}
        for i = 0, amountOfSlots - 1, 1 do
            table.insert(masterNumbers, i);
        end
        return masterNumbers;
    end
    for i = 0, amountOfSlots - 1, 1 do
        local numbers = getNumbers();
        local level = {};
        for j = 0, i, 1 do
            local randNumb = math.random(1, #numbers);
            level[#level + 1] = numbers[randNumb];
            table.remove(numbers, randNumb)
        end
        slotLevels[#slotLevels + 1] = level;
    end

    return {
        cargoEntries = {
            {
                capacity = amountOfSeats,
                seats = {  },
                customCargoModels = {
                    configurations = {
                        {
                            slotLevels = slotLevels,
                        },
                    },
                },
                type = "PASSENGERS",
            },
        },
    };
end

function bike_adder.getVeloCargoConfig (amountOfSeats, transfs)
    local isBikeModInstalled = false;
    if (game) then
        isBikeModInstalled = game.config.hundertdampf_display_bikes;
    end

    if (not isBikeModInstalled) then
        return bike_adder.getDefaultLoadConfig(amountOfSeats);
    else
        return { slots = veloSlotGenerator(transfs), }, bikeCargoConfigGenerator(amountOfSeats, #transfs);
    end
end

return bike_adder;