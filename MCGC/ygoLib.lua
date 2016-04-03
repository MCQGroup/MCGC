-- =====debug类=====
Debug = { }

function Debug.AddCard(code, owner, player, location, seq, pos, proc)
    -- 添加卡片，将卡号为code的卡片的持有者设置为owner，以表示形式pos放置在player的场上位于location上序号为seq的格子处
    -- 【必须】
    --[[
        int code
        int owner
        int player
        int location
        int seq
        int pos
    --]]
    -- 【可选】
    --[[
        bool proc = false
            proc = true则解除苏生限制
    --]]
    -- 【返回】添加的Card对象
end

function Debug.Message(any)
    -- 输出调试信息
end

function Debug.PreAddCounter(c, counter_type, count)
    -- 为c添加count个counter_type的指示物
    -- 【必须】
    --[[
        Card c
        int counter_type
        int count
    --]]
end

function Debug.PreEquip(equip_card, target)
    -- 为target添加装备equip_card
    -- 【必须】
    --[[
        Card equip_card
        Card target
    --]]
    -- 【返回】bool类型（？）
end

function Debug.PreSetTarget(c, target)
    -- 把target选为c的永续对象
    -- 【必须】
    --[[
        Card c
        Card target
    --]]
end

function Debug.ReloadFieldBegin(flag)
    -- 以选项flag开始布局
    -- 【必须】
    --[[
        int flag
            flag of 残局：DUEL_ATTACK_FIRST_TURN + DUEL_SIMPLE_AI
    --]]
end

function Debug.ReloadFieldEnd()
    -- 布局结束
end

function Debug.SetAIName(name)
    -- 设置AI的名字
    -- 【必须】
    --[[
        string name
    --]]
end

function Debug.SetPlayerInfo(playerid, lp, startcount, drawcount)
    -- 设置玩家信息，基本分为lp，初始手卡为startcount张，每回合抽drawcount张
    -- 【必须】
    --[[
        int playerid
            playerid 下方 0,上方 1
        int lp
        int startcount
        int drawcount
    --]]
end

function Debug.PreSummon(c, sum_type, sum_location)
    -- 设置卡片c的召唤信息：以sum_type方法(通常召唤、特殊召唤等)[从sum_location]出场
    -- 【必须】
    --[[
        Card c
        int sum_type
    --]]
    -- 【可选】
    --[[
        int sum_location = 0
    ]]
end

function Debug.ShowHint(msg)
    -- 显示提示窗口
    -- 【必须】
    --[[
        string msg
    --]]
end

-- =====bit类=====
bit = { }

function bit.band(a, b)
    -- a与b的位与
end

function bit.bor(a, b)
    -- a与b的位或
end

function bit.bxor(a, b)
    -- a与b的位异或
end

function bit.lshift(a, b)
    -- a左移b
end

function bit.rshift(a, b)
    -- a右移b
end

-- =====Card类=====
Card = { }

-- 属性
Card.material_count = 0     -- 融合素材的数量
Card.material = 0 -- 融合素材的数组，内容为卡片ID

-- 方法
function Card.GetCode(c)
    -- 返回c的当前代号（可能因为效果改变）
    -- 【返回】
    --[[
        int
        int
    --]]
end

function Card.GetOriginalCode(c)
    -- 返回c的卡片记载的代号
end

function Card.GetOriginalCodeRule(c)
    -- 返回c规则上的代号（这张卡规则上当作...使用）
    -- 【返回】
    --[[
        int
        int
    --]]
end

function Card.GetFusionCode(c)
    -- 返回c作为融合素材时的卡号（包括c原本的卡号）
    -- 【返回】
    --[[
        int
        int
        ...
    --]]
end

function Card.IsFusionCode(c, code)
    -- 检查c作为融合素材时能否当作卡号为code的卡
end

function Card.IsSetCard(c, setname)
    -- 检查c是否是名字含有setname的卡
end

function Card.IsPreviousSetCard(c, setname)
    -- 检查c位置变化之前是否是名字含有setname的卡
end

function Card.IsFusionSetCard(c, setname)
    -- 检查c作为融合素材时能否当作名字含有setname的卡
end

function Card.GetType(c)
    -- 返回c的当前类型。
end

function Card.GetOriginalType(c)
    -- 返回c的卡片记载的类型。
end

function Card.GetLevel(c)
    -- 返回c的当前等级
end

function Card.GetRank(c)
    -- 返回c的当前阶级
end

function Card.GetSynchroLevel(c, sc)
    -- 返回c在用于同调召唤sc时的同调用等级。此函数除了某些特定卡如调节支援士，返回值与Card.GetLevel(c)相同
end

function Card.GetRitualLevel(c, rc)
    -- 返回c在用于仪式召唤rc时的仪式解放等级。此函数除了某些特定卡如仪式供物，返回值与Card.GetLevel(c)相同
end

function Card.GetOriginalLevel(c)
    -- 返回c的卡片记载的等级
end

function Card.GetOriginalRank(c)
    -- 返回c的卡片记载的阶级
end

function Card.IsXyzLevel(c, xyzc, lv)
    -- 检查c对于超量怪兽xyzc的超量用等级是否是lv
end

function Card.GetLeftScale(c)
    -- 返回c的左灵摆刻度
end

function Card.GetOriginalLeftScale(c)
    -- 返回c的原本的左灵摆刻度
end

function Card.GetRightScale(c)
    -- 返回c的右灵摆刻度
end

function Card.GetOriginalRightScale(c)
    -- 返回c的原本的右灵摆刻度
end

function Card.GetAttribute(c)
    -- 返回c的当前属性。注：对某些多属性怪物如光与暗之龙，此函数的返回值可能是几个属性的组合值。
end

function Card.GetOriginalAttribute(c)
    -- 返回c的卡片记载的属性
end

function Card.GetRace(c)
    -- 返回c的当前种族。注：对某些多种族怪物如动画效果的魔术猿，此函数的返回值可能是几个种族的组合值。
end

function Card.GetOriginalRace(c)
    -- 返回c的卡片记载的种族
end

function Card.GetAttack(c)
    -- 返回c的当前攻击力，返回值是负数表示是"?"
end

function Card.GetBaseAttack(c)
    -- 返回c的原本攻击力
end

function Card.GetTextAttack(c)
    -- 返回c的卡片记载的攻击力
end

function Card.GetDefence(c)
    -- 返回c的当前守备力，返回值是负数表示是"?"
end

function Card.GetBaseDefence(c)
    -- 返回c的原本守备力
end

function Card.GetTextDefence(c)
    -- 返回c的卡片记载的守备力
end

function Card.GetPreviousCodeOnField(c)
    -- 返回c位置变化之前的卡号
end

function Card.GetPreviousTypeOnField(c)
    -- 返回c位置变化之前的类型
end

function Card.GetPreviousLevelOnField(c)
    -- 返回c位置变化之前的等级
end

function Card.GetPreviousRankOnField(c)
    -- 返回c位置变化之前的阶级
end

function Card.GetPreviousAttributeOnField(c)
    -- 返回c位置变化之前的属性
end

function Card.GetPreviousRaceOnField(c)
    -- 返回c位置变化之前的种族
end

function Card.GetPreviousAttackOnField(c)
    -- 返回c位置变化之前的攻击力
end

function Card.GetPreviousDefenceOnField(c)
    -- 返回c位置变化之前的守备力
end

function Card.GetOwner(c)
    -- 返回c的持有者
end

function Card.GetControler(c)
    -- 返回c的当前控制者
end

function Card.GetPreviousControler(c)
    -- 返回c的位置变化之前的控制者
end

function Card.GetReason(c)
    -- 返回c的位置变化原因
end

function Card.GetReasonCard(c)
    -- 返回导致c的位置变化的卡。此函数仅在某卡被战斗破坏时，因为上级召唤被解放，或者成为特殊召唤使用的素材时有效。
end

function Card.GetReasonPlayer(c)
    -- 返回导致c的位置变化的玩家
end

function Card.GetReasonEffect(c)
    -- 返回导致c的位置变化的效果。
end

function Card.GetPosition(c)
    -- 返回c当前的表示形式
end

function Card.GetPreviousPosition(c)
    -- 返回c位置变化前的表示形式
end

function Card.GetBattlePosition(c)
    -- 返回c在本次战斗发生之前的表示形式
end

function Card.GetLocation(c)
    -- 返回c当前的所在位置
end

function Card.GetPreviousLocation(c)
    -- 返回c位置变化前的所在的位置
end

function Card.GetSequence(c)
    --[[返回c在当前位置的序号
    在场上时，序号代表所在的格子，从左往右分别是0-4，场地魔法格的序号为5
    在其它地方时，序号表示的是第几张卡。最底下的卡的序号为0]]
end

function Card.GetPreviousSequence(c)
    -- 返回c位置变化前的序号
end

function Card.GetSummonType(c)
    -- 返回c上场的方式。
end

function Card.GetSummonLocation(c)
    -- 返回c的召唤位置
end

function Card.GetSummonPlayer(c)
    -- 返回召唤，特殊召唤c上场的玩家
end

function Card.GetDestination(c)
    -- 返回c位置变化的目的地。此函数仅在处理位置转移代替效果时有效。
end

function Card.GetLeaveFieldDest(c)
    -- 返回c离场时因改变去向的效果（如大宇宙）的目的地
end

function Card.GetTurnID(c)
    -- 返回c转移到当前位置的回合
end

function Card.GetFieldID(c)
    -- 返回c转移到当前位置的时间标识。此数值唯一，越小表示c是越早出现在那个位置。
end

function Card.GetRealFieldID(c)
    -- 返回c转移到当前位置的真实的时间标识
end

function Card.IsCode(c, code1, code2)
    -- 检查c的代号是否是code1[或者为code2]。
end

function Card.IsType(c, type)
    -- 检查c是否属于类型type。
end

function Card.IsRace(c, race)
    -- 检查c是否属于种族race。
end

function Card.IsAttribute(c, attribute)
    -- 检查c是否属于属性attribute。
end

function Card.IsReason(c, reason)
    -- 检查c是否包含原因reason。
end

function Card.IsStatus(c, status)
    -- 检查c是否包含某个状态码。
end

