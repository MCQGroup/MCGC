-- MC群的最终领袖 纸睡前辈

function c284130843.intial_effect(c)
	-- 同调召唤
	c:EnableReviveLimit()
	aux.AddSynchroProcedure(c, c284130843.synchroFilter1, c284130843.synchroFilter2, 2)
	
    local e1 = Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE + EFFECT_FLAG_UNCOPYABLE)
    e1:SetCode(EFFECT_SPSUMMON_CONDITION)
    c:RegisterEffect(e1)
	
	-- 展示
	local e2 = Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE + EFFECT_TYPE_IGNITION)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_EXTRA)
	e2:SetCondition(c284130843.showCondition)
	e2:SetCost(c284130843.showCost)
	e2:SetOperation(c284130843.showOperation)
	c:RegisterEffect(e2) 
	
	-- 魔免
	-- 参考[94784213]威风妖怪·狐
	local e3 = Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	c:RegisterEffect(e3)
	
	local e4 = e3:Clone()
	e4:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	c:RegisterEffect(e4)
	
	-- 控制权
	local e5 = Effect.CreateEffect(c)
	c:RegisterEffect(e5)
	
	-- 无效效果
	local e6 = Effect.CreateEffect(c)
	c:RegisterEffect(e6)
	
	-- 亡语
	local e7 = Effect.CreateEffect(c)
	c:RegisterEffect(e7)
end	

function c284130843.filter(c)
	return c:IsSetCard(0x2222)
end

function c284130843.synchroFilter1(c)
	return c:IsType(TYPE_TUNER) and c:IsType(TYPE_SYNCHRO)
end

function c284130843.synchroFilter2(c)
	return (c:IsType(TYPE_FUSION) or c:IsType(TYPE_XYZ) or c:IsType(TYPE_PENDULUM))
end

function c284130843.showCondition(e, tp, eg, ep, ev, re, r, rp)
	return Duel.GetTurnPlayer() == tp and bit.band(Duel.GetCurrentPhase(), PHASE_MAIN1 + PHASE_MAIN2)
end

function c284130843.showCost(e, tp, eg, ep, ev, re, r, rp, chk)
	if chk == 0 then
		return true
	end
	Duel.ConfirmCards(1 - tp, e:GetHandler())
end

function c284130843.showOperation(e, tp, eg, ep, ev, re, r, rp)
	-- 这尼玛怎么写！
	-- DZ建议参考自然调整和调节支援士兵
	-- 然而并没有什么用
	-- DZ又建议参考传说之都 亚特兰蒂斯
	-- 参考EFFECT_SYNCHRO_MATERIAL_CUSTOM
	Duel.RegisterFlagEffect(tp, 284130843, RESET_PHASE + RESET_END, nil, 1)
	
	local tg = Duel.GetMatchingGroup(Card.IsType(TYPE_XYZ), tp, LOCATION_MZONE, 0, nil)
	local tc = tg:GetFirst()
	while tc do
		local te = Effect.CreateEffect(tc)
		te:SetType(EFFECT_TYPE_FIELD)
		te:SetCode(EFFECT_SYNCHRO_MATERIAL_CUSTOM)
		te:SetLabel(e:GetHandler():GetCode())
		te:SetCondition(function(ein, tpin, egin, epin, evin, rein, rin, rpin)
			return Duel.GetFlagEffect(tp, 284130843)
		end)
		te:SetTarget(function(ein, syncard, f, minc, maxc)
		-- TODO
			return true
		end)
		te:SetValue(1)
		te:SetOperation(function(ein, tpin, egin, epin, rein, rin, rpin, syncard, f, minc, maxc)
		-- TODO
			return
		end)
		tc:RegisterEffect(te)
		
		tc = tg:GetNext()
	end
end