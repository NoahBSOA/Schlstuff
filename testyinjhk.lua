if not SAM_LOADED then return end

local sam, command, language = sam, sam.command, sam.language

command.set_category("Fun")

sam.command.new("jailid")
    :SetPermission("jailid", "admin")
    :AddArg("steamid")
    :AddArg("length", {optional = true, default = 0, min = 0})
    :AddArg("text", {hint = "reason", optional = true, default = sam.language.get("default_reason")})
    :Help("Jail a player by SteamID, even if they are offline.")
    :OnExecute(function(ply, promise, length, reason)
        local a_name = ply:Name()

        promise:done(function(data)
            local steamid, target = data[1], data[2]
            local duration = length * 60 -- convert minutes to seconds

            if target then
                sam.player.jail(target, duration, reason)

                sam.player.send_message(nil, "jail", {
                    A = ply,
                    T = {target, admin = ply},
                    V = sam.format_length(length),
                    V_2 = reason
                })
            else
                sam.player.jail(steamid, duration, reason)

                sam.player.send_message(nil, "jail", {
                    A = a_name,
                    T = steamid,
                    V = sam.format_length(length),
                    V_2 = reason
                })
            end
        end)
    end)
:End()