function Card.IsNotTuner(c)
    -- 检查c是否可以当成非调整来使用。
end

function Card.SetStatus(c, state, enable)
    -- 给c设置或者取消状态码。除非妳清楚的了解每个状态码的含意，否则不要轻易使用此函数。
end

function Card.IsDualState(c)
    -- 检查c属否处于再召唤状态。
end

function Card.EnableDualState(c)
    -- 把c设置成再召唤状态。
end

function Card.SetTurnCounter(c, counter)
    -- 设置c的回合计数器(光之护封剑等)
end

function Card.GetTurnCounter(c)
    -- 返回c的回合计数器
end

function Card.SetCustomValue(c, tag, object)
    -- 以tag作为标签为c设置一个自定义值object
end

function Card.GetCustomValue(c, tag)
    -- 返回c的以tag作为标签的自定义值
end

function Card.SetMaterial(c, g)
    -- 把g中的所有卡作为c的素材（上级召唤，特殊召唤）
end

function Card.GetMaterial(c)
    -- 返回c出场使用的素材
end

function Card.GetMaterialCount(c)
    -- 返回c出场使用的素材数量
end

function Card.GetEquipGroup(c)
    -- 返回c当前装备着的卡片组
end

function Card.GetEquipCount(c)
    -- 返回c当前装备着的卡片数量
end

function Card.GetEquipTarget(c)
    -- 返回c当前的装备对象
end

function Card.CheckEquipTarget(c1, c2)
    -- 检查c2是否是c1的正确的装备对象
end

function Card.GetUnionCount(c)
    -- 返回c当前装备的同盟卡数量
end

function Card.GetOverlayGroup(c)
    -- 返回c当前叠放着的卡片组
end

function Card.GetOverlayCount(c)
    -- 返回c当前叠放着的卡片数量
end

function Card.GetOverlayTarget(c)
    -- 返回以c为超量素材的卡
end

function Card.CheckRemoveOverlayCard(c, player, count, reason)
    -- 检查玩家player能否以reason为原因，至少移除c叠放的count张卡
end

function Card.RemoveOverlayCard(c, player, min, max, reason)
    -- 以reason为原因，让玩家player移除c叠放的min-max张卡，返回值表示是否成功
end

function Card.GetAttackedGroup(c)
    -- 返回c本回合攻击过的卡片组
end

function Card.GetAttackedGroupCount(c)
    -- 返回c本回合攻击过的卡片数量
end

function Card.GetAttackedCount(c)
    -- 返回c本回合攻击过的次数
    -- 注：如果此值与上一个函数的返回值不同，那么说明此卡本回合进行过直接攻击
end

function Card.GetBattledGroup(c)
    -- 返回与c本回合进行过战斗的卡片组
    -- 进行过战斗指发生过伤害的计算。用于剑斗兽等卡的判定。
end

function Card.GetBattledGroupCount(c)
    -- 返回与c本回合进行过战斗的的卡片数量
end

function Card.GetAttackAnnouncedCount(c)
    -- 返回c本回合攻击宣言的次数
    -- 注：攻击被无效不会被计入攻击过的次数，但是会计入攻击宣言的次数。
end

function Card.IsDirectAttacked(c)
    -- 检查c是否直接攻击过
end

function Card.SetCardTarget(c1, c2)
    -- 把c2作为c1的永续对象。
    -- c1和c2的联系会在c1活c2任意一卡离场或变成里侧表示时reset。
end

function Card.GetCardTarget(c)
    -- 返回c当前所有的永续对象
end

function Card.GetFirstCardTarget(c)
    -- 返回c当前第一个永续对象
end

function Card.GetCardTargetCount(c)
    -- 返回c当前的永续对象的数量
end

function Card.IsHasCardTarget(c1, c2)
    -- 检查c1是否取c2为永续对象
end

function Card.CancelCardTarget(c1, c2)
    -- 取消c2为c1的永续对象
end

function Card.GetOwnerTarget(c)
    -- 返回取c作为永续对象的所有卡
end

function Card.GetOwnerTargetCount(c)
    -- 返回取c作为永续对象的卡的数量
end

function Card.GetActivateEffect(c)
    -- 返回c的“卡片发动”的效果。仅对魔法和陷阱有效。
end

function Card.CheckActivateEffect(c, neglect_con, neglect_cost, copy_info)
    -- 返回c的可以发动时机正确的“卡的发动”的效果，neglect_con=true则无视发动条件，neglect_cost=true则无视发动cost
    -- copy_info=false或者自由时点的效果则只返回这个效果
    -- 否则还返回这个效果的时点为code的触发时点的信息 eg,ep,ev,re,r,rp
end

function Card.RegisterEffect(c, e, forced)
    -- 把效果e注册给c，返回效果的全局id。
    -- 默认情况下注册时如果c带有免疫e的效果那么注册会失败。如果forced为true则不会检查c对e的免疫效果。
end

function Card.IsHasEffect(c, code)
    -- 检查c是否受到效果种类是code的效果的影响
end

function Card.ResetEffect(c, id, reset_type)
    -- 以重置类型为reset_type、重置种类为id手动重置c受到的效果的影响
    -- 重置类型只能是以下类型，对应的重置种类为
    -- RESET_EVENT       发生事件重置        id为事件
    -- RESET_PHASE       阶段结束重置        id为阶段
    -- RESET_CODE        重置指定code的效果  id为效果的种类code，只能重置EFFECT_TYPE_SINGLE的永续型效果
    -- RESET_COPY        重置复制的效果      id为copy_id
    -- RESET_CARD        重置卡片的效果      id为效果owner的卡号
end

function Card.GetEffectCount(c, code)
    -- 返回c受到影响的种类是code的效果的数量
end

function Card.RegisterFlagEffect(c, code, reset_flag, property, reset_count)
    -- 为c注册一个标识用效果。
    -- 注：注册给卡的标识用效果不会用于系统，即使code与内置效果code重合也不会影响，并且类型总是EFFECT_TYPE_SINGLE。reset方法，property和一般的效果相同，并且不会无效化，不受卡的免疫效果影响。
end

function Card.GetFlagEffect(c, code)
    -- 返回c的种类是code的标识效果的数量。
end

function Card.ResetFlagEffect(c, code)
    -- 手动清除c的种类是code的标识效果。
end

function Card.SetFlagEffectLabel(c, code, label)
    -- 返回c是否存在种类为code的标识效果，并设置其Label属性为label
end

function Card.GetFlagEffectLabel(c, code)
    -- 返回c的种类为code的标识效果的Label，没有此效果则返回nil
end

function Card.CreateRelation(c1, c2, reset_flag)
    -- 为c1建立于c2的联系。此联系仅会由于RESET_EVENT的事件reset。
end

function Card.ReleaseRelation(c1, c2)
    -- 手动释放c1对于c2的联系
end

function Card.CreateEffectRelation(c, e)
    -- 为卡片c和效果e建立联系
end

function Card.ReleaseEffectRelation(c, e)
    -- 手动释放c与效果e的联系
end

function Card.ClearEffectRelation(c)
    -- 清空c所有联系的效果
end

function Card.IsRelateToEffect(c, e)
    -- 检查c是否和效果e有联系。
    -- 注：每次发动进入连锁的效果时，发动效果的卡，以及发动效果时指定的对象（用Duel.SetTargetCard或者Duel.SelectTarget指定的，包括取对象和不取对象）会自动与那个效果建立联系。一旦离场，联系会重置。
end

function Card.IsRelateToChain(c, chainc)
    -- 检查c是否和连锁chainc有联系
    -- 注：每次发动进入连锁的效果时，发动效果的卡，以及发动效果时指定的对象（用Duel.SetTargetCard或者Duel.SelectTarget指定的，包括取对象和不取对象）会自动与那个效果建立联系。一旦离场，联系会重置。
end

function Card.IsRelateToCard(c1, c2)
    -- 检查c1是否和c2有联系。
end

function Card.IsRelateToBattle(c)
    -- 检查c是否和本次战斗关联。
    -- 注：此效果通常用于伤害计算后伤害阶段结束前，用于检查战斗的卡是否离场过。
end

function Card.CopyEffect(c, code, reset_flag, reset_count)
    -- 为c添加代号是code的卡的可复制的效果，并且添加额外的reset条件。
    -- 返回值是表示复制效果的代号id。
end

function Card.ReplaceEffect(c, code, reset_flag, reset_count)
    -- 把c的效果替换为卡号是code的卡的效果，并且添加额外的reset条件
    -- 返回值是表示替换效果的代号id
end

function Card.EnableUnsummonable(c)
    -- 将c设置为不可通常召唤的怪兽
    -- 实际上是个不可复制、不会被无效的EFFECT_UNSUMMONABLE_CARD效果
end

function Card.EnableReviveLimit(c)
    -- 为c添加苏生限制。
    -- 实际上是不可复制、不会被无效的EFFECT_UNSUMMONABLE_CARD和EFFECT_REVIVE_LIMIT效果
end

function Card.CompleteProcedure(c)
    -- 使c完成正规的召唤手续。此函数也可通过Card.SetStatus实现。
end

function Card.IsDisabled(c)
    -- 检查c是否处于无效状态
end

function Card.IsDestructable(c)
    -- 检查c是否是可破坏的。
    -- 注：不可破坏指的是类似场地护罩，宫廷的规矩等“破壊できない”的效果
end

function Card.IsSummonableCard(c)
    -- 检查c是否是可通常召唤的卡。
end

function Card.IsSpecialSummonable(c)
    -- 检查是否可以对c进行特殊召唤手续。
end

function Card.IsSynchroSummonable(c, tuner)
    -- 检查是否可以以tuner作为调整对c进行同调召唤手续。如果tuner是nil，此函数与上一个函数作用相同。
end

function Card.IsXyzSummonable(c, mg, min, max)
    -- 检查是否可以在mg中选出[min-max个]超量素材对c进行超量召唤手续
    -- 如果mg为nil，此函数与Card.IsSpecialSummonable作用相同
end

function Card.IsSummonable(c, ignore_count, e, minc)
    -- 检查c是否进行通常召唤（不包含通常召唤的set)，ignore_count=true则不检查召唤次数限制
    -- e~=nil则检查c是否可以以效果e进行通常召唤，minc表示至少需要的祭品数（用于区分妥协召唤与上级召唤）
