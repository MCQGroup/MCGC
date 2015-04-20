--玲音的镰刀尺
function c284130826.initial_effect(c)
     --Activate
    local e1=Effect.CreateEffect(c)
    e1:SetCategory(CATEGORY_EQUIP)
    e1:SetType(EFFECT_TYPE_ACTIVATE)
    e1:SetCode(EVENT_FREE_CHAIN)
    e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
    e1:SetTarget(c284130826.target)
    e1:SetOperation(c284130826.operation)
    c:RegisterEffect(e1)
    local e9=e1:Clone()
    e9:SetRange(LOCATION_GRAVE+LOCATION_REMOVED)
    e9:SetOperation(c284130826.opopo)
    c:RegisterEffect(e9)
    --Atk up
    local e2=Effect.CreateEffect(c)
    e2:SetType(EFFECT_TYPE_EQUIP)
    e2:SetCode(EFFECT_UPDATE_ATTACK)
    e2:SetValue(500)
    c:RegisterEffect(e2)
    --Equip limit
    local e3=Effect.CreateEffect(c)
    e3:SetType(EFFECT_TYPE_SINGLE)
    e3:SetCode(EFFECT_EQUIP_LIMIT)
    e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
    e3:SetValue(c284130826.equiplimit)
    c:RegisterEffect(e3)
    local e4=Effect.CreateEffect(c)
    e4:SetDescription(aux.Stringid(284130826,0))
    e4:SetCategory(CATEGORY_DRAW)
    e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
    e4:SetCode(EVENT_BATTLE_DESTROYING)
    e4:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
    e4:SetRange(LOCATION_SZONE)
    e4:SetCondition(c284130826.drcon)
    e4:SetTarget(c284130826.drtg)
    e4:SetOperation(c284130826.drop)
    c:RegisterEffect(e4)
    --destroy sub
    local e5=Effect.CreateEffect(c)
    e5:SetType(EFFECT_TYPE_EQUIP)
    e5:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
    e5:SetCode(EFFECT_DESTROY_SUBSTITUTE)
    e5:SetCondition(c284130826.condition)
    e5:SetValue(1)
    c:RegisterEffect(e5)
    local e6=Effect.CreateEffect(c)
    e6:SetDescription(aux.Stringid(284130826,0))
    e6:SetCategory(CATEGORY_DISABLE)
    e6:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_O)
    e6:SetCode(EVENT_CHAINING)
    e6:SetRange(LOCATION_SZONE)
    e6:SetCondition(c284130826.discon)
    e6:SetTarget(c284130826.distg)
    e6:SetOperation(c284130826.disop)
    c:RegisterEffect(e6)
end
function c284130826.filter(c)
    local code=c:GetCode()
    return c:IsFaceup() and (code==284130816 or code==284130817 or code==284130818 or code==284130819 or code==284130820 or code==284130821 or code==284130822 or code==284130823 ) end
function c284130826.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
    if chkc then return chkc:GetLocation()==LOCATION_MZONE and c284130826.filter(chkc) end
    if chk==0 then return Duel.IsExistingTarget(c284130826.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
    Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
    Duel.SelectTarget(tp,c284130826.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
    Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
end
function c284130826.operation(e,tp,eg,ep,ev,re,r,rp)
    local tc=Duel.GetFirstTarget()
    if e:GetHandler():IsRelateToEffect(e) and tc:IsRelateToEffect(e) and tc:IsFaceup() then
        Duel.Equip(tp,e:GetHandler(),tc)
    fujiatiaojian=0
    end
end
function c284130826.equiplimit(e,c)
    local code=c:GetCode()
    return c:IsFaceup() and (code==284130816 or code==284130817 or code==284130818 or code==284130819 or code==284130820 or code==284130821 or code==284130822 or code==284130823 )
end
function c284130826.drcon(e,tp,eg,ep,ev,re,r,rp)
    local ec=eg:GetFirst()
    local bc=ec:GetBattleTarget()
    return e:GetHandler():GetEquipTarget()==eg:GetFirst() and ec:IsControler(tp)
        and bc:IsLocation(LOCATION_GRAVE) and bc:IsReason(REASON_BATTLE)
end
function c284130826.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return true end
    Duel.SetTargetPlayer(tp)
    Duel.SetTargetParam(1)
    Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c284130826.drop(e,tp,eg,ep,ev,re,r,rp)
    if not e:GetHandler():IsRelateToEffect(e) then return end
    local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
    Duel.Draw(p,d,REASON_EFFECT)
end
function c284130826.opopo(e,tp,eg,ep,ev,re,r,rp)
local tc=Duel.GetFirstTarget()
    if e:GetHandler():IsRelateToEffect(e) and tc:IsRelateToEffect(e) and tc:IsFaceup() then
        Duel.Equip(tp,e:GetHandler(),tc)
    fujiatiaojian=1
    end
end
function c284130826.condition(e,tp,eg,ep,ev,re,r,rp)
   if fujiatiaojian==0 then return true end
end
function c284130826.discon(e,tp,eg,ep,ev,re,r,rp)
    local c=e:GetHandler()
    if fujiatiaojian==0 then return true end
    if c:IsStatus(STATUS_BATTLE_DESTROYED) then return false end
    if not re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then return end
    local loc,tg=Duel.GetChainInfo(ev,CHAININFO_TRIGGERING_LOCATION,CHAININFO_TARGET_CARDS)
    if not tg or not tg:IsContains(c) then return false end
    return Duel.IsChainDisablable(ev) and loc~=LOCATION_DECK
end
function c284130826.distg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return true end
    local c=e:Getf
    Duel.SendtoHand(tc,nil,REASON_COST)
    Duel.SetOperationInfo(0,CATEGORY_DISABLE,eg,1,0,0)
end
function c284130826.disop(e,tp,eg,ep,ev,re,r,rp,chk)
    Duel.NegateEffect(ev)
    Duel.Destroy(re:GetHandler(),REASON_EFFECT)
end
