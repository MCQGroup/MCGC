-- MC群服务器OP 无情

function c284130839.initial_effect(c)
	-- 同调召唤
	c:EnableReviveLimit()
	aux.AddSynchroProcedure(c, c284130839.filter, c284130839.filter, 1)

	-- 同调召唤成功触发
	local e1 = Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE + EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c284130839.syncSummonSuccessTriggerCondition)
	e1:SetOperation(c284130839.syncSummonSuccessTriggerOperation)
	c:RegisterEffect(e1)
	
	-- 战破触发
	-- 结束阶段必定发动
	-- 因效果破坏必定发动
end 

function c284130839.filter(c)
	return c:IsSetCard(0x2222)
end

function c284130839.syncSummonSuccessTriggerCondition(e, tp, eg, ep, ev, re, r, rp)
	return bit.band(e:GetHandler():GetSummonType(), SUMMON_TYPE_SYNCHRO) == SUMMON_TYPE_SYNCHRO
end

function c284130839.syncSummonSuccessTriggerOperation(e, tp, eg, ep, ev, re, r, rp)
	-- 这个效果是对场地生效，还是对当前场上所有的怪物生效？
end