end

function Card.IsMSetable(c, ignore_count, e, minc)
    -- 检查c是否可进行通常召唤的set，ignore_count=true则不检查召唤次数限制
    -- e~=nil则检查c是否可以以效果e进行通常召唤的set，minc表示至少需要的祭品数（用于区分妥协召唤set与上级召唤set）
end

function Card.IsSSetable(c, ignore_field)
    -- 检查c是否可以set到魔法陷阱区，ignore_field=true则无视魔陷区格子限制
end

function Card.IsCanBeSpecialSummoned(c, e, sumtype, sumplayer, nocheck, nolimit, sumpos, target_player)
    -- 检查c是否可以被玩家sumplayer用效果e以sumtype方式和sumpos表示形式特殊召唤到target_player场上
    -- 如果nocheck是true则不检查c的召唤条件，如果nolimit是true则不检查c的苏生限制
    -- sumpos默认为POS_FACEUP, target_player默认为sumplayer
end

function Card.IsAbleToHand(c)
    -- 检查c是否可以送去手牌。
    -- 注：仅当卡片或者玩家受到“不能加入手牌”的效果的影响时（如雷王）此函数才返回false。以下几个函数类似。
end

function Card.IsAbleToDeck(c)
    -- 检查c是否可以送去卡组。
end

function Card.IsAbleToExtra(c)
    -- 检查c是否可以送去额外卡组。
    -- 对于非融合，同调，超量卡此函数均返回false。
end

function Card.IsAbleToGrave(c)
    -- 检查c是否可以送去墓地。
end

function Card.IsAbleToRemove(c, player)
    -- 检查c是否可以被玩家player除外
end

function Card.IsAbleToHandAsCost(c)
    -- 检查c是否可以作为cost送去手牌。
    -- 注：此函数会在Card.IsAbleToHand的基础上追加检测c的实际目的地。
    -- 当c送往手牌会被送去其它地方时（如缩退回路适用中，或者c是融合，同调和超量怪的一种），此函数返回false。
    -- 以下几个函数类似。
end

function Card.IsAbleToDeckAsCost(c)
    -- 检查c是否可以作为cost送去卡组。
end

function Card.IsAbleToExtraAsCost(c)
    -- 检查c是否可以作为cost送去额外卡组。
end

function Card.IsAbleToDeckOrExtraAsCost(c)
    -- 检查c是否可以作为cost送去卡组或额外卡组（用于接触融合的召唤手续检测）
end

function Card.IsAbleToGraveAsCost(c)
    -- 检查c是否可以作为cost送去墓地。
end

function Card.IsAbleToRemoveAsCost(c)
    -- 检查c是否可以作为cost除外。
end

function Card.IsReleaseable(c)
    -- 检查c是否可以解放（非上级召唤用）
end

function Card.IsReleasableByEffect(c)
    -- 检查c是否可以被效果解放
end

function Card.IsDiscardable(c)
    -- 检查c是否可以丢弃
    -- 注：此函数仅用于检测，以REASON_DISCARD作为原因把一张手卡送墓并不会导致那张卡不能丢弃。
end

function Card.IsAttackable(c)
    -- 检查c是否可以攻击
end

function Card.IsChainAttackable(c)
    -- 检查c是否可以连续攻击
    -- 注：当c因为闪光之双剑等效果进行过多次攻击之后此函数返回false。
end

function Card.IsFaceup(c)
    -- 检查c是否是表侧表示
end

function Card.IsAttackPos(c)
    -- 检查c是否是攻击表示
end

function Card.IsFacedown(c)
    -- 检查c是否是里侧表示
end

function Card.IsDefencePos(c)
    -- 检查c是否是守备表示
end

function Card.IsPosition(c, pos)
    -- 检查c是否是表示形式pos
end

function Card.IsPreviousPosition(c, pos)
    -- 检查c位置变化之前是否是表示形式pos
end

function Card.IsControler(c, controler)
    -- 检查c的当前控制着是否是controler
end

function Card.IsOnField(c)
    -- 检查c是否在场。
    -- 注：当怪物召唤，反转召唤，特殊召唤时召唤成功之前，此函数返回false
end

function Card.IsLocation(c, location)
    -- 检查c当前位置是否是location。
    -- 注：当怪物召唤，反转召唤，特殊召唤时召唤成功之前，并且loc=LOCATION_MZONE时，此函数返回false
end

function Card.IsPreviousLocation(c, location)
    -- 检查c之前的位置是否是location
end

function Card.IsLevelBelow(c, level)
    -- 检查c是否是等级level以下（至少为1）
end

function Card.IsLevelAbove(c, level)
    -- 检查c是否是等级level以上
end

function Card.IsRankBelow(c, rank)
    -- 检查c是否是阶级rank以下（至少为1）
end

function Card.IsRankAbove(c, rank)
    -- 检查c是否是阶级rank以上
end

function Card.IsAttackBelow(c, atk)
    -- 检查c是否是攻击力atk以下（至少为0）
end

function Card.IsAttackAbove(c, atk)
    -- 检查c是否是攻击力atk以上
end

function Card.IsDefenceBelow(c, def)
    -- 检查c是否是守备力def以下（至少为0）
end

function Card.IsDefenceAbove(c, def)
    -- 检查c是否是守备力def以上
end

function Card.IsPublic(c)
    -- 检查c是否处于公开状态
end

function Card.IsForbidden(c)
    -- 检查c是否处于被宣言禁止状态
end

function Card.IsAbleToChangeControler(c)
    -- 检查c是否可以改变控制权
    -- 注：仅当卡收到了“不能改变控制权”的效果的影响时，此函数返回false
end

function Card.IsControlerCanBeChanged(c)
    -- 检查c的控制权是否可以改变
    -- 注：此函数会在上一个函数的基础上追加检测场上的空格位
end

function Card.AddCounter(c, countertype, count, singly)
    -- 为c放置count个countertype类型的指示物
    -- singly为true表示逐个添加至上限为止
end

function Card.RemoveCounter(c, player, countertype, count, reason)
    -- 让玩家player以原因reason移除c上的count个countertype类型的指示物
end

function Card.GetCounter(c, countertype)
    -- 返回c上的countertype类型的指示物的数量
end

function Card.EnableCounterPermit(c, countertype, location)
    -- 允许c[在位置location]放置那个需要"可以放置"才能放置的指示物countertype
    -- location的默认值与c的种类有关，灵摆怪兽需要指定能否在怪兽区域或灵摆区域放置指示物
end

function Card.SetCounterLimit(c, countertype, count)
    -- 设定c放置countertype类型指示物的上限
end

function Card.IsCanTurnSet(c)
    -- 检查c是否可以转成里侧表示。
end

function Card.IsCanAddCounter(c, countertype, count, singly)
    -- 检查c是否可以[逐个(singly=true)]放置count个countertype类型的指示物
end

function Card.IsCanRemoveCounter(c, player, countertype, count, reason)
    -- 检查玩家player是否可以以原因reason移除c上的count个countertype类型的指示物
end

function Card.IsCanBeFusionMaterial(c, fc, ignore_mon)
    -- 检查c是否可以成为[融合怪兽fc的]融合素材，ignore_mon=true则不检查c是否是怪兽
end

function Card.IsCanBeSynchroMaterial(c, sc, tuner)
    -- 检查c是否可以成为同调怪兽sc的同调素材
end

function Card.IsCanBeRitualMaterial(c, sc)
    -- 检查c是否能作为仪式怪兽sc的祭品
end

function Card.IsCanBeXyzMaterial(c, sc)
    -- 检查c是否可以成为超量怪兽sc的超量素材
end

function Card.CheckFusionMaterial(c, g, gc, chkf)
    -- 检查g是否包含了c需要[必须包含gc在内]的一组融合素材
    -- 根据c的种类为EFFECT_FUSION_MATERIAL的效果的Condition函数检查
end

function Card.IsImmuneToEffect(c, e)
    -- 检查c是否免疫效果e（即不受效果e的影响）
end

function Card.IsCanBeEffectTarget(c, e)
    -- 检查c是否可以成为效果e的对象
end

function Card.IsCanBeBattleTarget(c1, c2)
    -- 检查c1是否可以成为c2的攻击目标
end

function Card.AddTrapMonsterAttribute(c, extra_type, attribute, race, level, atk, def)
    -- 为c添加陷阱怪物属性，extra_type为额外的卡片类型
    -- 注：陷阱怪物属性指的是同时作为怪物和陷阱，并且额外使一个魔法陷阱的格子不能使用。
end

function Card.TrapMonsterBlock(c)
    -- 使陷阱怪兽c占用一个魔法陷阱格子
end

function Card.CancelToGrave(c, cancel)
    -- 取消送墓确定状态，cancel=false则重新设置送墓确定状态
    --[[注：送墓确定状态指的是在场上发动的不留场的魔法和陷阱后，这些卡片的状态。
    送墓确定状态中的卡无法返回手牌和卡组，并且连锁结束时送去墓地。
    此函数的作用是取消此状态使其留场。用于光之护封剑和废铁稻草人等卡。]]
end

function Card.GetTributeRequirement(c)
    -- 返回通常召唤c所需要的祭品的最小和最大数量
end

function Card.GetBattleTarget(c)
    -- 返回与c进行战斗的卡
end

function Card.GetAttackableTarget(c)
    -- 返回c可攻击的卡片组g和能否直接攻击的布尔值b
end

function Card.SetHint(c, type, value)
    -- 为c设置类型为type的卡片提示信息
    -- type只能为以下值，对应的value类型为
    -- CHINT_TURN              回合数
    -- CHINT_CARD              卡片id
    -- CHINT_RACE              种族
    -- CHINT_ATTRIBUTE         属性
    -- CHINT_NUMBER            数字
    -- CHINT_DESC              描述
end

function Card.ReverseInDeck(c)
    -- 设置c在卡组中正面表示
end

function Card.SetUniqueOnField(c, s, o, unique_code, unique_location)
    -- 设置c以unique_code只能在场上[或怪兽区域或魔陷区域，由unique_location决定]只能存在1张
    -- s不为0会检查自己场上的唯一性，o不为0则检查对方场上的唯一性
    -- unique_location默认为 LOCATION_ONFIELD
