local Callbacks = {}

function Callbacks.onBeginContact(a, b, coll)
    local o1, o2 = a:getUserData(), b:getUserData()
    if (o1 or o2) then
        target.hit = true
    end
end

function Callbacks.onEndContact(a, b, coll)
    local ob1, ob2 = a.fixture:getUserData(), b.fixture:getUserData()
end