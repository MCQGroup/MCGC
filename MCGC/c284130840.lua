-- MC群服务器炮灰 DZ

function c284130840.initial_effect(c)
	-- 同调
	c:EnableReviveLimit()
	aux.AddSynchroProcedure(c, aux.TRUE, c284130840.filter, 1)
	
	-- 同调召唤成功选发
	local e1 = Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE + EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c284130840.syncSummonSuccessCondition)
	e1:SetOperation(c284130840.syncSummonSuccessOperation)
	c:RegisterEffect(e1)
	
	-- 自身从墓地特招
	local e2 = Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetCost(c284130840.spsummonCost)
	e2:SetOperation(c284130840.spsummonOperation)
	c:RegisterEffect(e2)
	
	-- 从墓地特招
	local e3 = Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_ACTIONS)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetCost(c284130840.spsummon2Cost)
	e3:SetTarget(c284130840.spsummon2Target)
	e3:SetOperation(c284130840.spsummon2Operation)
	c:RegisterEffect(e3)
	
	-- 送墓必发
	local e4 = Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE + EFFECT_TYPE_TRIGGER_F)
	e4:SetCode(EVENT_TO_GRAVE)
	e4:SetOperation(c284130840.toGraveOperation)
	c:RegisterEffect(e4)
end	

function c284130840.filter(c)
	return c:IsSetCard(0x2222)
end

function c284130840.syncSummonSuccessCondition(e, tp, eg, ep, ev, re, r, rp)
	return bit.band(e:GetHandler():GetSummonType(), SUMMON_TYPE_SYNCHRO) == SUMMON_TYPE_SYNCHRO
end

function c284130840.syncSummonSuccessOperation(e, tp, eg, ep, ev, re, r, rp)
	local lv = Duel.AnnounceLevel(tp)
	local c = e:GetHandler()
	local e1 = Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CHANGE_LEVEL)
	e1:SetValue(lv)
	e1:SetReset(RESET_SELF_TURN)
	c:RegisterEffect(e1)
end

function c284130840.spsummonFilter(c)
	return c284130840.filter(c) and c:IsTypeTYPE_MONSTER()
end

function c284130840.spsummonCost(e, tp, eg, ep, ev, re, r, rp, chk)
	local g = Duel.GetMatchingGroup(c284130840.spsummonFilter, tp, LOCATION_GRAVE, 0, nil)
	if chk == 0 then
		return g:CheckWithSumEqual(Card.GetLevel, 5)
		-- g:CheckWithSumEqual(Card.GetLevel, 5, 1, g:GetCount())
	end
	local sg = g:SelectWithSumEqual(tp, Card.GetLevel, 5)
	-- g:SelectWithSumEqual(tp, Card.GetLevel, 5, 1, g:GetCount()
	Duel.Remove(sg, POS_FACEUP, REASON_COST)
end

function c284130840.spsummonOperation(e, tp, eg, ep, ev, re, r, rp)
	local c = e:GetHandler()
	
	local e1 = Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DISABLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetReset(RESET_EVENT + RESET_LEAVE + RESET_TURN_SET)
	c:RegisterEffect(e1)
	
	local e2 = Effect.CreateEffect(c)
	e2:SetTarget(EFFECT_TYPE_FIELD + EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_PHASE_START + PHASE_END)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetReset(RESET_EVENT + RESET_LEAVE)
	e2:SetOperation(c284130840.destroyOperation)
	c:RegisterEffect(e2)
end

function c284130840.destroyOperation(e, tp, eg, ep, ev, re, r, rp)
	Duel.Destroy(e:GetHandler(), REASON_EFFECT, LOCATION_REMOVED)
end

function c284130840.spsummon2Cost(e, tp, eg, ep, ev, re, r, rp, chk)
	if chk == 0 then 
		return Duel.CheckLPCost(tp, 1000)
	end
	Duel.PayLPCost(tp, 1000)
end

function c284130840.spsummon2Target(e, tp, eg, ep, ev, re, r, rp, chk, chkc)
	if chk == 0 then
		return Duel.IsExistingMatchingCard(c284130840.spsummonFilter, tp, LOCATION_GRAVE, 0, 1, nil)
	end
	local g = Duel.SelectMatchingCard(tp, c284130840.spsummonFilter, tp, LOCATION_GRAVE, 0, 1, 1, nil)
	Duel.SetTarget(g)
	Duel.SetOperationInfo(0, CATEGORY_SPECIAL_SUMMON, g, g:GetCount(), nil, nil)
end

function c284130840.spsummon2Operation(e, tp, eg, ep, ev, re, r, rp)
	local g = Duel.GetChainInfo(0, CHAININFO_TARGET_CARDS)
	if Duel.SpecialSummon(g, SUMMON_TYPE_SPECIAL, tp, tp, false, false, POS_FACEDOWN_DEFENCE)
		Duel.SendtoGrave(c:GetHandler(), REASON_EFFECT)
	end
end

function c284130840.toGraveOperation(e, tp, eg, ep, ev, re, r, rp)
	Duel.Draw(tp, 1, REASON_EFFECT)
end