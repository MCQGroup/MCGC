function c284130864.initial_effect(c)
    --Activate
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_ACTIVATE)
    e1:SetCode(EVENT_FREE_CHAIN)
    e1:SetTarget(c284130864.tg1)
    e1:SetOperation(c284130864.op)
    c:RegisterEffect(e1)
    local e2=Effect.CreateEffect(c)
    e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
    e2:SetDescription(aux.Stringid(284130864,0))
    e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
    e2:SetType(EFFECT_TYPE_QUICK_O)
    e2:SetCode(EVENT_FREE_CHAIN)
    e2:SetRange(LOCATION_SZONE)
    e2:SetHintTiming(0,TIMING_END_PHASE)
    e2:SetCountLimit(1,284130864)
    e2:SetLabel(1)
    e2:SetCost(c284130864.cost)
    e2:SetTarget(c284130864.tg)
    e2:SetOperation(c284130864.op)
    c:RegisterEffect(e2)
end
function c284130864.costfilter(c)
    return c:IsFaceup() and c:IsSetCard(0x2222) and c:IsAbleToHandAsCost()
end
function c284130864.filter(c,e,tp)
    return c:IsSetCard(0x2222) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c284130864.tg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
    if chkc then return chkc:IsLocation(LOCATION_GRAVE) and c284130864.filter(chkc,e,tp) end
    if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1 and Duel.IsExistingTarget(c284130864.filter,tp,LOCATION_HAND,0,1,nil,e,tp)and Duel.IsExistingMatchingCard(c284130864.costfilter,tp,LOCATION_MZONE,0,1,nil) end
    if Duel.SelectYesNo(tp,aux.Stringid(284130864,1)) then
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOHAND)
    local g=Duel.SelectMatchingCard(tp,c284130864.costfilter,tp,LOCATION_MZONE,0,1,1,nil)
    Duel.SendtoHand(g,nil,REASON_COST)
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
    local g=Duel.SelectTarget(tp,c284130864.filter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
    Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
    e:SetCategory(CATEGORY_DESTROY)
    e:SetLabel(1)
    e:GetHandler():RegisterFlagEffect(284130864,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
    else
    e:SetCategory(0)
    e:SetLabel(0)
    end
end
function c284130864.cost(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.IsExistingMatchingCard(c284130864.costfilter,tp,LOCATION_MZONE,0,1,nil) end
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOHAND)
    local g=Duel.SelectMatchingCard(tp,c284130864.costfilter,tp,LOCATION_MZONE,0,1,1,nil)
    Duel.SendtoHand(g,nil,REASON_COST)
end
function c284130864.tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
    if chkc then return chkc:IsLocation(LOCATION_GRAVE) and c284130864.filter(chkc,e,tp) end
    if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1 and Duel.IsExistingTarget(c284130864.filter,tp,
    LOCATION_HAND,0,1,nil,e,tp) end
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
    local g=Duel.SelectTarget(tp,c284130864.filter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
    Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
    e:GetHandler():RegisterFlagEffect(284130864,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
end
function c284130864.op(e,tp,eg,ep,ev,re,r,rp)
    if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
    if e:GetLabel()==0 then return end
    local tc=Duel.GetFirstTarget()
    if tc:IsRelateToEffect(e) then
        Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
    end
end
