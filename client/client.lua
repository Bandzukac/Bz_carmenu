
local player = PlayerPedId()
local vehicle = GetVehiclePedIsIn(player, false)

RegisterKeyMapping("carmenu", "Otevřít Menu Auta", "keyboard", "F5")--Default bind F5 choose on your choice

function OpenCarMenu()
        lib.registerContext({
            id = 'bandzukac_carmenu_open',
            title = locale.titlename,
            options = {
                {
                    title = locale.engine,
                    icon = 'key',
                    description = locale.engineonoff,
                    event = 'bandzukac_carmenu:turnengineoff',
                    onSelect = function()
                        lib.showContext('bandzukac_carmenu_open')
                    end
                },
                {
                    title = locale.neon,
                    icon = 'paint-roller',
                    description = locale.neononoff,
                    event = "bandzukac_carmenu:neon",
                    onSelect = function()
                        lib.showContext('bandzukac_carmenu_open')
                    end
                },
                {
                    title = locale.seat,
                    icon = 'chair',
                    arrow = true,
                    description = locale.seatdesc,
                    event = "bandzukac_carmenu:seat",
                    onSelect = function()
                        lib.showContext('bandzukac_carmenu_open')
                    end
                },
                {
                    title = locale.doortitle,
                    icon = 'door-open',
                    arrow = true,
                    description = locale.doordesc,
                    event = "bandzukac_carmenu:opendoorsmenu",
                    onSelect = function()
                        lib.showContext('bandzukac_carmenu_open')
                    end
                },
                {
                    title = locale.windowtitle,
                    icon = 'up-down',
                    arrow = true,
                    description = locale.windowdesc,
                    event = "bandzukac_carmenu:openwindowsmenu",
                    onSelect = function()
                        lib.showContext('bandzukac_carmenu_open')
                    end
                },
            },
        })
    lib.showContext('bandzukac_carmenu_open')
end

RegisterCommand("carmenu", function()
    local user = PlayerPedId()
	local vehicle = GetVehiclePedIsIn(user,false)	
    if IsPedInAnyVehicle(user) then
        OpenCarMenu()
    end
end)

local engineoff = true
RegisterNetEvent("bandzukac_carmenu:turnengineoff", function()
    local player = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(player, false)
    local engineoff = GetIsVehicleEngineRunning(vehicle)
    if vehicle == 0 or GetPedInVehicleSeat(vehicle, -1) ~= player then return end
    if GetIsVehicleEngineRunning(vehicle) then
        lib.progressBar({
            duration = 1000,
            label = locale.engineoff,
            useWhileDead = false,
            canCancel = true,
            disable = {
                car = true,
            },
        })
    else
        lib.progressBar({
            duration = 1000,
            label = locale.engineon,
            useWhileDead = false,
            canCancel = true,
            disable = {
                car = true,
            },
        })
    end
    while (enigneoff == false) do
        SetVehicleUndriveable(vehicle,true)
    end
    SetVehicleEngineOn(vehicle, not GetIsVehicleEngineRunning(vehicle), false, true)
end)

local interiorlights = false
local frontlights = true
RegisterNetEvent("bandzukac_carmenu:neon", function()
    if neons then
        neons = false
        DisableVehicleNeonLights(vehicle, false, false, false)
        lib.progressBar({
            duration = 1000,
            label = locale.neonon,
            useWhileDead = false,
            canCancel = true,
            disable = {
                car = true,
            },
        })
        lib.notify({
            title = locale.neon,
            description = locale.neonontifydesc,
            icon = 'paint-roller',
            type = 'inform'
        })
    elseif not neons then
        neons = true
        DisableVehicleNeonLights(vehicle, true, false, false)
        lib.progressBar({
            duration = 1000,
            label = locale.neonoff,
            useWhileDead = false,
            canCancel = true,
            disable = {
                car = true,
            },
        })
        lib.notify({
            title = locale.neon,
            description = locale.neonoffnotifydesc,
            icon = 'paint-roller',
            type = 'inform'
        })
    end	
end)

