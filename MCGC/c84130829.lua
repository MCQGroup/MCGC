-- MC群的班底 奇迹

function c84130829.initial_effect(c)
    -- 不能通常召唤
    c:EnableReviveLimit()

    -- 特召触发特招
    local e2 = Effect.CreateEffect(c)
    e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
    e2:SetType(EFFECT_TYPE_FIELD + EFFECT_TYPE_TRIGGER_O)
    e2:SetCode(EVENT_SPSUMMON_SUCCESS)
    e2:SetProperty(EFFECT_FLAG_UNCOPYABLE + EFFECT_FLAG_DELAY)
    e2:SetRange(LOCATION_HAND + LOCATION_GRAVE)
    e2:SetCondition(c84130829.spSummonCondition)
    e2:SetOperation(c84130829.spSummonOperation)
    c:RegisterEffect(e2)

    -- 攻击宣言触发血祭
    local e3 = Effect.CreateEffect(c)
    e3:SetCategory(CATEGORY_ATKCHANGE + CATEGORY_DEFCHANGE)
    e3:SetType(EFFECT_TYPE_SINGLE + EFFECT_TYPE_TRIGGER_O)
    e3:SetCode(EVENT_ATTACK_ANNOUNCE)
    e3:SetCost(c84130829.attackCost)
    e3:SetOperation(c84130829.attackOperation)
    c:RegisterEffect(e3)
end

function c84130829.filter(c, tp)
    return not c:IsCode(84130829) and c:IsSetCard(0x2222) and c:IsControler(tp) and c:IsPreviousLocation(LOCATION_GRAVE + LOCATION_DECK + LOCATION_REMOVED)
end

function c84130829.spSummonCondition(e, tp, eg, ep, ev, re, r, rp)
    return eg:IsExists(c84130829.filter, 1, nil, tp)
end

function c84130829.spSummonOperation(e, tp, eg, ep, ev, re, r, rp)
    e:GetHandler():CompleteProcedure()
    Duel.SpecialSummon(e:GetHandler(), SUMMON_TYPE_SPECIAL, tp, tp, false, false, POS_FACEUP_ATTACK)
end

function c84130829.attackCost(e, tp, eg, ep, ev, re, r, rp, chk)
    if chk == 0 then
        return true
    end
    local t = { }
    local max = math.min(15, math.floor(Duel.GetLP(tp) / 100))
    for i = 1, max do
        t[i] =(max + 1 - i) * 100
    end
    local attack = Duel.AnnounceNumber(tp, table.unpack(t))
    Duel.PayLPCost(tp, attack)
    e:SetLabel(attack)
end

function c84130829.attackOperation(e, tp, eg, ep, ev, re, r, rp)
    local c = e:GetHandler()

    local e1 = Effect.CreateEffect(c)
    e1:SetCategory(CATEGORY_ATKCHANGE)
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetCode(EFFECT_UPDATE_ATTACK)
    e1:SetReset(RESET_END, 2)
    e1:SetValue(e:GetLabel())
    c:RegisterEffect(e1)

    local e2 = e1:Clone()
    e2:SetCategory(CATEGORY_DEFCHANGE)
    e2:SetCode(EFFECT_UPDATE_DEFENCE)
    c:RegisterEffect(e2)
end
