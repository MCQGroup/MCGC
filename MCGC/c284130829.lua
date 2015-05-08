-- MC群的班底 奇迹
-- e4参考[69982329]灵摆转动
function c284130829.initial_effect(c)
    -- 不能通常召唤
    local e1 = Effect.CreateEffect(c)
    e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE + EFFECT_FLAG_UNCOPYABLE)
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetCode(EFFECT_LIMIT_SUMMON_PROC)
    e1:SetCondition(aux.FALSE)
    e1:SetValue(SUMMON_TYPE_ADVANCE)
    c:RegisterEffect(e1)

    local e2 = e1:Clone()
    e2:SetCode(EFFECT_LIMIT_SET_PROC)
    c:RegisterEffect(e2)

    -- 特召触发特招
    local e3 = Effect.CreateEffect(c)
    e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
    e3:SetType(EFFECT_TYPE_FIELD + EFFECT_TYPE_TRIGGER_O)
    e3:SetCode(EVENT_SPSUMMON_SUCCESS)
    e3:SetProperty(EFFECT_FLAG_UNCOPYABLE)
    e3:SetRange(LOCATION_HAND + LOCATION_GRAVE)
    e3:SetCondition(c284130829.spSummonCondition)
    e3:SetOperation(c284130829.spSummonOperation)
    c:RegisterEffect(e3)

    -- 攻击宣言触发血祭
    local e4 = Effect.CreateEffect(c)
    e4:SetCategory(CATEGORY_ATKCHANGE + CATEGORY_DEFCHANGE)
    e4:SetType(EFFECT_TYPE_SINGLE + EFFECT_TYPE_TRIGGER_O)
    e4:SetCode(EVENT_ATTACK_ANNOUNCE)
    e4:SetCost(c284130829.attackCost)
    e4:SetOperation(c284130829.attackOperation)
    c:RegisterEffect(e4)
end

function c284130829.filter(c)
    return not c:IsCode(284130829) and c:IsSetCard(0x2222) and c:IsPreviousLocation(LOCATION_GRAVE + LOCATION_DECK + LOCATION_REMOVED)
    -- 不确定IsPreviousLocation(A+B+C)是否等价于IPL(A) or IPL(B) or IPL(C)，需要测试
end

function c284130829.spSummonCondition(e, tp, eg, ep, ev, re, r, rp)
    return tp == ep and eg:IsExists(c284130829.filter, 1, nil)
end

function c284130829.spSummonOperation(e, tp, eg, ep, ev, re, r, rp)
    Duel.SpecialSummon(e:GetHandler(), SUMMON_TYPE_SPECIAL, tp, tp, false, false, POS_FACEUP_ATTACK)
end

function c284130829.attackCost(e, tp, eg, ep, ev, re, r, rp, chk)
    if chk == 0 then
        return true
    end
    local t = { }
    for i = 1, math.min(15, math.floor(tp:GetLP() / 100)) do
        t[i] = i * 100
    end
    local attack = Duel.AnnounceNumber(tp, table.unpack(t))
    -- 不确定这里的AnnouceNumber是否合适
    e:SetLabel(t[attack])
end

function c284130829.attackOperation(e, tp, eg, ep, ev, re, r, rp)
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
    e1:SetCode(EFFECT_UPDATE_DEFENCE)
    c:RegisterEffect(e2)
end