RegisterNetEvent('bandzukac_carmenu:opendoorsmenu', function(data)
    lib.registerContext({
        id = 'bandzukac_carmenu_doors',
        title = locale.doortitle,
        options = {
            {
                title = locale.leftfront,
                icon = 'door-closed',
                description = locale.doordesc,
                event = 'bandzukac_carmenu:driversdoors',
                onSelect = function()
                    lib.showContext('bandzukac_carmenu_doors')
                end
            },
            {
                title = locale.rightfront,
                description = locale.doordesc,
                icon = 'door-closed',
                event = 'bandzukac_carmenu:passangersdoors',
                onSelect = function()
                    lib.showContext('bandzukac_carmenu_doors')
                end
            },
            {
                title = locale.leftrear,
                description = locale.doordesc,
                icon = 'door-closed',
                event = 'bandzukac_carmenu:backleftdoors',
                onSelect = function()
                    lib.showContext('bandzukac_carmenu_doors')
                end
            },
            {
                title = locale.rightrear,
                description = locale.doordesc,
                icon = 'door-closed',
                event = 'bandzukac_carmenu:backtrightdoors',
                onSelect = function()
                    lib.showContext('bandzukac_carmenu_doors')
                end
            },
            {
                title = locale.hood,
                description = locale.hooddesc,
                icon = 'car-battery',
                event = 'bandzukac_carmenu:hood',
                onSelect = function()
                    lib.showContext('bandzukac_carmenu_doors')
                end
            },
            {
                title = locale.trunk,
                description = locale.trunkdesc,
                icon = 'suitcase',
                event = 'bandzukac_carmenu:trunk',
                onSelect = function()
                    lib.showContext('bandzukac_carmenu_doors')
                end
            },
            {
                title = locale.alldoorsopen,
                description = locale.doordesc,
                icon = 'car',
                event = 'bandzukac_carmenu:openall',
                onSelect = function()
                    lib.showContext('bandzukac_carmenu_doors')
                end
            },
            {
                title = locale.alldoorsclose,
                description = locale.doordesc,
                icon = 'car',
                event = 'bandzukac_carmenu:closeall',
                onSelect = function()
                    lib.showContext('bandzukac_carmenu_doors')
                end
            },
        }
    })
    lib.showContext('bandzukac_carmenu_doors')
end)

local fronleftdoors = false
local frontrightdoors = false
local backleftdoors = false
local backrightdoors = false
local trunk = false
local hood = false
RegisterNetEvent("bandzukac_carmenu:driversdoors", function()
    if not fronleftdoors then
        fronleftdoors = true
        SetVehicleDoorOpen(vehicle, 0, false)
    elseif fronleftdoors then
        fronleftdoors = false
        SetVehicleDoorShut(vehicle, 0, false)
    end
end)

RegisterNetEvent("bandzukac_carmenu:passangersdoors", function()
    if not frontrightdoors then
        frontrightdoors = true
        SetVehicleDoorOpen(vehicle, 1, false)
    elseif frontrightdoors then
        frontrightdoors = false
        SetVehicleDoorShut(vehicle, 1, false)
    end
end)

RegisterNetEvent("bandzukac_carmenu:backleftdoors", function()
    if not backleftdoors then
        backleftdoors = true
        SetVehicleDoorOpen(vehicle, 2, false)
    elseif backleftdoors then
        backleftdoors = false
        SetVehicleDoorShut(vehicle, 2, false)
    end
end)

RegisterNetEvent("bandzukac_carmenu:backtrightdoors", function()
    if not backrightdoors then
        backrightdoors = true
        SetVehicleDoorOpen(vehicle, 3, false)
    elseif backrightdoors then
        backrightdoors = false
        SetVehicleDoorShut(vehicle, 3, false)
    end
end)

