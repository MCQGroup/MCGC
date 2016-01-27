-- region *.lua
-- 2015-11-25
-- 此文件由[BabeLua]插件自动生成

-- MC群的二小姐 柠檬

function c84130849.initial_effect(c)
    -- 超量
    c:EnableReviveLimit()
    aux.AddXyzProcedure(c, c84130849.xyzFilter, 6, 4, c84130849.ovFilter, false)

    -- 超量成功触发
    local e1 = Effect.CreateEffect(c)
    e1:SetCategory(CATEGORY_REMOVE)
    e1:SetType(EFFECT_TYPE_TRIGGER_O)
    e1:SetCode(EVENT_SPSUMMON_SUCCESS)
    e1:SetCondition(c84130849.xyzSuccessCondition)
    e1:SetOperation(c84130849.xyzSuccessOperation)
    c:RegisterEffect(e1)

    -- 不会被战斗破坏
    local e2 = Effect.CreateEffect(c)
    e2:SetType(EFFECT_TYPE_SINGLE)
    e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
    e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
    c:RegisterEffect(e2)

    -- 双方结束阶段必发
    local e3 = Effect.CreateEffect(c)
    e3:SetCategory(CATEGORY_DICE)
    e3:SetType(EFFECT_TYPE_TRIGGER_F)
    e3:SetCode(EVENT_PHASE + PHASE_END)
    e3:SetOperation(c84130849.endTurnOperation)
    e3:SetCountLimit(1, 84130849)
    c:RegisterEffect(e3)
end

function c84130849.filter(c)
    return c:IsSetCard(0x2222)
end

function c84130849.xyzFilter(c)
    return c84130849.filter(c) and c:IsType(TYPE_MONSTER)
end

function c84130849.ovFilter(c)
    return c:IsCode(84130830)
end

function c84130849.xyzSuccessCondition(e, tp, eg, ep, ev, re, r, rp)
    local c = e:GetHandler()
    return bit.band(c:GetSummonType(), SUMMON_TYPE_XYZ) == SUMMON_TYPE_XYZ and c:GetMaterial():IsExists(Card.IsCode, 1, nil, 84130830)
end

function c84130849.xyzSuccessOperation()
    local g = Duel.SelectMatchingCard(tp, Card.IsAbleToRemove, tp, 0, LOCATION_GRAVE, 2, 2, nil, tp)
    Duel.Remove(g, POS_FACEUP, REASON_EFFECT)
end

function c84130849.endTurnOperation()
    local dice = Duel.TossDice(tp, 1, 0)
    if dice == 1 then
        Duel.Draw(tp, 1, REASON_EFFECT)
    elseif dice == 2 then
        local g = Duel.SelectMatchingCard(tp, Card.IsDestructable, tp, LOCATION_ONFIELD, LOCATION_ONFIELD, 1, 1, nil)
        Duel.Destroy(g, REASON_EFFECT, LOCATION_GRAVE)
    elseif dice == 3 then
        Duel.Damage(tp, 1000, REASON_EFFECT)
    elseif dice == 4 then
        local val = 500 * Duel.GetMatchingGroupCount(Card.IsType, tp, 0, LOCATION_ONFIELD, nil, TYPE_MONSTER)
        Duel.Damage(1 - tp, val, REASON_EFFECT)
    elseif dice == 5 then
        local g1 = Duel.SelectMatchingCard(tp, Card.IsAbleToGrave, tp, LOCATION_HAND, 0, 2, 2, nil)
        local g2 = Duel.SelectMatchingCard(1 - tp, Card.IsAbleToGrave, 1 - tp, LOCATION_HAND, 0, 2, 2, nil)
        local g = Group.CreateGroup()
        g:Merge(g1)
        g:Merge(g2)
        Duel.SendtoGrave(g, REASON_EFFECT)
    elseif dice == 6 then
        Duel.Destroy(e:GetHandler(), REASON_EFFECT, LOCATION_GRAVE)
    end
end
-- endregion