end

function Card.CheckUniqueOnField(c, check_player)
    -- 检查c在check_player场上的唯一性
end

function Card.ResetNegateEffect(c, code1, ...)
    -- 重置c受到的卡号为code1, code2...的卡片的效果的影响
end

function Card.AssumeProperty(c, assume_type, assume_value)
    -- 把c的assume_type的数值当作assume_value使用（基因组斗士）
    -- assume_type为以下类型
    -- ASSUME_CODE         卡号
    -- ASSUME_TYPE         类型
    -- ASSUME_LEVEL        等级
    -- ASSUME_RANK         阶级
    -- ASSUME_ATTRIBUTE    属性
    -- ASSUME_RACE         种族
    -- ASSUME_ATTACK       攻击力
    -- ASSUME_DEFENCE      守备力
end

function Card.SetSPSummonOnce(c, spsummon_code)
    -- 设置c一回合只能进行1次特殊召唤（灵兽，波动龙）
    -- 相同的spsummon_code共用1个次数
end

-- =====Effect类=====
Effect = { }

function Effect.CreateEffect(c)
    -- 新建一个空效果,并且效果的拥有者为c
end

function Effect.GlobalEffect()
    -- 新建一个全局效果
end

function Effect.Clone(e)
    -- 新建一个效果e的副本
end

function Effect.Reset(e)
    -- 把效果e重置。重置之后不可以再使用此效果
end

function Effect.GetFieldID(e)
    -- 获取效果e的id
end

function Effect.SetDescription(e, desc)
    -- 为效果e设置效果描述
end

function Effect.SetCategory(e, cate)
    -- 设置Category属性
end

function Effect.SetCode(e, code)
    -- 为效果e设置Code属性
end

function Effect.SetProperty(e, prop1, prop2)
    -- 设置Property属性
    -- prop2 不是必须的
end

function Effect.SetRange(e, range)
    -- 为效果e设置Range属性
end

function Effect.SetAbsoluteRange(e, playerid, s_range, o_range)
    -- 设置target range属性并设置EFFECT_FLAG_ABSOLUTE_RANGE标志
    -- playerid != 0 s_range和o_range反转
end

function Effect.SetCountLimit(e, count, code)
    -- 设置一回合可以发动的次数（仅触发型效果有效）
    -- 设置一回合可以发动的次数count（仅触发型效果有效），相同的code(不等于0或1时)共用1个次数
    -- code包含以下数值具有特殊的性质
    -- EFFECT_COUNT_CODE_OATH          誓约使用次数
    -- EFFECT_COUNT_CODE_DUEL          决斗中使用次数
    -- EFFECT_COUNT_CODE_SINGLE        同一张卡多个效果公共使用次数（不限制同名卡）
end

function Effect.SetReset(e, reset_flag, reset_count)
    -- 设置reset参数
    -- 默认reset_count = 1
end

function Effect.SetLabel(e, label)
    -- 设置Label属性
end

function Effect.SetLabelObject(e, labelobject)
    -- 设置LabelObject属性
end

function Effect.SetHintTiming(e, s_time, o_time)
    -- 设置提示时点
end

function Effect.SetCondition(e, con_func)
    -- 设置Condition属性
end

function Effect.SetCost(e, cost_func)
    -- 设置Cost属性
end

function Effect.SetTarget(e, targ_func)
    -- 设置Target属性
end

function Effect.SetTargetRange(e, s_range, o_range)
    -- 为效果e设置Target Range属性
    --[[s_range指影响的我方区域。o_range值影响的对方区域。
    如果property属性中指定了EFFECT_FLAG_ABSOLUTE_RANGE标志，那么s_range指玩家1收到影响的区域，o_range指玩家2受到影响的区域。
    如果这是一个特殊召唤手续(EFFECT_SPSUMMON_PROC)的效果，并且property指定了EFFECT_FLAG_SPSUM_PARAM标志，
    那么s_range表示特殊召唤到的哪个玩家的场地，o_range表示可选择的表示形式。]]
end

function Effect.SetValue(e, val)
    -- 设置Value属性
end

function Effect.SetOperation(e, op_func)
    -- 设置Operation属性
end

function Effect.SetOwnerPlayer(e, player)
    -- 设置Owner player属性
end

function Effect.GetDescription(e)
    -- 返回效果描述
end

function Effect.GetCode(e)
    -- 返回code属性
end

function Effect.GetType(e)
    -- 返回Type属性
end

function Effect.GetProperty(e)
    -- 返回Property属性
end

function Effect.GetLabel(e)
    -- 返回Label属性
    -- 【返回】
    --[[
        int
        int
    --]]
end

function Effect.GetLabelObject(e)
    -- 返回LabelObject属性
end

function Effect.GetCategory(e)
    -- 返回Category属性
end

function Effect.GetOwner(e)
    -- 返回效果拥有者
end

function Effect.GetHandler(e)
    -- 返回效果在哪一张卡上生效(通常是注册该效果的卡)
end

function Effect.GetCondition(e)
    -- 返回condition属性
end

function Effect.GetTarget(e)
    -- 返回target属性
end

function Effect.GetCost(e)
    -- 返回cost属性
end

function Effect.GetValue(e)
    -- 返回value属性
end

function Effect.GetOperation(e)
    -- 返回operation属性
end

function Effect.GetActiveType(e)
    -- 返回e的效果类型（怪兽·魔法·陷阱）
    -- 与发动该效果的卡的类型不一定相同，比如灵摆效果视为魔法卡的效果
end

function Effect.IsActiveType(e, type)
    -- 检查e的效果类型（怪兽·魔法·陷阱）是否有type
end

function Effect.GetOwnerPlayer(e)
    -- 返回OwnerPlayer属性，一般是Owner的控制者
end

function Effect.GetHandlerPlayer(e)
    -- 返回当前者，一般是Handle的控制者
end

function Effect.IsHasProperty(e, prop1, prop2)
    -- 检查效果是否含有标志prop1[和prop2]
end

function Effect.IsHasCategory(e, cate)
    -- 检查效果是否含有效果分类cate
end

function Effect.IsHasType(e, type)
    -- 检查效果是否属于类型type
end

function Effect.IsActivatable(e, player)
    -- 检查效果e能否由player发动
end

function Effect.IsActivated(e)
    -- 检查效果e能否是发动的效果（机壳）
end

function Effect.GetActivateLocation(e)
    -- 返回效果e的发动区域
end

-- =====Group类=====
Group = { }

function Group.CreateGroup()
    -- 新建一个空的卡片组
end

function Group.KeepAlive(g)
    -- 让卡片组持续，把卡片组设置为效果的LabelObject需要设置
end

function Group.DeleteGroup(g)
    -- 删除卡片组g
end

function Group.Clone(g)
    -- 新建卡片组g的副本
end

function Group.FromCards(c, ...)
    -- 不定参数，把传入的所有卡组合成一个卡片组并返回
end

function Group.Clear(g)
    -- 清空卡片组
end

function Group.AddCard(g, c)
    -- 往g中增加c
end

function Group.RemoveCard(g, c)
    -- 把c从g中移除
end

function Group.GetFirst(g)
    -- 返回g中第一张卡，并重置当前指针到g中第一张卡。如果g中不存在卡则返回nil
end

function Group.GetNext(g)
    -- 返回并使指针指向下一张卡。如果g中不存在卡则返回nil
end

function Group.GetCount(g)
    -- 返回g中卡的数量
end

function Group.ForEach(g, f)
    -- 以g中的每一张卡作为参数调用一次f
end

function Group.Filter(g, f, ex, ...)
    -- 过滤函数。从g中筛选满足筛选条件f并且不等于ex的卡。从第4个参数开始为额外参数。
end

function Group.FilterCount(g, f, ex, ...)
    -- 过滤函数。和Group.Filter基本相同，不同之处在于此函数只返回满足条件的卡的数量
end

function Group.FilterSelect(g, player, f, min, max, ex, ...)
    -- 过滤函数。让玩家player从g中选择min-max张满足筛选条件f并且不等于ex的卡。从第7个参数开始为额外参数。
end

function Group.Select(g, player, min, max, ex)
    -- 让玩家player从g中选择min-max张不等于ex的卡。
end

function Group.RandomSelect(g, player, count)
    -- 让玩家player从g中随机选择count张卡。因为是随机算则，所以参数player基本无用，由系统随机选取。
end

function Group.IsExists(g, f, count, ex, ...)
    -- 过滤函数。检查g中是否存在至少count张满足筛选条件f并且不等于ex的卡。从第5个参数开始为额外参数。
end

function Group.CheckWithSumEqual(g, f, sum, min, max, ...)
    -- 子集求和判定函数。f为返回一个interger值的函数（通常用于同调判定）。
    -- 检查g中是否存在一个数量为min-max的子集满足以f对子集的每一个元素求值的和等于sum，从第6个参数开始为额外参数
    -- 比如：g:CheckWithSumEqual(Card.GetSynchroLevel,7,2)检查g中是否存在一个子集满足子集的同调用等级之和等于7
end

function Group.SelectWithSumEqual(g, player, f, sum, min, max, ...)
    -- 让玩家player从g中选取一个数量为min-max的子集使子集的特定函数的和等于sum，从第7个参数开始为额外参数
end

function Group.CheckWithSumGreater(g, f, sum, ...)
    -- 子集求和判定函数之二。f为返回一个interger值的函数（通常用于仪式判定）。
    -- 检查g中是否存在一个子集满足以f对子集的每一个元素求值的和刚好大于或者等于sum，从第4个参数开始为额外参数
    -- 比如：g:CheckWithSumGreater(Card.GetRitualLevel,8)检查g中是否存在一个子集满足子集的仪式用等级之和大于等于8
    -- 注：判定必须是“刚好”大于或者等于。以等级为例，要使等级合计大于等于8，可以选择LV1+LV7而不可以选择LV1+LV4+LV4
end

function Group.SelectWithSumGreater(g, player, f, sum, ...)
    -- 让玩家player从g中选取一个子集使子集的特定函数的和大于等于sum，从第5个参数开始为额外参数
end

