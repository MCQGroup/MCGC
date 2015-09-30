-- MC群的现充拍档 玲音&手滑

function c284130841.initial_effect(c)
	-- 次元融合
    -- 参考[56655675]圣灵兽骑 地火狮
    c:EnableReviveLimit()
    -- 因为是族融合所以不填融合素材
    
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
    e1:SetCode(EFFECT_SPSUMMON_CONDITION)
    c:RegisterEffect(e1)
    
    local e2=Effect.CreateEffect(c)
    e2:SetType(EFFECT_TYPE_FIELD)
    e2:SetCode(EFFECT_SPSUMMON_PROC)
    e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
    e2:SetRange(LOCATION_EXTRA)
    e2:SetValue(SUMMON_TYPE_FUSION)
    e2:SetCondition(c284130841.fusionCondition)
    e2:SetOperation(c56655675.fusionOperation)
    c:RegisterEffect(e2)
	
	-- 攻击聚焦
	
	
	-- 攻守上升

end

function c284130841.lainFilter(c)
    return c:GetCode() >= 284130816 and c:GetCode() <= 284130823
end

function c284130841.fusionFilter1(c)
    return c284130841.lainFilter(c) and c:IsAbleToDeckAsCost() and c:IsCanBeFusionMaterial()
end

function c284130841.shouhuaFilter(c)
    return c:IsCode(284130825) or c:IsCode
end

function c284130841.fusionFilter2(c)
    return c:IsCode()
end

function c284130841.fusionCondition(e, c)
    if c == nil then
        return true
    end
    local tp = c:GetControler()
    return Duel.GetLocationCount(tp, LOCATION_MZONE) > -2 and Duel.
end

function c284130841.fusionOperation(e, tp, eg, ep, ev, re, r, rp, c)
end

-- 以下是参考用代码
function c56655675.spfilter1(c)
    return c:IsSetCard(0x40b5) and c:IsAbleToRemoveAsCost() and c:IsCanBeFusionMaterial()
end
function c56655675.spfilter2(c)
    return c:IsSetCard(0x10b5) and c:IsAbleToRemoveAsCost() and c:IsCanBeFusionMaterial()
end
function c56655675.spfilter3(c)
    return c:IsSetCard(0x20b5) and c:IsAbleToRemoveAsCost() and c:IsCanBeFusionMaterial()
end
function c56655675.spcon(e,c)
    if c==nil then return true end
    local tp=c:GetControler()
    return Duel.GetLocationCount(tp,LOCATION_MZONE)>-2
        and Duel.IsExistingMatchingCard(c56655675.spfilter1,tp,LOCATION_MZONE,0,1,nil)
        and Duel.IsExistingMatchingCard(c56655675.spfilter2,tp,LOCATION_MZONE,0,1,nil)
        and Duel.IsExistingMatchingCard(c56655675.spfilter3,tp,LOCATION_MZONE,0,1,nil)
end
function c56655675.spop(e,tp,eg,ep,ev,re,r,rp,c)
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
    local g1=Duel.SelectMatchingCard(tp,c56655675.spfilter1,tp,LOCATION_MZONE,0,1,1,nil)
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
    local g2=Duel.SelectMatchingCard(tp,c56655675.spfilter2,tp,LOCATION_MZONE,0,1,1,nil)
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
    local g3=Duel.SelectMatchingCard(tp,c56655675.spfilter3,tp,LOCATION_MZONE,0,1,1,nil)
    g1:Merge(g2)
    g1:Merge(g3)
    c:SetMaterial(g1)
    Duel.Remove(g1,POS_FACEUP,REASON_COST)
end