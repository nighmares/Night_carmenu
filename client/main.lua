
RegisterNetEvent('Night:doors')
AddEventHandler('Night:doors', function(door)
   local abrir = door.abrir

    if abrir == 1 then
	   DoorControl(0)
    elseif abrir == 2 then
	   DoorControl(1)
    elseif abrir == 3 then
	   DoorControl(2)
    elseif abrir == 4 then
		DoorControl(3)  
	elseif abrir == 5 then
		DoorControl(4)
	elseif abrir == 6 then
		DoorControl(5)	
	 	 	 
    end   
	
end)

RegisterNetEvent('Night:doors2')
AddEventHandler('Night:doors2', function()
	local Vehicle = GetVehiclePedIsUsing(PlayerPedId())
    for i = 0, 5 do
		SetVehicleDoorShut(Vehicle, i, false)
	end	
	
end)

function DoorControl(door)

	local playerPed =  PlayerPedId()
	if (IsPedSittingInAnyVehicle(playerPed)) then
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		if GetVehicleDoorAngleRatio(vehicle, door) > 0.0 then
			SetVehicleDoorShut(vehicle, door, false)
		else
			SetVehicleDoorOpen(vehicle, door, false)
		end
	else
		exports['mythic_notify']:SendAlert('inform', 'you arent in a vehicle bud!!')
	end	

end

RegisterNetEvent('Night:engine')
AddEventHandler('Night:engine', function()
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    if vehicle ~= nil and vehicle ~= 0 and GetPedInVehicleSeat(vehicle, 0) then
        SetVehicleEngineOn(vehicle, (not GetIsVehicleEngineRunning(vehicle)), false, true)
    end
end)

RegisterNetEvent('Night:carmenu1', function()
	local playerPed =  PlayerPedId()

	if (IsPedSittingInAnyVehicle(playerPed)) then
		TriggerEvent('nh-context:sendMenu', {
			{
				id = 1,
				header = "Car Menu",
				txt = ""
			},
			{
				id = 2,
				header = "Menu de puertas",
				txt = "[puertas]",
				params = {
					event = "Night:carmenu",
					
				}
			},
			{
				id = 3,
				header = "Motor",
				txt = "[ off/on ]",
				params = {
					event = "Night:engine",
					
				}
			},
			
			
			
		})
	else
		exports['mythic_notify']:SendAlert('inform', 'you arent in a vehicle bud!!')
	end	


    
end)


RegisterNetEvent('Night:carmenu', function()
	local playerPed =  PlayerPedId()

	TriggerEvent('nh-context:sendMenu', {
		{
			id = 1,
			header = "◀",
			txt = "",
			params = {
				event = "Night:carmenu1",
				args = {
					
				}
			}
		},
		{
			id = 2,
			header = "puerta izquierda",
			txt = "[puertas]",
			params = {
				event = "Night:doors",
				args = {
					abrir = 1,
					
				}
			}
		},
		{
			id = 3,
			header = "puerta derecha",
			txt = "[puertas]",
			params = {
				event = "Night:doors",
				args = {
					abrir = 2,
					
				}
			}
		},
		{
			id = 4,
			header = "puerta trasera izquierda",
			txt = "[puertas traseras]",
			params = {
				event = "Night:doors",
				args = {
					abrir = 3,
					
				}
			}
		},
		{
			id = 5,
			header = "puerta trasera derecha",
			txt = "[puertas traseras]",
			params = {
				event = "Night:doors",
				args = {
					abrir = 4,
					
				}
			}
		},
		{
			id = 6,
			header = "Abrir capote",
			txt = "[capote]",
			params = {
				event = "Night:doors",
				args = {
					abrir = 5,
					
				}
			}
		},
		{
			id = 7,
			header = "Abrir cajuela",
			txt = "[cajuela]",
			params = {
				event = "Night:doors",
				args = {
					abrir = 6,
					
				}
			}
		},
		{
			id = 8,
			header = "Cerrar todas las puertas",
			txt = "",
			params = {
				event = "Night:doors2",
				args = {
					
				}
			}
		},
		
		
	}) 
end)

RegisterCommand("carmenu", function(source, args, rawCommand)
   TriggerEvent('Night:carmenu1')
end)

RegisterKeyMapping('carmenu', '(Player) open car menu', 'keyboard', 'J')