function Group.GetMinGroup(g, f, ...)
    -- f为返回一个interger值的函数。从g中筛选出具有最小的f的值的卡。用于地裂等卡。
    -- 第2个返回值为这个最小值，从第3个参数开始为额外参数
end

function Group.GetMaxGroup(g, f, ...)
    -- f为返回一个interger值的函数。从g中筛选出具有最大的f的值的卡。用于地碎等卡。
    -- 第2个返回值为这个最大值，从第3个参数开始为额外参数
end

function Group.GetSum(g, f, ...)
    -- 计算g中所有卡的取值的总和。f为为每张卡的取值函数。
end

function Group.GetClassCount(g, f, ...)
    -- 计算g中所有卡的种类数量，f为分类的依据，返回相同的值视为同一种类，从第3个参数开始为额外参数
end

function Group.Remove(g, f, ex, ...)
    -- 从g中移除满足筛选条件f并且不等于ex的所有卡，第4个参数开始是额外参数
end

function Group.Merge(g1, g2)
    -- 把g2中的所有卡合并到g1。
    -- 注：g2本身不会发生变化。
end

function Group.Sub(g1, g2)
    -- 从g1中移除属于g2中的卡
    -- 注：g2本身不会发生变化
end

function Group.IsContains(g, c)
    -- 检查g中是否存在卡片c
end

function Group.SearchCard(g, f, ...)
    -- 过滤函数。返回g中满足筛选条件f的第一张卡。第三个参数为额外参数。
end


-- =====Duel类=====
Duel = { }

function Duel.EnableGlobalFlag(global_flag)
    -- 设置全局标记global_flag
end

function Duel.GetLP(player)
    -- 返回玩家player的当前LP
end

function Duel.SetLP(player, lp)
    -- 设置玩家player的当前LP为lp
end

function Duel.GetTurnPlayer()
    -- 返回当前的回合玩家
end

function Duel.GetTurnCount()
    -- 返回当前的回合数
end

function Duel.GetDrawCount(player)
    -- 返回玩家player每回合的规则抽卡数量
end

function Duel.RegisterEffect(e, player)
    -- 把效果作为玩家player的效果注册给全局环境。
end

function Duel.RegisterFlagEffect(player, code, reset_flag, property, reset_count)
    -- 此函数为玩家player注册全局环境下的标识效果。
    -- 此效果总是影响玩家的(EFFECT_FLAG_PLAYER_TARGET)并且不会被无效化。
    -- 其余部分与Card.RegisterFlagEffect相同
end

function Duel.GetFlagEffect(player, code)
    -- 返回玩家player的特定的标识效果的数量
end

function Duel.ResetFlagEffect(player, code)
    -- 手动reset玩家player的特定的标识效果
end

function Duel.Destroy(targets, reason, dest)
    -- 以reason原因破坏targets去dest。返回值是实际被破坏的数量。
    -- 如果reason包含REASON_RULE，则破坏事件将不会检查卡片是否免疫效果，不会触发代破效果并且无视“不能破坏”。
end

function Duel.Remove(targets, pos, reason)
    -- 以reason原因，pos表示形式除外targets。返回值是实际被操作的数量。
    -- 如果reason包含REASON_TEMPORARY，那么视为是暂时除外，可以通过Duel.ReturnToField返回到场上
end

function Duel.SendtoGrave(targets, reason)
    -- 以reason原因把targets送去墓地。返回值是实际被操作的数量。
end

function Duel.SendtoHand(targets, player, reason)
    -- 以reason原因把targets送去玩家player的手牌。返回值是实际被操作的数量。
    -- 如果player是nil则返回卡的持有者的手牌。
end

function Duel.SendtoDeck(targets, player, seq, reason)
    -- 以reason原因把targets送去玩家player的卡组。返回值是实际被操作的数量。
    -- 如果player是nil则返回卡的持有者的卡组。
    -- 如果seq=0，则是返回卡组最顶端；seq=1则是返回卡组最低端；其余情况则是返回最顶端并且标记需要洗卡组。
end

function Duel.PSendtoExtra(targets, player, reason)
    -- 以reason原因把灵摆卡targets送去玩家player的额外卡组
    -- 【必须】
    --[[
        Card/Group targets
        int player
        int reason
    --]]
    -- 如果player是nil则返回卡的持有者的额外卡组
    -- 【返回】实际被操作的数量
end

function Duel.GetOperatedGroup()
    -- 此函数返回之前一次卡片操作实际操作的卡片组。包括Duel.Destroy, Duel.Remove, Duel.SendtoGrave, Duel.SendtoHand, Duel.SendtoDeck, Duel.PSendtoExtra, Duel.Release, Duel.ChangePosition, Duel.SpecialSummon, Duel.DiscardDeck
end

function Duel.Summon(player, c, ignore_count, e, minc)
    -- 让玩家以效果e对c进行通常召唤(非set)，至少使用minc个祭品。
    -- 如果e=nil,那么就按照一般的通常召唤规则进行通常召唤。
    -- 如果ignore_count=true，则忽略每回合的通常召唤次数限制。
end

function Duel.SpecialSummonRule(player, c)
    -- 让玩家player对c进行特殊召唤手续。
end

function Duel.SynchroSummon(player, c, tuner, mg)
    -- 让玩家player以tuner作为调整[mg为素材]对c进行同调召唤手续。
end

function Duel.XyzSummon(player, c, mg, min, max)
    -- 让玩家player[从mg中][选min-max个素材]对c进行超量召唤手续
    -- mg非空且min为0则直接把mg全部作为超量素材
end

function Duel.MSet(player, c, ignore_count, e, minc)
    -- 让玩家以效果e对c进行通常召唤的Set，至少使用minc个祭品。
    -- 如果e=nil,那么就按照一般的通常召唤规则进行通常召唤。
    -- 如果ignore_count=true，则忽略每回合的通常召唤次数限制。
end

function Duel.SSet(player, c, target_player)
    -- 让玩家player把targets放置到target_player的魔法陷阱区
    -- 若targets为Group，则返回成功操作的数量
end

function Duel.CreateToken(player, code, cardsetCode, attack, defence, level, race, attribute)
    -- 以传入的参数数值新建一个Token并返回
end

function Duel.SpecialSummon(targets, sumtype, player, target_player, nocheck, nolimit, pos)
    -- 让玩家player以sumtype方式，pos表示形式把targets特殊召唤到target_player场上。
    -- 如果nocheck为true则无视卡的召唤条件。如果nolimit为true则无视卡的苏生限制。
    -- 返回值是特殊召唤成功的卡的数量。
end

function Duel.SpecialSummonStep(c, sumtype, sumplayer, target_player, nocheck, nolimit, pos)
    -- 此函数是Duel.SpecialSummon的分解过程，只特殊召唤一张卡c。
    -- 此函数用于一个效果同时特殊召唤多张参数不同的卡。
    -- 此函数必须和Duel.SpecialSummonComplete一起使用。
    -- 返回值表示是否特殊召唤成功。
end

function Duel.SpecialSummonComplete()
    -- 此函数在确定复数个Duel.SpecialSummonStep调用完毕之后调用。用于触发事件。
end

function Duel.RemoveCounter(player, s, o, countertype, count, reason)
    -- 让玩家player移除场上存在的countertype类型的count个指示物。
    -- 表示对player来说的己方的可移除指示物的位置，o表示对player来说的对方的可移除指示物的位置
end

function Duel.IsCanRemoveCounter(player, s, o, countertype, count, reason)
    -- 检查玩家player是否能移除场上的countertype类型的count个指示物。s和o参数作用同上。
end

function Duel.GetCounter(player, s, o, countertype)
    -- 返回场上存在的countertype类型的指示物的数量。s和o参数作用同上。
end

function Duel.ChangePosition(targets, au, ad, du, dd, noflip, setavailable)
    -- 改变targets的表示形式并返回实际操作的数量。
    -- 表侧攻击表示的变成au，里侧攻击表示的变成ad，表侧守备表示变成du，里侧守备表示变成dd
    -- 如果noflip=true则不触发翻转效果（但会触发反转时的诱发效果）
    -- 如果setavailable=true则对象之后变成里侧也发动反转效果
end

function Duel.Release(targets, reason)
    -- 以reason原因解放targets。返回值是实际解放的数量。
    -- 如果reason含有REASON_COST，则不会检查卡片是否不受效果影响
end

function Duel.MoveToField(c, move_player, target_player, dest, pos, enabled)
    -- 让玩家move_player把c移动的target_player的场上。dest只能是LOCATION_MZONE或者LOCATION_SZONE。
    -- pos表示可选表示形式。enable表示是否立刻适用c的效果。
end

function Duel.ReturnToField(c, pos)
    -- 把c返回到场上，pos默认值是离场前的表示形式，返回值表示是否成功。
    -- c必须是以REASON_TEMPORARY原因离场，并且离场后没有离开过那个位置。
end

function Duel.MoveSequence(c, seq)
    -- 移动c的序号。通常用于在场上换格子或者在卡组中移动到最上方或者最下方。
end

function Duel.SetChainLimit(f)
    -- 设定连锁条件，f的函数原型为 bool f(e,ep,tp)
    -- e表示要限制连锁的效果，ep表示要限制连锁的玩家，tp表示发动该效果的玩家
    -- 在cost或者target处理中调用此函数可以限制可以连锁的效果的种类（如超融合）。
    -- 如果f返回false表示不能连锁。一旦设置连锁条件后发生了新的连锁那么连锁条件将会解除。
end

function Duel.SetChainLimitTillChainEnd(f)
    -- 功能同Duel.SetChainLimit，但是此函数设定的连锁条件直到连锁结束才会解除。
end

function Duel.GetChainMaterial(player)
    -- 返回玩家player受到的连锁素材的效果。此函数仅用于融合类卡的效果。
end

function Duel.ConfirmDeckTop(player, count)
    -- 确认玩家player卡组最上方的count张卡。双方均可确认。
end

function Duel.ConfirmCards(player, targets)
    -- 给玩家player确认targets
end

function Duel.SortDecktop(sort_player, target_player, count)
    -- 让玩家sort_player对玩家target_player的卡组最上方count张卡进行排序
end

function Duel.CheckEvent(event, get_info)
    -- 检查当前是否是event时点
    -- 若get_info=true并且是正确的时点则还返回触发时点的信息 eg,ep,ev,re,r,rp
