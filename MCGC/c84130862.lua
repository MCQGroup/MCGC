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
    e2:SetCondition(c84130862.graveCondition)
    e2:SetCost(c84130862.graveCost)
    e2:SetTarget(c84130862.graveTarget)
    e2:SetOperation(c84130862.graveOperation)
    c:RegisterEffect(e2)
end

function c84130862.activate(e, tp, eg, ep, ev, re, r, rp)
    local g = Duel.GetMatchingGroup( function(c)
        return c:IsSetCard(0x2222) and not c:IsImmuneToEffect(e)
    end , tp, LOCATION_MZONE, 0, nil)
    local c = g:GetFirst()
    while c do
        local e1 = Effect.CreateEffect(e:GetHandler())
        e1:SetType(EFFECT_TYPE_SINGLE)
        e1:SetCode(EFFECT_UPDATE_ATTACK)
        e1:SetValue(700)
        c:RegisterEffect(e1)

        local e2 = Effect.CreateEffect(e:GetHandler())
        e2:SetType(EFFECT_TYPE_SINGLE)
        e2:SetCode(EFFECT_DISABLE)
        e2:SetReset(RESET_EVENT + RESET_LEAVE + RESET_TODECK + RESET_TOGRAVE + RESET_TOHAND + RESET_TURN_SET + RESET_REMOVE)
        c:RegisterEffect(e2)

        local e3 = Effect.CreateEffect(e:GetHandler())
        e3:SetCode(EFFECT_DISABLE_EFFECT)
        c:RegisterEffect(e3)

        c = g:GetNext()
    end
end

function c84130862.graveCondition(e, tp, eg, ep, ev, re, r, rp)
    return Duel.GetTurnPlayer() == tp and e:GetHandler():GetTurnID() ~= Duel.GetTurnCount()
end

function c84130862.graveCost(e, tp, eg, ep, ev, re, r, rp, chk)
    if chk == 0 then
        return true
    end
    Duel.Remove(e:GetHandler(), POS_FACEUP, REASON_COST)
end

function c84130862.graveTarget(e, tp, eg, ep, ev, re, r, rp, chk, chkc)
    if chk == 0 then
        return Duel.IsExistingMatchingCard( function(c)
            return c:IsType(TYPE_MONSTER) and c:IsCanBeEffectTarget(e)
        end , tp, LOCATION_ONFIELD, LOCATION_ONFIELD, 1, nil)
    end
    local g = Duel.SelectMatchingCard(tp, function(c)
        return c:IsType(TYPE_MONSTER) and c:IsCanBeEffectTarget(e)
    end , tp, LOCATION_ONFIELD, LOCATION_ONFIELD, 1, 1, nil)
    Duel.SetTargetCard(g)
    Duel.SetOperationInfo(0, CATEGORY_ATKCHANGE, g, g:GetCount(), nil, nil)
end

function c84130862.graveOperation(e, tp, eg, ep, ev, re, r, rp)
    local g = Duel.GetChainInfo(0, CHAININFO_TARGET_CARDS)
    local c = g:GetFirst()
    local e1 = Effect.CreateEffect(e:GetHandler())
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetCode(EFFECT_UPDATE_ATTACK)
    e1:SetValue(500)
    e1:SetReset(RESET_EVENT + RESET_LEAVE + RESET_TODECK + RESET_TOGRAVE + RESET_TOHAND + RESET_TURN_SET + RESET_REMOVE)
    c:RegisterEffect(e1)
end
-- endregion
