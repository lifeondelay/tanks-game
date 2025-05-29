local Callbacks = {}

function Callbacks.onBeginContact(a, b, coll)
    local o1 = a:getUserData()
    local o2 = b:getUserData()
    if o1 and o2 then
        print(o1.tag ..  ", " .. o2.tag)
        if o1.tag == "destructible" and o2.tag == "destructible" then
            o1:doDamage(o2.damage)
            o2:doDamage(o1.damage)
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