end

function Duel.RaiseEvent(eg, code, re, r, rp, ep, ev)
    -- 以eg,ep,ev,re,r,rp触发一个时点
end

function Duel.RaiseSingleEvent(ec, code, re, r, rp, ep, ev)
    -- 以eg,ep,ev,re,r,rp为卡片ec触发一个单体时点
end

function Duel.CheckTiming(timing)
    -- 检查当前是否是timing提示时点
end

function Duel.GetEnvironment()
    -- 返回两个值，表示当前场地代号，以及当前场地效果的来源玩家。
    -- 场地代号指当前生效的场地卡的代号，或者海神的巫女把场地变化效果的值。
    -- 来源玩家指当前生效的场地卡的控制者，或者海神的巫女等卡的控制者。
end

function Duel.IsEnvironment(code, player)
    -- 检查玩家player是否为场地代号code的来源玩家
    -- 场地代号指当前生效的场地卡的代号，或者海神的巫女把场地变化效果的值
    -- 来源玩家指当前生效的场地卡的控制者，或者海神的巫女等卡的控制者
end

function Duel.Win(player, reason)
    -- 当前效果处理完令player以win_reason决斗胜利
end

function Duel.Draw(player, count, reason)
    -- 让玩家player以原因reason抽count张卡。返回实际抽的卡的数量。
    -- 如果reason含有REASON_RULE则此次抽卡不受“不能抽卡”的效果的影响。
end

function Duel.Damage(player, value, reason)
    -- 以reason原因给与玩家player造成value的伤害。返回实际收到的伤害值。
    -- 如果受到伤害变成回复等效果的影响时，返回值为0.
end

function Duel.Recover(player, value, reason)
    -- 以reason原因使玩家player回复value的LP。返回实际的回复值。
    -- 如果受到回复变成伤害等效果的影响时，返回值为0.
end

function Duel.Equip(player, c1, c2, up, is_step)
    -- 把c1作为玩家player的装备卡装备给c2。返回值表示是否成功。
    -- up=false则保持装备卡之前的表示形式
    -- is_step=true则是装备过程的分解，需要配合Duel.EquipComplete使用
end

function Duel.EquipComplete()
    -- 在调用Duel.Equip时，若is_step参数为true，则需调用此函数触发时点
end

function Duel.GetControl(player, c, reset_phase, reset_count)
    -- 让玩家player得到c的控制权。返回值表示是否成功。
end

function Duel.SwapControl(c1, c2, reset_phase, reset_count)
    -- 交换c1和c2的控制权。返回值表示是否成功。
end

function Duel.CheckLPCost(player, cost)
    -- 检查玩家player是否能支付cost点lp
end

function Duel.PayLPCost(player, cost)
    -- 让玩家player支付cost点lp
end

function Duel.DiscardDeck(player, count, reason)
    -- 以原因reason把玩家player的卡组最上端count张卡送去墓地.返回实际转移的数量。
end

function Duel.DiscardHand(player, f, min, max, reason, ex, ...)
    -- 过滤函数。让玩家player选择并丢弃满足筛选条件f并不等于ex的min-max张手卡。
    -- 第7个参数开始为额外参数。
end

function Duel.DisableShuffleCheck()
    -- 使下一个操作不检查是否需要洗卡组或者洗手卡。
    -- 注：如果不调用此函数，除了调用Duel.DiscardDeck和Duel.Draw之外，
    -- 从卡组中取出卡或者把卡加入手卡或者把卡加入卡组（非最上端或最底端）时，
    -- 系统会自动在效果处理结束时洗卡组或手卡。
    -- 如果不希望如此，比如从卡组顶端除外一张卡等操作，那么需要调用此函数。
    -- 此函数仅保证紧接着的一次操作不会进行洗卡检测。
end

function Duel.ShuffleDeck(player)
    -- 手动洗玩家player的卡组
    -- 注：会重置洗卡检测的状态
end

function Duel.ShuffleHand(player)
    -- 手动洗玩家player的手卡
    -- 注：会重置洗卡检测的状态
end

function Duel.ShuffleSetCard(g)
    -- 洗切覆盖在怪兽区域的卡（魔术礼帽）
end

function Duel.ChangeAttacker(c)
    -- 把当前的攻击卡替换成c进行攻击
    -- 注：此函数会使原来的攻击怪兽视为攻击过
end

function Duel.ReplaceAttacker(c)
    -- 用c代替当前攻击的卡进行伤害阶段
end

function Duel.ChangeAttackTarget(c)
    -- 把当前的攻击目标替换成c。如果c=nil则变成直接攻击。
end

function Duel.ReplaceAttackTarget(c)
    -- (预留）
end

function Duel.CalculateDamage(c1, c2)
    -- 令c1与c2进行战斗伤害计算
end

function Duel.GetBattleDamage(player)
    -- 返回玩家player在本次战斗中收到的伤害
end

function Duel.ChangeBattleDamage(player, value, check)
    -- 把玩家player在本次战斗中收到的伤害变成value
    -- heck为false则原本战斗伤害为0也改变伤害
end

function Duel.ChangeTargetCard(chainc, g)
    -- 把连锁chainc的对象换成g
end

function Duel.ChangeTargetPlayer(chainc, player)
    -- 把连锁chainc的对象玩家换成player
end

function Duel.ChangeTargetParam(chainc, param)
    -- 把连锁chainc的对象参数换成param
end

function Duel.BreakEffect()
    -- 中断当前效果，使之后的效果处理视为不同时处理。
    -- 此函数会造成错时点。
end

function Duel.ChangeChainOperation(chainc, f)
    -- 把连锁chainc的效果的处理函数换成f。用于实现“把效果变成”等的效果
end

function Duel.NegateActivation(chainc)
    -- 使连锁chainc的发动无效，返回值表示是否成功
end

function Duel.NegateEffect(chainc)
    -- 使连锁chainc的效果无效，返回值表示是否成功
end

function Duel.NegateRelatedChain(c, reset)
    -- 使卡片c的已经发动的连锁都无效化，发生reset事件则重置
end

function Duel.NegateSummon(targets)
    -- 使正在召唤，反转召唤，特殊召唤的targets的召唤无效
end

function Duel.IncreaseSummonedCount(c)
    -- 手动消耗1次玩家[对于卡片c]的通常召唤的次数
end

function Duel.CheckSummonCount(c)
    -- 检查回合玩家本回合是否还能通常召唤[卡片c]
end

function Duel.GetLocationCount(player, location, use_player, reason)
    -- 返回玩家player的场上location可用的空格数
    -- location只能是LOCATION_MZONE或者LOCATION_SZONE
    -- reason为LOCATION_REASON_TOFIELD或LOCATION_REASON_CONTROL，默认为前者
    -- 额外参数与凯撒斗技场的效果有关
end

function Duel.GetFieldCard(player, location, sequence)
    -- 返回玩家player的场上位于location序号为sequence的卡，常用于获得场地区域·灵摆区域的卡
end

function Duel.CheckLocation(player, location, seq)
    -- 检查玩家player的场上位于location序号为seq的空格是否可用
end

function Duel.GetCurrentChain()
    -- 返回当前正在处理的连锁序号
end

function Duel.GetChainInfo(chainc, ...)
    --[[
    返回连锁chainc的信息。如果chainc=0，则返回当前正在处理的连锁的信息。
    此函数根据传入的参数个数按顺序返回相应数量的返回值。参数可以是:
    CHAININFO_CHAIN_COUNT           连锁序号
    CHAININFO_TRIGGERING_EFFECT     连锁的效果
    CHAININFO_TRIGGERING_PLAYER     连锁的玩家
    CHAININFO_TRIGGERING_CONTROLER  连锁发生位置所属玩家
    CHAININFO_TRIGGERING_LOCATION   连锁发生位置
    CHAININFO_TRIGGERING_SEQUENCE   连锁发生的位置的序号
    CHAININFO_TARGET_CARDS          连锁的对象卡片组
    CHAININFO_TARGET_PLAYER         连锁的对象玩家
    CHAININFO_TARGET_PARAM          连锁的对象参数
    CHAININFO_DISABLE_REASON        连锁被无效的原因效果
    CHAININFO_DISABLE_PLAYER        连锁被无效的原因玩家
    CHAININFO_CHAIN_ID              连锁的唯一标识
    举例：Duel.GetChainInfo(0, CHAININFO_TRIGGERING_LOCATION, CHAININFO_TARGET_CARDS)
    将会返回当前连锁发生的位置和对象卡。
]]
end

function Duel.GetFirstTarget()
    -- 返回连锁的所有的对象卡，一般只有一个对象时使用
end

function Duel.GetCurrentPhase()
    -- 返回当前的阶段
end

function Duel.SkipPhase(player, phase, reset_flag, reset_count, value)
    -- 跳过玩家player的phase阶段，并在特定的阶段后reset。reset参数和效果相同。
    -- value只对phase=PHASE_BATTLE才有用，value=1跳过战斗阶段的结束步骤，用于“变成回合结束阶段”等（招财猫王，闪光弹）
end

function Duel.IsDamageCalculated()
    -- 用于在伤害阶段检查是否已经计算了战斗伤害。
end

function Duel.GetAttacker()
    -- 返回此次战斗攻击的卡
end

function Duel.GetAttackTarget()
    -- 返回此次战斗被攻击的卡。如果返回nil表示是直接攻击。
end

function Duel.NegateAttack()
    -- 使本次攻击无效，返回值表示是否成功
    -- 此次攻击已经被其他效果无效或导致攻击的卡不能攻击则返回false
end

function Duel.ChainAttack(c)
    -- 使攻击卡[或卡片c]再进行1次攻击（开辟，破灭的女王）
end

function Duel.Readjust()
    -- 刷新场上的卡的信息。
    -- 非特定情况或者不清楚原理请勿使用此函数以免形成死循环。
end

function Duel.AdjustInstantly(c)
    -- 似乎是处理场上的卡[或卡片c相关的卡]效果相互无效
end

function Duel.GetFieldGroup(player, s, o)
    -- 返回指定位置的卡。s指对玩家player来说的己方的位置，o指对玩家player来说的对方的位置。
    -- 下面提到的指定位置均为此意。
    -- 比如Duel.GetFieldGroup(0,LOCATION_GRAVE,LOCATION_MZONE)
    -- 返回玩家1墓地和玩家2的怪兽区的所有卡
end

function Duel.GetFieldGroupCount(player, s, o)
    -- 返回指定位置的卡的数量
end

function Duel.GetDecktopGroup(player, count)
    -- 返回玩家player的卡组最上方的count张卡
end

function Duel.GetMatchingGroup(f, player, s, o, ex, ...)
    -- 过滤函数，返回指定位置满足过滤条件f并且不等于ex的卡。
    -- 第6个参数开始为额外参数。
end

function Duel.GetMatchingGroupCount(f, player, s, o, ex, ...)
    -- 过滤函数，返回指定位置满足过滤条件f并且不等于ex的卡的数量
end

function Duel.GetFirstMatchingCard(f, player, s, o, ex, ...)
    -- 过滤函数，返回指定位置满足过滤条件f并且不等于ex的第一张卡。
    -- 第6个参数开始为额外参数。
end

function Duel.IsExistingMatchingCard(f, player, s, o, count, ex, ...)
    -- 过滤函数，检查指定位置是否存在至少count张满足过滤条件f并且不等于ex的卡。
    -- 第7个参数开始为额外参数。
end

function Duel.SelectMatchingCard(sel_player, f, player, s, o, min, max, ex, ...)
    -- 过滤函数，让玩家sel_player选择指定位置满足过滤条件f并且不等于ex的min-max张卡。
    -- 第9个参数开始为额外参数。
end

function Duel.GetReleaseGroup(player, use_hand)
    -- 返回玩家player可解放（非上级召唤用)的卡片组，use_hand为true则包括手卡
