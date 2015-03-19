-- MC群的软妹 玲音

function c284130816.initial_effect(c)
    -- 灵摆召唤
    aux.AddPendulumProcedure(c)
    -- 发动
    local e1 = Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_ACTIVATE)
    e1:SetCode(EVENT_FREE_CHAIN)
    c:RegisterEffect(e1)

    -- 特招限制
    local e2 = Effect.CreateEffect(c)
    e2:SetRange(LOCATION_PZONE)
    e2:SetType(EFFECT_TYPE_FIELD)
    e2:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
    e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET + EFFECT_FLAG_CANNOT_DISABLE)
    e2:SetTargetRange(1, 0)
    e2:SetTarget(c284130816.specialSummonLimit)
    c:RegisterEffect(e2)

    -- 除外抽卡
    local e3 = Effect.CreateEffect(c)
    e3:SetCategory(CATEGORY_REMOVE + CATEGORY_DRAW)
    c:RegisterEffect(e3)

    -- 无祭品普招
    local e4 = Effect.CreateEffect(c)
    c:RegisterEffect(e4)

    -- 加入手卡
    local e5 = Effect.CreateEffect(c)
    e5:SetCategory(CATEGORY_TOHAND)
    c:RegisterEffect(e5)
end

function c284130816.filter(c)
    return c:IsSetCard(0x2222)
end

function c284130816.specialSummonLimit(e, c)
    return not c284130816.filter(c)
end

function c284130816.drawCost(e, tp, eg, ep, ev, re, r, rp, chk)
end

function c284130816.drawOperation(e, tp, eg, ep, ev, re, r, rp)
end