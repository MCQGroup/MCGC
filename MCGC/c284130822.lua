-- MC群的摆渡者 玲音
function c284130822.initial_effect(c)
    -- 不能特招
    local e1 = Effect.CreateEffect(c)
    e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE + EFFECT_FLAG_UNCOPYABLE)
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetCode(EFFECT_SPSUMMON_CONDITION)
    e1:SetValue(aux.FALSE)
    c:RegisterEffect(e1)
    -- 弹回手卡
    local e2 = Effect.CreateEffect(c)
    e2:SetDescription(aux.Stringid(34853266, 0))
    e2:SetType(EFFECT_TYPE_SINGLE + EFFECT_TYPE_CONTINUOUS)
    e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
    e2:SetCode(EVENT_SUMMON_SUCCESS)
    e2:SetOperation(c284130822.backHandOperation1)
    c:RegisterEffect(e2)
    local e3 = e2:Clone()
    e3:SetCode(EVENT_FLIP)
    c:RegisterEffect(e3)
    -- 无解放召唤
    -- 三怪兽解放召唤
end

function c284130822.backHandOperation1(e, tp, eg, ep, ev, re, r, rp)
    local c = e:GetHandler()
    -- to hand
    local e1 = Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_FIELD + EFFECT_TYPE_TRIGGER_F)
    e1:SetDescription(aux.Stringid(34853266, 0))
    e1:SetCategory(CATEGORY_TOHAND)
    e1:SetCode(EVENT_PHASE + PHASE_END)
    e1:SetRange(LOCATION_MZONE)
    e1:SetCountLimit(1)
    e1:SetReset(RESET_EVENT + 0x1ee0000 + RESET_PHASE + PHASE_END)
    e1:SetCondition(c284130822.backHandCondition)
    e1:SetTarget(c284130822.backHandTarget)
    e1:SetOperation(c284130822.backHandOperation2)
    c:RegisterEffect(e1)
    local e2 = e1:Clone()
    e2:SetType(EFFECT_TYPE_FIELD + EFFECT_TYPE_TRIGGER_O)
    c:RegisterEffect(e2)
end

function c284130822.backHandCondition(e, tp, eg, ep, ev, re, r, rp)
end

function c284130822.backHandTarget(e, tp, eg, ep, ev, re, r, rp, chk, chkc)
end

function c284130822.backHandOperation2(e, tp, eg, ep, ev, re, r, rp)
end