end

function Duel.GetReleaseGroupCount(player, use_hand)
    -- 返回玩家player可解放（非上级召唤用)的卡片数量，use_hand为true则包括手卡
end

function Duel.ChecktReleaseGroup(player, f, count, ex, ...)
    -- 过滤函数，检查玩家player场上是否存在至少count张不等于ex的满足条件f的可解放的卡（非上级召唤用）
    -- 第5个参数开始为额外参数
end

function Duel.SelectReleaseGroup(player, f, min, max, ex, ...)
    -- 过滤函数，让玩家player选择min-max张不等于ex的满足条件f的可解放的卡（非上级召唤用）
end

function Duel.CheckReleaseGroupEx(player, f, count, ex, ...)
    -- 检查玩家player场上·手卡是否存在至少count张满足过滤条件f并且不等于ex的可解放的卡（非上级召唤用）
end

function Duel.SelectReleaseGroupEx(player, f, min, max, ex, ...)
    -- 过滤函数，让玩家player从场上·手卡选择min-max张不等于ex的满足条件f的可解放的卡（非上级召唤用）
end

function Duel.GetTributeGroup(c)
    -- 返回用于通常召唤c可解放（上级召唤用)的卡片组
end

function Duel.GetTributeCount(c, mg, ex)
    -- 返回[mg中]用于通常召唤c的祭品数量，ex=true则允许对方场上的怪兽（太阳神之翼神龙-球体形）
    -- 此数量不一定等于Duel.GetTributeGroup的返回值中的卡片数量
    -- 因为某些卡可以作为两个祭品来使用
end

function Duel.SelectTribute(player, c, min, max, mg, ex)
    -- 让玩家player[从mg中]选择用于通常召唤c的min-max个祭品，ex=true则允许对方场上的怪兽（太阳神之翼神龙-球体形）
end

function Duel.GetTargetCount(f, player, s, o, ex, ...)
    -- 基本同Duel.GetMatchingGroupCount，不同之处在于需要追加判定卡片是否能成为当前正在处理的效果的对象。
end

function Duel.IsExistingTarget(f, player, s, o, count, ex, ...)
    -- 过滤函数，检查指定位置是否存在至少count张满足过滤条件f并且不等于ex并且可以成为当前正在处理的效果的对象的卡。
    -- 第7个参数开始为额外参数。
end

function Duel.SelectTarget(sel_player, f, player, s, o, min, max, ex, ...)
    -- 过滤函数，让玩家sel_player选择指定位置满足过滤条件f并且不等于ex并且可以成为当前正在处理的效果的对象的min-max张卡。
    -- 第9个参数开始为额外参数。
    -- 此函数会同时将当前正在处理的连锁的对象设置成选择的卡
end

function Duel.SelectFusionMaterial(player, c, g, gc, chkf)
    -- 让玩家player从g中选择一组[必须包含gc在内的]融合怪兽c的融合素材
    -- 根据c的种类为EFFECT_FUSION_MATERIAL的效果的Operation操作
end

function Duel.SetFusionMaterial(g)
    -- 设置g为需要使用的融合素材
end

function Duel.SetSynchroMaterial(g)
    -- 设置g为需要使用的同调素材
end

function Duel.SelectSynchroMaterial(player, c, f1, f2, min, max, smat, mg)
    -- 让玩家player[从mg中]选择用于同调c需要的[必须包含smat在内（如果有mg~=nil则忽略此参数）]满足条件的数量为min-max的一组素材。
    -- f1是调整需要满足的过滤条件。f2是调整以外的部分需要满足的过滤条件。
end

function Duel.CheckSynchroMaterial(c, f1, f2, min, max, smat, mg)
    -- 检查[mg中]是否存在一组[必须包括smat在内的]满足条件的min-max张卡作为同调召唤c的素材
    -- f1是调整需要满足的过滤条件，f2是调整以外的部分需要满足的过滤条件
end

function Duel.SelectTunerMaterial(player, c, tuner, f1, f2, min, max, mg)
    -- 让玩家[从mg中]选择用于同调c需要的满足条件的以tuner作为调整的min-max张卡的一组素材
    -- f1是调整需要满足的过滤条件，f2是调整以外的部分需要满足的过滤条件
end

function Duel.CheckTunerMaterial(c, tuner, f1, f2, min, max, mg)
    -- 检查以tuner作为调整[在mg中]是否存在一组满足条件的min-max张卡作为同调召唤c的素材
    -- f1是调整需要满足的过滤条件，f2是调整以外的部分需要满足的过滤条件
end

function Duel.GetRitualMaterial(player)
    -- 返回玩家player可用的用于仪式召唤素材的卡片组。
    -- 包含手上，场上可解放的以及墓地的仪式魔人等卡。
end

function Duel.ReleaseRitualMaterial(g)
    -- 解放仪式用的素材g。如果是墓地的仪式魔人等卡则除外。
end
function Duel.SetSelectedCard(cards)
    -- 将cards设置为Group.SelectWithSumEqual或Group.SelectWithSumGreater已选择的卡片，
end

function Duel.SetTargetCard(g)
    -- 把当前正在处理的连锁的对象设置成g。
    -- 注，这里的对象指的的广义的对象，包括不取对象的效果可能要处理的对象。
end

function Duel.ClearTargetCard()
    -- 把当前正在处理的连锁的对象全部清除
end

function Duel.SetTargetPlayer(player)
    -- 把当前正在处理的连锁的对象玩家设置成player。
end

function Duel.SetTargetParam(param)
    -- 把当前正在处理的连锁的对象参数设置成param。
end

function Duel.SetOperationInfo(chainc, category, targets, count, target_player, target_param)
    -- 设置当前处理的连锁的操作信息。此操作信息包含了效果处理中确定要处理的效果分类。
    -- 比如潜行狙击手需要设置CATEGORY_DICE，但是不能设置CATEGORY_DESTROY，因为不确定。
    -- 对于破坏效果，targets需要设置成发动时可能成为连锁的影响对象的卡，并设置count为发动时确定的要处理的卡的数量。
    -- 比如黑洞发动时，targets需要设定为场上的所有怪物，count设置成场上的怪的数量。
    -- 对于CATEGORY_SPECIAL_SUMMON,CATEGORY_TOHAND,CATEGORY_TODECK等分类，如果取对象则设置targets为对象，count为对象的数量；
    -- 如果不取对象则设置targets为nil,count为预计要处理的卡的数量，并设置target_param为预计要处理的卡的位置。
    -- 例如增援：SetOperationInfo(0,CATEGORY_TOHAND,nil,1,0,LOCATION_DECK)。
    -- 操作信息用于很多效果的发动的检测，例如星尘龙，王家沉眠之谷等。
end

function Duel.GetOperationInfo(chainc, category)
    -- 返回连锁chainc的category分类的操作信息。返回值为5个，第一个返回值是false的话表示不存在该分类。
    -- 后4个返回值对应Duel.SetOperationInfo的后4个参数。
end

function Duel.GetOperationCount(chainc)
    -- 返回连锁chainc包含的操作分类的数量
end

function Duel.CheckXyzMaterial(c, f, lv, min, max, mg)
    -- 检查场上或mg中是否存在超量召唤c的超量用等级为lv的min-max个满足条件f的叠放素材
end

function Duel.SelectXyzMaterial(player, c, f, lv, min, max, mg)
    -- 让玩家player为超量怪兽c[从mg中]选择超量用等级为lv的min-max个满足条件f的叠放素材
end

function Duel.GetExceedMaterial(c)
    -- 返回c的超量素材
end

function Duel.Overlay(c, ocard)
    -- 把ocard作为c的叠放卡叠放
end

function Duel.GetOverlayGroup(player, s, o)
    -- 返回指定位置的所有叠放的卡
end

function Duel.GetOverlayCount(player, s, o)
    -- 返回指定位置的所有叠放的卡的数量
end

function Duel.CheckRemoveOverlayCard(player, s, o, count, reason)
    -- 检查player能否以原因reason移除指定位置至少count张卡
end

function Duel.RemoveOverlayCard(player, s, o, min, max, reason)
    -- 以reason原因移除指定位置的min-max张叠放卡
end

