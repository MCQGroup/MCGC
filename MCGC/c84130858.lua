-- region *.lua
-- Date
-- 此文件由[BabeLua]插件自动生成

-- MC群的日常
function c84130858.initial_effect(c)
    local e1 = Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_ACTIVATE)
    e1:SetCode(EVENT_FREE_CHAIN)
    c:RegisterEffect(e1)

    local e2 = Effect.CreateEffect(c)
    e2:SetType(EFFECT_TYPE_FIELD + EFFECT_TYPE_TRIGGER_O)
    e2:SetCode(EVENT_PHASE + PHASE_STANDBY)
    e2:SetRange(LOCATION_SZONE)
    e2:SetCondition(c84130858.condition)
    e2:SetOperation(c84130858.operation)
    c:RegisterEffect(e2)
end

function c84130858.condition(e, tp, eg, ep, ev, re, r, rp)
    return Duel.GetFieldGroupCount(tp, LOCATION_HAND, 0) > 0
end

function c84130858.operation(e, tp, eg, ep, ev, re, r, rp)
    Duel.Hint(HINT_MESSAGE, 1 - tp, HINTMSG_OPPO)
    local g = Duel.SelectMatchingCard(1 - tp, aux.TRUE, tp, LOCATION_HAND, 0, 1, 1, nil)
    Duel.ConfirmCards(1 - tp, g)
    local c = g:GetFirst()
    if c:IsSetCard(0x2222) then
        if c:IsType(TYPE_MONSTER) then
            -- 额外召唤
            local e1 = Effect.CreateEffect(e:GetHandler())
            Duel.RegisterEffect(e1, tp)
        elseif c:IsType(TYPE_SPELL) then
            -- 回复
            Duel.Recover(tp, Duel.GetFieldGroupCount(tp, LOCATION_HAND, 0) * 300, REASON_EFFECT)
        elseif c:IsType(TYPE_TRAP) then
            -- 封印
        end
    else
        Duel.Destroy(c, REASON_EFFECT, LOCATION_GRAVE)
    end
end
-- endregion