RegisterNetEvent("bandzukac_carmenu:trunk", function()
    if not trunk then
        trunk = true
        SetVehicleDoorOpen(vehicle, 5, false)
    elseif trunk then
        trunk = false
        SetVehicleDoorShut(vehicle, 5, false)
    end
end)

RegisterNetEvent("bandzukac_carmenu:hood", function()
    if not backrightdoors then
        backrightdoors = true
        SetVehicleDoorOpen(vehicle, 4, false)
    elseif backrightdoors then
        backrightdoors = false
        SetVehicleDoorShut(vehicle, 4, false)
    end
end)

RegisterNetEvent("bandzukac_carmenu:openall", function()
    local player = PlayerPedId()
	local vehicle = GetVehiclePedIsIn(player,false)

    for i = 0, 5 do
        SetVehicleDoorOpen(vehicle, i, false)
    end
end)

RegisterNetEvent("bandzukac_carmenu:closeall", function()
    local player = PlayerPedId()
	local vehicle = GetVehiclePedIsIn(player,false)

    for i = 0, 5 do
        SetVehicleDoorShut(vehicle, i, false)
    end	
end)

RegisterNetEvent('bandzukac_carmenu:openwindowsmenu', function(data)
    lib.registerContext({
        id = 'bandzukaccarmenu_windows',
        title = locale.windowtitle,
        onExit = function()
        end,
        options = {
            {
                title = locale.leftfrontwindow,
                description = locale.windowdescmenu,
                icon = 'window-maximize',
                event = 'bandzukac_carmenu:driverswindow',
                onSelect = function()
                    lib.showContext('bandzukaccarmenu_windows')
                end
            },
            {
                title = locale.rightfrontwindow,
                description = locale.windowdescmenu,
                icon = 'window-maximize',
                event = 'bandzukac_carmenu:passangerswindow',
                onSelect = function()
                    lib.showContext('bandzukaccarmenu_windows')
                end
            },
            {
                title = locale.leftrearwindow,
                description = locale.windowdescmenu,
                icon = 'window-maximize',
                event = 'bandzukac_carmenu:backleftwindow',
                onSelect = function()
                    lib.showContext('bandzukaccarmenu_windows')
                end
            },
            {
                title = locale.rightrearwindow,
                description = locale.windowdescmenu,
                icon = 'window-maximize',
                event = 'bandzukac_carmenu:backtightwindow',
                onSelect = function()
                    lib.showContext('bandzukaccarmenu_windows')
                end
            },
            {
                title = locale.alldoorsopenwindow,
                icon = 'car',
                event = 'bandzukac_carmenu:openallwindows',
                onSelect = function()
                    lib.showContext('bandzukaccarmenu_windows')
                end
            },
            {
                title = locale.alldoorsclosewindow,
                icon = 'car',
                event = 'bandzukac_carmenu:closeallwindows',
                onSelect = function()
                    lib.showContext('bandzukaccarmenu_windows')
                end
            },
        }
    })
    lib.showContext('bandzukaccarmenu_windows')
end)

local leftfrontwindows = true
local rightfrontwindows = true
local leftbackwindow = true
local rightbackwindow = true
RegisterNetEvent("bandzukac_carmenu:driverswindow", function()
    if not leftfrontwindows then
        leftfrontwindows = true
        RollUpWindow(vehicle, 0, false)
    elseif leftfrontwindows then
        leftfrontwindows = false
        RollDownWindow(vehicle, 0, false)
    end
end)

RegisterNetEvent("bandzukac_carmenu:passangerswindow", function()
    if not leftfrontwindows then
        leftfrontwindows = true
        RollUpWindow(vehicle, 1, false)
    elseif leftfrontwindows then
        leftfrontwindows = false
        RollDownWindow(vehicle, 1, false)
    end
end)

RegisterNetEvent("bandzukac_carmenu:backleftwindow", function()
    if not leftfrontwindows then
        leftfrontwindows = true
        RollUpWindow(vehicle, 2, false)
    elseif leftfrontwindows then
        leftfrontwindows = false
        RollDownWindow(vehicle, 2, false)
    end
end)

