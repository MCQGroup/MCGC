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
	e2:SetCost()
	e2:SetOperation()
	c:RegisterEffect(e2)
	
	-- 从墓地特招
	local e3 = Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_ACTIONS)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetTarget()
	e3:SetOperation()
	c:RegisterEffect(e3)
	
	-- 送墓必发
	local e4 = Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE + EFFECT_TYPE_TRIGGER_F)
	e4:SetCode(EVENT_TO_GRAVE)
	e4:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e4:SetTarget()
	e4:SetOperation()
	c:RegisterEffect(e4)
end	

function c284130840.filter(c)
	return c:IsSetCard(0x2222)
end

function c284130840.syncSummonSuccessCondition(e, tp, eg, ep, ev, re, r, rp)
	return bit.band(e:GetHandler():GetSummonType(), SUMMON_TYPE_SYNCHRO) == SUMMON_TYPE_SYNCHRO
end

function c284130840.syncSummonSuccessOperation(e, tp, eg, ep, ev, re, r, rp)
end