function Duel.Hint(hint_type, player, desc)
    -- 给玩家player发送hint_type类型的消息提示，提示内容为desc
    --[[ hint_type只能为以下类型：
     HINT_SELECTMSG将提示内容写入缓存，用于选择卡片的提示，例如Duel.SelectMatchingCard等
     HINT_OPSELECTED向player提示"对方选择了：..."，常用于向对方玩家提示选择发动了什么效果
     HINT_CARD此时desc应为卡号，手动显示卡片发动的动画，常用于提示不入连锁的处理
     HINT_RACE此时desc应为种族，向player提示"对方宣言了：..."种族
     HINT_ATTRIB此时desc应为属性，向player提示"对方宣言了：..."属性
     HINT_CODE此时desc应为卡号，向player提示"对方宣言了：..."卡片
     HINT_NUMBER此时desc视为单纯的数字，向player提示"对方选择了：..."数字
     HINT_MESSAGE弹出一个对话框显示信息
     HINT_EVENT将提示内容写入缓存，用于时点的提示信息（诱发即时效果的提示）
     HINT_EFFECT同HINT_CARD
    --]]
end

function Duel.HintSelection(g)
    -- 手动为g显示被选为对象的动画效果
end

function Duel.SelectEffectYesNo(player, c)
    -- 让玩家选择是否发动卡片C的效果
end

function Duel.SelectYesNo(player, desc)
    -- 让玩家选择是或否
end

function Duel.SelectOption(player, ...)
    -- 让玩家选择选项。从第二个参数开始，每一个参数代表一条选项。
    -- 返回选择的选项的序号。
end

function Duel.SelectSequence()
    -- (预留）
end

function Duel.SelectPosition(player, c, pos)
    -- 让玩家player选择c的表示形式并返回
end

function Duel.SelectDisableField(player, count, s, o, filter)
    -- 让玩家player选择指定位置满足标记条件filter的count个可用的空格并返回选择位置的标记
    -- 常用于选择区域不能使用或移动怪兽格子
    -- 位置标记的定义如下
    -- flag = 0;
    -- seq为在玩家p，位置l中选择的格子序号
    -- for(int32 i = 0; i < count; ++i) {
    -- flag |= 1 << (seq[i] + (p[i] == player ? 0 : 16) + (l[i] == LOCATION_MZONE ? 0 : 8));
    -- }
end

function Duel.AnnounceRace(player, count, available)
    -- 让玩家player从可选的种族中宣言count个种族。available是所有可选种族的组合值。
end

function Duel.AnnounceAttribute(player, count, available)
    -- 让玩家player从可选的属性中宣言count个属性。available是所有可选属性的组合值。
end

-- function Duel.AnnounceLevel(player)
-- 【废弃】已经不能正常使用
-- 让玩家player宣言一个等级
-- end

function Duel.AnnounceCard(player, type)
    -- 让玩家player宣言一个[type类型的]卡片代号
    -- 默认情况下type=TYPE_MONSTER+TYPE_SPELL+TYPE_TRAP
end

function Duel.AnnounceType(player)
    -- 让玩家player宣言一个卡片类型。
end

function Duel.AnnounceNumber(player, ...)
    -- 让玩家player宣言一个数字。从第二个参数开始，每一个参数代表一个可宣言的数字。
    -- 第一个返回值的宣言的数字，第二个返回值是宣言数字在所有选项中的位置。
end

function Duel.AnnounceCoin(player)
    -- 让玩家player宣言硬币的正反面。
end

function Duel.TossCoin(player, count)
    -- 让玩家player投count(<=5)次硬币，返回值为count个结果，0或者1.
end

function Duel.TossDice(player, count1, count2)
    -- 让玩家player投count1次骰子[，1-player投count2次骰子](count1+count2<=5)，
    -- 返回值为count1+count2个结果，结果是1-6.
end

function Duel.GetCoinResult()
    -- 返回当前投硬币的结果
end

function Duel.GetDiceResult()
    -- 返回当前掷骰子的结果
end

function Duel.SetCoinResult(...)
    -- 强行修改投硬币的结果。此函数用于永续的EVENT_TOSS_COIN事件中
end

function Duel.SetDiceResult(...)
    -- 强行修改投骰子的结果。此函数用于永续的EVENT_TOSS_DICE事件中
end

function Duel.IsPlayerAffectedByEffect(player, code)
    -- 检查player是否受到种类为code的效果影响，如果有就返回该效果
end

function Duel.IsPlayerCanDraw(player, count)
    -- 检查玩家player是否可以效果抽[count张]卡
end

function Duel.IsPlayerCanDiscardDeck(player, count)
    -- 检查玩家player是否可以把卡组顶端的卡送去墓地
end

function Duel.IsPlayerCanDiscardDeckAdCost(player, count)
    -- 检查玩家player是否可以把卡组顶端的卡送去墓地作为cost。
    -- 当卡组没有足够数量的卡，或者当卡组中的卡受到送墓转移效果的影响时
    -- （如大宇宙，次元裂缝，即使不是全部）此函数会返回false
end

function Duel.IsPlayerCanSummon(player, sumtype, c)
    -- 检查玩家player是否可以通常召唤[c，以sumtype方式]
    -- 如果需要可选参数，则必须全部使用
    -- 仅当玩家收到"不能上级召唤"等效果的影响时返回false
end

function Duel.IsPlayerCanSpecialSummon(player, sumtype, sumpos, target_player, c)
    -- 检查玩家player能否特殊召唤[c到target_player场上，以sumtype召唤方式，sumpos表示形式]
    -- 如果需要可选参数，则必须全部使用
end

function Duel.IsPlayerCanFlipSummon(player, c)
    -- 检查玩家player是否可以反转召唤c。
end

function Duel.IsPlayerCanSpecialSummonMonster(player, code, cardsetCode, type, atk, def, level, race, attribute, pos, target_player)
    -- 检查玩家player是否可以以pos的表示形式特殊召唤特定属性值的怪物到target_player场上。此函数通常用于判定是否可以特招token和陷阱怪物。
end

function Duel.IsPlayerCanSpecialSummonCount(player, count)
    -- 检查玩家player能否特殊召唤count次
end

function Duel.IsPlayerCanRelease(player, c)
    -- 检查玩家是否能解放c
end

function Duel.IsPlayerCanRemove(player, c)
    -- 检查玩家是否能除外c
end

function Duel.IsPlayerCanSendtoHand(player, c)
    -- 检查玩家是否能把c送去手牌
end

function Duel.IsPlayerCanSendtoGrave(player, c)
    -- 检查玩家是否能把c送去墓地
end

function Duel.IsPlayerCanSendtoDeck(player, c)
    -- 检查玩家是否能把c送去卡组
end

function Duel.IsChainNegatable(chainc)
    -- 检查连锁chainc的发动是否可以被无效化
end

function Duel.IsChainDisablable(chainc)
    -- 检查连锁chainc的效果是否可以被无效化
end

function Duel.CheckChainTarget(chainc, c)
    -- 检查c是否是连锁chainc的正确的对象
end

function Duel.CheckChainUniqueness()
    -- 检查当前连锁中是否存在同名卡的发动。true表示无同名卡。
end

function Duel.GetActivityCount(player, activity_type, ...)
    -- 返回player进行对应的activity_type操作的次数
    -- activity_type为以下类型
    -- ACTIVITY_SUMMON         召唤（不包括通常召唤的放置）
    -- ACTIVITY_NORMALSUMMON   通常召唤（包括通常召唤的放置）
    -- ACTIVITY_SPSUMMON       特殊召唤
    -- ACTIVITY_FLIPSUMMON     反转召唤
    -- ACTIVITY_ATTACK         攻击
    -- ACTIVITY_BATTLE_PHASE   进入战斗阶段
end

function CheckPhaseActivity()
    -- 检查玩家在当前阶段是否有操作（是否处于阶段开始时，如七皇之剑）
end

function Duel.AddCustomActivityCounter(counter_id, activity_type, f)
    -- 设置操作类型为activity_type、代号为counter_id的计数器，放在initial_effect函数内
    -- f为过滤函数，以Card类型为参数，返回值为false的卡片进行以下类型的操作，计数器增加1（目前最多为1）
    -- activity_type为以下类型
    -- ACTIVITY_SUMMON         召唤（不包括通常召唤的set）
    -- ACTIVITY_NORMALSUMMON   通常召唤（包括通常召唤的set）
    -- ACTIVITY_SPSUMMON       特殊召唤
    -- ACTIVITY_FLIPSUMMON     反转召唤
    -- ACTIVITY_CHAIN          发动效果
end

function Duel.GetCustomActivityCount(counter_id, player, activity_type)
    -- 代号为counter_id的计数器的计数，返回player进行以下操作的次数（目前最多为1）
    -- activity_type为以下类型
    -- ACTIVITY_SUMMON         召唤（不包括通常召唤的set）
    -- ACTIVITY_NORMALSUMMON   通常召唤（包括通常召唤的set）
    -- ACTIVITY_SPSUMMON       特殊召唤
    -- ACTIVITY_FLIPSUMMON     反转召唤
    -- ACTIVITY_CHAIN          发动效果
end

function Duel.IsAbleToEnterBP()
    -- 检查回合玩家能否进入战斗阶段
end

function Duel.VenomSwampCheck(e, c)
    -- 蛇毒沼泽专用。把攻击力被其效果变成0的卡片破坏
end

function Duel.SwapDeckAndGrave(player)
    -- 现世与冥界的逆转专用。把玩家player的卡组和墓地交换
end

function Duel.MajesticCopy(c1, c2)
    -- 救世星龙专用。把c2记述的效果复制给c1
    -- 强制发动的效果可以选择是否发动
end

function Duel.CheckSummonActivity(player)
    -- 检查玩家player本回合有没有进行过召唤的行为。召唤被无效视作进行过召唤行为。
end

function Duel.CheckNormalSummonActivity(player)
    -- 检查玩家player本回合有没有进行过通常召唤的行为。包括召唤和set
end

function Duel.CheckFlipSummonActivity(player)
    -- 检查玩家player本回合有没有进行过反转召唤的行为。
end

function Duel.CheckFlipSummonActivity(player)
    -- 检查玩家player本回合有没有进行过特殊召唤的行为。
    -- 特殊召唤的行为包括：进行了入连锁和不入连锁的特殊召唤；发动了确定要特殊召唤的效果但是效果被无效
    -- 不包括：发动了确定要特殊召唤的效果但是发动被无效
end

function Duel.CheckAttackActivity(player)
    -- 检查玩家player本回合有没有进行过攻击。
end