RegisterNetEvent("bandzukac_carmenu:backtightwindow", function()
    if not leftfrontwindows then
        leftfrontwindows = true
        RollUpWindow(vehicle, 3, false)
    elseif leftfrontwindows then
        leftfrontwindows = false
        RollDownWindow(vehicle, 3, false)
    end
end)

RegisterNetEvent("bandzukac_carmenu:closeallwindows", function()
    local player = PlayerPedId()
	local vehicle = GetVehiclePedIsIn(player,false)

    RollDownWindows(vehicle)
end)

RegisterNetEvent("bandzukac_carmenu:openallwindows", function()
    local player = PlayerPedId()
	local vehicle = GetVehiclePedIsIn(player,false)

    for i = 0, 5 do
        RollUpWindow(vehicle, i, false)
    end	
end)

RegisterNetEvent('bandzukac_carmenu:seat', function(data)
    lib.registerContext({
        id = 'bandzukaccarmenu_seat',
        title = locale.seat,
        options = {
            {
                title =  locale.seat1,
                icon = 'chair',
                description = locale.seatdesc,
                event = 'bandzukac_carmenu:seat:driver',
                onSelect = function()
                    lib.showContext('bandzukaccarmenu_seat')
                end
            },
            {
                title = locale.seat2,
                icon = 'chair',
                description = locale.seatdesc,
                event = 'bandzukac_carmenu:seat:codriver',
                onSelect = function()
                    lib.showContext('bandzukaccarmenu_seat')
                end
            },
            {
                title =  locale.seat3,
                icon = 'chair',
                description = locale.seatdesc,
                event = 'bandzukac_carmenu:seat:backleftdriver',
                onSelect = function()
                    lib.showContext('bandzukaccarmenu_seat')
                end
            },
            {
                title =  locale.seat4,
                icon = 'chair',
                description = locale.seatdesc,
                event = 'bandzukac_carmenu:seat:backrightdriver',
                onSelect = function()
                    lib.showContext('bandzukaccarmenu_seat')
                end
            },
        },
    })
    lib.showContext('bandzukaccarmenu_seat')
end)

RegisterNetEvent("bandzukac_carmenu:seat:driver", function()
    lib.progressBar({
        duration = 1000,
        label = locale.seatchanging,
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = true,
        },
    })
    ExecuteCommand('seat 1')
end)

RegisterNetEvent("bandzukac_carmenu:seat:codriver", function()
    lib.progressBar({
        duration = 1000,
        label = locale.seatchanging,
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = true,
        },
    })
    ExecuteCommand('seat 2')
end)

RegisterNetEvent("bandzukac_carmenu:seat:backleftdriver", function()
    lib.progressBar({
        duration = 1000,
        label = locale.seatchanging,
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = true,
        },
    })
    ExecuteCommand('seat 3')
end)

RegisterNetEvent("bandzukac_carmenu:seat:backrightdriver", function()
    lib.progressBar({
        duration = 1000,
        label = locale.seatchanging,
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = true,
        },
    })
    ExecuteCommand('seat 4')
end)

function SeatControl(seat)
	local playerPed = GetPlayerPed(-1)
	if (IsPedSittingInAnyVehicle(playerPed)) then
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		if IsVehicleSeatFree(vehicle, seat) then
			SetPedIntoVehicle(GetPlayerPed(-1), vehicle, seat)
		end
	end
end

TriggerEvent('chat:addSuggestion', '/seat', {
})

RegisterCommand("seat", function(source, args, rawCommand)
    local seatID = tonumber(args[1])
    if seatID ~= nil then
        if seatID == 1 then
            SeatControl(-1)
        elseif seatID == 2 then
            SeatControl(0)
        elseif seatID == 3 then
            SeatControl(1)
        elseif seatID == 4 then
            SeatControl(2)
        end
    end
end, false)