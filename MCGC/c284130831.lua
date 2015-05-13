-- MC群的追忆 木头
function c284130831.initial_effect(c)
    -- 不能通常召唤
    c:EnableReviveLimit()

    -- 除外延迟特招
    local e1 = Effect.CreateEffect(c)
    c:RegisterEffect(e1)

    -- 不入墓地
    local e2 = Effect.CreateEffect(c)
    c:RegisterEffect(e2)

    -- 手卡丢弃免伤
    local e3 = Effect.CreateEffect(c)
    c:RegisterEffect(e3)
end