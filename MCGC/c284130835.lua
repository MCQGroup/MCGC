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
    e2:SetType(EFFECT_TYPE_FIELD)
    e2:SetCode(EFFECT_FORBIDDEN)
    e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE + EFFECT_FLAG_SET_AVAILABLE + EFFECT_FLAG_SINGLE_RANGE)
    e2:SetTarget(c284130835.banTarget)
    c:RegisterEffect(e2)

    -- 攻击力上升场上的卡的数量
    local e3 = Effect.CreateEffect(c)
    e3:SetType(EFFECT_TYPE_SINGLE)
    e3:SetCode(EFFECT_UPDATE_ATTACK)
    e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
    e3:SetRange(LOCATION_MZONE)
    e3:SetValue(c284130835.updateAtk)
    c:RegisterEffect(e3)

    -- 破坏送墓触发
    local e4 = Effect.CreateEffect(c)
    e4:SetType(EFFECT_TYPE_SINGLE + EFFECT_TYPE_TRIGGER_O)
    e4:SetCode(EVENT_DESTROY)
    e4:SetProperty(EFFECT_FLAG_CARD_TARGET)
    e4:SetTarget(c284130835.destroyTriggerTarget)
    e4:SetOperation(c284130835.destroyTriggerOperation)
    c:RegisterEffect(e4)
end

function c284130835.banFilter(c)
    return c:IsRace(RACE_INSECT) and c:IsFaceup()
end

function c284130835.banTarget(e, c)
    return Duel.IsExistingMatchingCard(c284130835.banFilter, tp, LOCATION_ONFIELD, LOCATION_ONFIELD, 1, nil)
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