-- MC群的战神 无情

function c84130811.initial_effect(c)
    -- 不能特殊召唤
    local e1 = Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE + EFFECT_FLAG_UNCOPYABLE)
    e1:SetCode(EFFECT_SPSUMMON_CONDITION)
    c:RegisterEffect(e1)

    -- 攻击守备上升
    local e2 = Effect.CreateEffect(c)
    e2:SetCategory(CATEGORY_ATKCHANGE + CATEGORY_DEFCHANGE + CATEGORY_REMOVE)
    e2:SetType(EFFECT_TYPE_TRIGGER_O + EFFECT_TYPE_SINGLE)
    e2:SetCode(EVENT_SUMMON_SUCCESS)
    e2:SetCost(c84130811.cost)
    e2:SetOperation(c84130811.operation)
    c:RegisterEffect(e2)

    -- 战斗伤害为0
    local e3 = Effect.CreateEffect(c)
    e3:SetType(EFFECT_TYPE_SINGLE)
    e3:SetCode(EFFECT_NO_BATTLE_DAMAGE)
    c:RegisterEffect(e3)
end

function c84130811.filter(c)
    return c:IsAbleToRemove()
end

function c84130811.zhishui(c)
    return c:IsCode(84130812) and c:IsFaceup()
end

function c84130811.cost(e, tp, eg, ep, ev, re, r, rp, chk)
    if chk == 0 then
        return Duel.GetMatchingGroupCount(c84130811.filter, tp, LOCATION_GRAVE, 0, nil) > 0 and Duel.GetMatchingGroupCount(c84130811.filter, tp, LOCATION_HAND, 0, nil) > 0 and Duel.GetMatchingGroupCount(c84130811.filter, tp, LOCATION_DECK, 0, nil) > 0
    end
    Duel.Hint(HINT_SELECTMSG, tp, HINTMSG_REMOVE)
    local g1 = Duel.SelectMatchingCard(tp, c84130811.filter, tp, LOCATION_GRAVE, 0, 1, 1, nil)
    local g2 = Duel.SelectMatchingCard(tp, c84130811.filter, tp, LOCATION_HAND, 0, 1, 1, nil)
    local g3 = Duel.SelectMatchingCard(tp, c84130811.filter, tp, LOCATION_DECK, 0, 1, 1, nil)
    local g = Group.CreateGroup()

    if g1 then
        g:Merge(g1)
    end

    if g2 then
        g:Merge(g2)
    end

    if g3 then
        g:Merge(g3)
    end

    Duel.SetOperationInfo(0, CATEGORY_ATKCHANGE + CATEGORY_DEFCHANGE, g, g:GetCount(), nil, 0)
    Duel.Remove(g, POS_FACEUP, REASON_COST)
end

function c84130811.operation(e, tp, eg, ep, ev, re, r, rp)
    local test, g = Duel.GetOperationInfo(0, CATEGORY_ATKCHANGE + CATEGORY_DEFCHANGE)
    if test then
        local atkUp = g:GetSum(Card.GetAttack)
        local defUp = g:GetSum(Card.GetDefence)
        local c = e:GetHandler()
        local isZhishui = Duel.IsExistingMatchingCard(c84130811.zhishui, tp, LOCATION_MZONE, 0, 1, nil)

        local e1 = Effect.CreateEffect(c)
        e1:SetType(EFFECT_TYPE_SINGLE)
        e1:SetCode(EFFECT_UPDATE_ATTACK)
        e1:SetReset(RESET_EVENT + 0x1ff0000)
        e1:SetProperty(EFFECT_FLAG_COPY_INHERIT)
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
end