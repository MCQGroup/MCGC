-- region *.lua
-- Date 2016-03-20
-- 此文件由[BabeLua]插件自动生成

-- MC群暴动
function c84130862.initial_effect(c)
    -- 发动
    local e1 = Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_ACTIVATE)
    e1:SetCode(EVENT_FREE_CHAIN)
    e1:SetOperation(c84130862.activate)
    c:RegisterEffect(e1)

    -- 墓地除外
    local e2 = Effect.CreateEffect(c)
    e2:SetType(EFFECT_TYPE_IGNITION)
    e2:SetCode(EVENT_FREE_CHAIN)
    e2:SetRange(LOCATION_GRAVE)
    e2:SetCondition()
    e2:SetCost()
    e2:SetTarget()
    e2:SetOperation()
    c:RegisterEffect(e2)
end

function c84130862.activate(e, tp, eg, ep, ev, re, r, rp)
    local g = Duel.GetMatchingGroup( function(c)
        return c:IsSetCard(0x2222) and c:IsImmuneToEffect(e)
    end , tp, LOCATION_MZONE, 0, nil)
    local c = g:GetFirst()
    while c do
        local e1 = Effect.CreateEffect(c)
        e1:SetType(EFFECT_TYPE_SINGLE)
        e1:SetCode(EFFECT_UPDATE_ATTACK)
        e1:SetValue(700)
        c:RegisterEffect(e1)

        local e2 = Effect.CreateEffect(c)
        e2:SetType(EFFECT_TYPE_SINGLE)
        e2:SetCode(EFFECT_DISABLE)
        e2:SetReset(RESET_EVENT + RESET_LEAVE + RESET_TODECK + RESET_TOGRAVE + RESET_TOHAND)
        -- 和什么什么
        c:RegisterEffect(e2)

        c = g:GetNext()
    end
end

-- endregion
