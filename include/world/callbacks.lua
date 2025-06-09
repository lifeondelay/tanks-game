local Callbacks = {}
local Utility = require("include.utility")

function Callbacks.onBeginContact(a, b, coll)
    local o1 = a:getUserData()
    local o2 = b:getUserData()
    local wall = nil
    local notWall = nil

    if o1 and o2 and o1.tags and o2.tags then

        if Utility:tableContains(o1.tags, "wall") then
            wall = o1
            notWall = o2
        elseif Utility:tableContains(o2.tags,"wall") then
            wall = o2
            notWall = o1
        end

        if wall and notWall and Utility:tableContains(notWall.tags, "projectile") then
            print("hitwall")
            notWall:doDamage(notWall.health)
            return
        end

        -- print(o1.tag ..  ", " .. o2.tag)
        if Utility:tableContains(o1.tags, "destructible") and Utility:tableContains(o2.tags, "destructible") then

            if o2.parent and Utility:tableContains(o2.parent.tags, "player") and o1.parent and Utility:tableContains(o1.parent.tags, "player") then
                -- do nothing if the owner of both destructibles is the player
                return
            end

            -- Apply damage to both objects
            o1:doDamage(o2.damage)
            o2:doDamage(o1.damage)

            if o1.parent then
                print(o1.parent.tags)
            end

            if o1.parent and Utility:tableContains(o1.parent.tags, "player") and o2.destroyed == true then
                o1.parent:addExperience(o2.score)
            elseif o2.parent and Utility:tableContains(o2.parent.tags, "player") and o1.destroyed == true then
                o2.parent:addExperience(o1.score)
            end
        end
    end
end

function Callbacks.onEndContact(a, b, coll)
    -- print("end contact")
    -- local x, y = coll:getNormal()
    -- local ob1, ob2 = a:getUserData(), b:getUserData()
    -- print(ob1 .. ", " .. ob2)
end

function Callbacks.onPreSolve(a, b, coll)
-- print("pre solve")
end

function Callbacks.onPostSolve(a, b, coll, normalImpulse, tangentImpulse)
-- print("post solve")
end

return Callbacks