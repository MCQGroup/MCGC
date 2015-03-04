-- MC群的苦逼 DZ
function c284130813.initial_effect(c)
    -- 反转召唤
    local e1 = Effect.CreateEffect(c)
    e1:SetCategory(CATEGORY_DAMAGE)
    e1:SetType(EFFECT_TYPE_SINGLE + EFFECT_TYPE_TRIGGER_F)
    e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
    e1:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
    e1:SetOperation(c284130813.destroyOperation)
    c:RegisterEffect(e2)

    -- 不会被战斗破坏
    local e2 = Effect.CreateEffect(c)
    e2:SetType(EFFECT_TYPE_SINGLE)
    e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
    e2:SetValue(1)
    c:RegisterEffect(e2)
    -- 卡组检索、特招、送墓
end

function c284130813.destroyOperation(e, tp, eg, ep, ev, re, r, rp)
    c = e:GetController()
    Duel.Destroy(c, REASON_EFFECT)
end