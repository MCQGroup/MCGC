-- MC群的战神 无情
function c284130811.initial_effect(c)
    -- 不能特殊召唤
    local e1 = Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE + EFFECT_FLAG_UNCOPYABLE)
    e1:SetCode(EFFECT_SPSUMMON_CONDITION)
    c:RegisterEffect(e1)

    -- 攻击守备上升
    self.atk = 0
    self.def = 0
    local e2 = Effect.CreateEffect(c)
    e2:SetCategory(CATEGORY_ATKCHANGE + CATEGORY_REMOVE)
    e2:SetType(EFFECT_TYPE_TRIGGER_F + EFFECT_TYPE_SINGLE)
    e2:SetCode(EVENT_SUMMON_SUCCESS)
    e2:SetCost(c284130811.cost)
    e2:SetOperation(c284130811.operation)
    c:RegisterEffect(e2)

    -- 不能直接攻击
    local e3 = Effect.CreateEffect(c)
    e3:SetType(EFFECT_TYPE_SINGLE)
    e3:SetCode(EFFECT_CANNOT_DIRECT_ATTACK)
    e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
    c:RegisterEffect(e3)
end

function c284130811.filter(c)
    return c:IsAbleToRemove()
end

function c284130811.zhishui(c)
    return c:IsCode(284130812) and c:IsFaceup()
end

function c284130811.cost(e, tp, eg, ep, ev, re, r, rp, chk)
    if chk == 0 then
        return Duel.GetMatchingGroupCount(c284130811.filter, tp, LOCATION_GRAVE, 0) > 0 and Duel.GetMatchingGroupCount(c284130811.filter, tp, LOCATION_HAND, 0) > 0 and Duel.GetMatchingGroupCount(c284130811.filter, tp, LOCATION_DECK, 0) > 0
    end
    Duel.Hint(HINT_SELECTMSG, tp, HINTMSG_REMOVE)
    local g1 = Duel.SelectMatchingCard(tp, c284130811.filter, tp, LOCATION_GRAVE, 0, 1, 1, nil)
    local g2 = Duel.SelectMatchingCard(tp, c284130811.filter, tp, LOCATION_HAND, 0, 1, 1, nil)
    local g3 = Duel.SelectMatchingCard(tp, c284130811.filter, tp, LOCATION_DECK, 0, 1, 1, nil)
    local g = Group.CreateGroup()
    g:Merge(g1)
    g:Merge(g2)
    g:Merge(g3)
    Duel.SetOperationInfo(0, CATEGORY_REMOVE, g, g:GetCount(), 0, 0)
    Duel.Remove(g, POS_FACEUP, REASON_EFFECT)
    self.atk = g:GetSum(Card.GetAttack)
    self.def = g:GetSum(Card.GetDefence)
end

function c284130811.operation(e, tp, eg, ep, ev, re, r, rp)
    local atkUp = self.atk
    local defUp = self.def
    local c = e:GetHandler()
    local e1 = Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetCode(EFFECT_UPDATE_ATTACK)
    e1:SetReset(RESET_EVENT + 0x1ff0000)
    e1:SetProperty(EFFECT_FLAG_COPY_INHERIT)
    local isZhishui = Duel.IsExistingMatchingCard(c284130811.zhishui, tp, LOCATION_MZONE, 0, 1, nil)
    if isZhishui then
        e1:SetValue(atkUp)
    else
        e1:SetValue(atkUp / 2)
    end
    c:RegisterEffect(e1)

    local e2 = e1:Clone()
    e2:SetCode(EFFECT_UPDATE_DEFENCE)
    if isZhishui then
        e2:SetValue(defUp)
    else
        e2:SetValue(defUp / 2)
    end
    c:RegisterEffect(e2)
end