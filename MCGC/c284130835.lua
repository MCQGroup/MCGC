-- MC群的挂比 要触

function c284130835.initial_effect(c)
    -- 不能特殊召唤
    local e1 = Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE + EFFECT_FLAG_UNCOPYABLE)
    e1:SetCode(EFFECT_SPSUMMON_CONDITION)
    c:RegisterEffect(e1)

    -- 昆虫
    local e2 = Effect.CreateEffect(c)
    e2:SetType(EFFECT_TYPE_SINGLE)
    e2:SetCode(EFFECT_FORBIDDEN)
    e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE + EFFECT_FLAG_CANNOT_DISABLE + EFFECT_FLAG_SET_AVAILABLE)
    e2:SetTarget(c284130835.banTarget)
    c:RegisterEffect(e2)

    local e3 = e2:Clone()
    e3:SetCode(EFFECT_DISABLE)
    c:RegisterEffect(e3)

    -- 攻击力上升场上的卡的数量
    local e4 = Effect.CreateEffect(c)
    e4:SetType(EFFECT_TYPE_SINGLE)
    e4:SetCode(EFFECT_UPDATE_ATTACK)
    e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
    e4:SetRange(LOCATION_MZONE)
    e4:SetValue(c284130835.updateAtk)
    c:RegisterEffect(e4)

    -- 破坏送墓触发
    local e5 = Effect.CreateEffect(c)
    e5:SetType(EFFECT_TYPE_SINGLE + EFFECT_TYPE_TRIGGER_O)
    e5:SetCode(EVENT_DESTROY)
    e5:SetTarget(c284130835.destroyTriggerTarget)
    e5:SetOperation(c284130835.destroyTriggerOperation)
    c:RegisterEffect(e5)
end

function c284130835.banFilter(c)
    return c:IsRace(RACE_INSECT) and c:IsFaceup()
end

function c284130835.banTarget(e, c)
    return c:IsCode(284130835) and not c:IsOnField() and Duel.IsExistingMatchingCard(c284130835.banFilter, tp, LOCATION_ONFIELD, LOCATION_ONFIELD, 1, nil)
end

function c284130835.updateAtk(e, c)
    return Duel.GetFieldGroupCount(PLAYER_ALL, LOCATION_ONFIELD, LOCATION_ONFIELD)
end

function c284130835.destroyTriggerTarget(e, tp, eg, ep, ev, re, r, rp, chk, chkc)
    if chkc then
        return chkc:IsDestructable()
    end
    if chk == 0 then
        return Duel.IsExistingMatchingCard(Card.IsDestructable, tp, LOCATION_ONFIELD, LOCATION_ONFIELD, 1, nil)
    end
    local g = Duel.SelectTarget(tp, Card.IsDestructable, tp, LOCATION_ONFIELD, LOCATION_ONFIELD, 1, 1, nil)
    Duel.SetOperationInfo(0, CATEGORY_DESTROY, g, 1, nil, 0)
end

function c284130835.destroyTriggerOperation(e, tp, eg, ep, ev, re, r, rp)
    local g = Duel.GetChainInfo(0, CHAININFO_TARGET_CARDS)
    Duel.Destroy(g, REASON_EFFECT, LOCATION_GRAVE)
end