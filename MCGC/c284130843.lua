-- MC群的最终领袖 纸睡前辈

function c284130843.intial_effect(c)
	-- 同调召唤
	c:EnableReviveLimit()
	aux.AddSynchroProcedure(c, c284130843.synchroFilter1, c284130843.synchroFilter2, 2)
	-- 这里不需要是MC群吗？
	
	-- 展示
	-- 魔免
	-- 控制权
	-- 无效效果
	-- 亡语
end	

function c284130843.filter(c)
	return c:IsSetCard(0x2222)
end

function c284130843.synchroFilter1(c)
	return c284130843.filter(c) and c:IsType(TYPE_TUNER) and c:IsType(TYPE_SYNCHRO)
end

function c284130843.synchroFilter2(c)
	return c284130843.filter(c) and (c:IsType(TYPE_FUSION) or c:IsType(TYPE_XYZ) or c:IsType(TYPE_PENDULUM))
end