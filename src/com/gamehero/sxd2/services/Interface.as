package com.gamehero.sxd2.services
{
	
	/**
	 * 静态服务器接口名
	 * @author xuwenyi
	 * @create 2013-11-29
	 **/
	public class Interface
	{
		//连接准备
		public static const SOCKET_VALIDATE:String = "100";
		public static const SOCKET_CREATE:String = "101";
		
		// 登录相关(登录阶段还没有配置表,所以直接用id)
		public static const LOGIN:String = "1001";
		public static const SHOW_CU:String = "1002";
		public static const LS_RandName:String = "1003";
		public static const CREATE_USER:String = "1004";
		public static const ENTER_GAME:String = "1005";

		// 网关
		public static const VALIDATE:String = "2001";
		
		// GM指令
		public static const GS_GM:String = "3008";
		
		// 更新服务器状态(时间等)
		public static const UPDATE_SERVER_STATUS:String = "3001";
		
		// 通知客户端更新
		public static const UPDATE_CLIENT:String = "3852";
		
		// 地图
		public static const ROLE_INFO:String = "3002";
		public static const INTO_SCENE:String = "3003";
		public static const LEAVE_SCENE:String = "3004";
		public static const UPDATE_SCENE:String = "3005";
		public static const GET_SCENE_INFO:String = "3006";
		/*取消该接口public static const LEVEL_UP:String = "GS_levelup";*/
		
		// 人物、背包
		public static const PACK_GET_ITEMS:String = "3102";
		public static const PACK_ARRANGE:String = "3101";
		public static const EQUIP_GET_ITEMS:String = "3111";
		public static const PACK_MOVE:String = "3112";
		public static const PACK_EQUIP:String = "3113";
		//		public static const PACK_NEWITEMS:String = "GS_Pack_NewItems";
		public static const UPDATE_ITEMS:String = "3110";
		public static const PACK_USE_ITEM:String = "3115";
		public static const PACK_Storage:String = "3114";
		
		public static const PACK_UNLOCK_STATUS:String = "3104";
		public static const GS_Pack_Unlock:String = "3103";
		public static const GS_Pack_ItemStore:String = "3107";
		public static const GS_Pack_BuyBackStore:String = "3108";
		public static const GS_Pack_Sell:String = "3106";
		public static const GS_Pack_Buy:String = "3109";
		public static const GS_Pack_Decompose:String = "3105";
		
		//合成
		public static const GS_Compose:String = "3119";
		
		// 任务
		public static const GET_TASK_LIST:String = "3251";
		public static const TASK_UPDATE:String = "3252";
		public static const TASK_NEW:String = "3253";
		public static const TASK_REMOVE:String = "3254";
		public static const TASK_ACTION:String = "3255";
		public static const DTASK_COMPLETE:String = "3256";
		public static const MTASK_COMPLETE:String = "3257";
		
		// 战斗
		public static const BATTLE_CREATE:String = "3051";
		public static const BATTLE_INTO:String = "3052";
		public static const BATTLE_END:String = "3057";
		public static const BATTLE_UPDATE_ROLE:String = "3053";
		public static const BATTLE_BEGIN:String = "3054";
		public static const BATTLE_USER_ACTION:String = "3055";
		public static const BATTLE_VOLITION_BURST:String = "3056";
		public static const BATTLE_TIMEOUT:String = "3058";
		public static const GS_BattleNext:String = "3059";
		public static const GS_BattleWall:String = "3060";
		public static const GS_BattleEscape:String = "3061";
		  
		// 伙伴
		public static const HERO_LIST:String = "3151";
		public static const HERO_INHERIT_INFO:String = "3153";
		public static const HERO_INHERIT:String = "GS_HeroInherit";
		public static const RELICS_UP:String = "3162";//伙伴圣器培养
		public static const RELICS_TRANSFER:String = "3163";//伙伴圣器转移
		public static const RELICS_ADD_LATENT:String = "3164";//圣器加点
		public static const HERO_UPDATE:String = "3165";//更新伙伴信息
		public static const GS_HeroUpdate:String = "3165";
		public static const GS_RelicsInlay:String = "3166";
		
		public static const MSGID_PHOTO_APPRAISAL_ENABLE:String = "2500";//激活图鉴
		public static const MSGID_PHOTO_APPRAISAL_BREAK:String = "2501";//分解图鉴
		public static const MSGID_PHOTO_APPRAISAL_RWD:String = "2502";//领取奖励
		
		
		//伙伴天赋
		public static const GS_HeroTalentSkill:String = "3167";
		public static const GS_HeroTalentUpdate:String = "3168";
		
		//暗影神殿
		public static const GET_TEMPLE_INFO:String = "3504";//获取暗影神殿的属性信息
		public static const TEMPLE_COLLECT:String = "3505";//收集灵魂碎片
		
		// 阵型
		public static const FORMATION_INFO:String = "3201";
		public static const FORMATION_UPDATE:String = "3202";
		public static const FORMATION_UPGRADE:String = "3203";
		public static const GS_FormationActivateChain:String = "3210";
		
		// 伙伴训练
		public static const HERO_TRAIN_INFO:String = "3153";
		public static const HERO_TRAIN:String = "3154";
		public static const HERO_TRAIN_CD:String = "3155";
		
		// 酒馆
		public static const HERO_BAR_INFO:String = "3156";
		public static const HERO_INTO_TEAM:String = "3157";
		public static const HERO_LEAVE_TEAM:String = "3158";
		public static const HERO_ADD_LOVE:String = "3159";
		public static const HERO_INVITE:String = "3160";
		
		// 技能面板
		public static const GET_SKILL_LIST:String = "3204";
		public static const UPGRADE_SKILL:String = "3205";
		public static const CLEAR_SKILL:String = "3206";
		public static const CLEAR_VOLITION_SKILL:String = "3208";
		public static const SET_SKILL_BAR:String = "3207";
		public static const GS_SetBurstBar:String = "3209";
		
		// 聊天
		public static const CHAT:String = "3351";
		public static const CHAT_PUSH:String = "3353";
		public static const CHAT_HISTORY:String = "3352";
		
		
		// 关卡
		public static const GET_HURDLE_LIST:String = "3276";
		public static const HURDLE_NEW:String = "3277";
		public static const INTO_HURDLE:String = "3278";
		public static const GS_HurdleUpdate:String = "3279";
		public static const HURDLE_ACTION:String = "3280";
		
		
		// 好友
		public static const GET_RELATION_LIST:String = "3355";
		public static const GET_RELATION_INFO:String = "3356";
		public static const ADD_RELATION:String = "3357";
		public static const REMOVE_RELATION:String = "3358";
		public static const GS_RELATIONBROADCAST:String = "3359";
		public static const GS_RELATIONUPDATE:String="3360"
		
		
		// 家族
		public static const CREATE_FAMILY:String = "3301";
		public static const DELETE_FAMILY:String = "3302";
		public static const GET_FAMILY_LIST:String = "3303";
		public static const FAMILY_APPLY_RESULT:String = "3304";
		public static const OPERATE_FAMILY_MEMBER_APPLY:String = "3305";
		public static const GET_MEMBER_APPLY_LIST:String = "3306";
		public static const GET_FAMILY_LOG_APPLY_LIST:String = "3315";
		public static const SET_FAMILY_MEMBER_SET:String = "3307";
		public static const SET_FAMILY_KICK_OUT:String = "3308";
		public static const SET_FAMILY_NOTICE:String = "3310";
		public static const SET_FAMILY_AUTO_APPROVE:String = "3311";
		public static const GET_MY_FAMILY_INFO:String = "3312";
		public static const APPLY_FAMILY:String = "3313";
		public static const EXIT_FAMILY:String = "3314";
		public static const NOTIFY_FAMILY_KICKOUT:String = "3309";
		public static const GS_Get_Curr_Family_Boss:String = "4801";
		
		
		// 家族任务
		public static const FAMILY_GET_TASK:String = "3316";
		public static const FAMILY_GET_TASK_PROCESS:String = "3317";
		public static const FAMILY_ADD_TASK_POINT:String = "3318";
		public static const FAMILY_REFRESH_TASK_PROCESS:String = "3319";
		public static const FAMILY_TASK_PROCESS_ACTION:String = "3320";
		
		
		// 强化
		public static const STRENGTHEN:String = "3120";
		public static const EQUIP_LEVEL_UP:String = "3118";
		public static const WASH_ACTION:String = "3121";
		public static const WASH_BATCH_SELECT:String = "3122";
		public static const GS_WashDecomposeInfo:String = "3123";
		public static const GS_WashDecompose:String = "3124";
		public static const GEM_ACTION:String = "4250";
		public static const GEM_BOOK_UPDATE:String = "4251";
		
		// 巫师战旗
//		public static const GS_GETBOSSLIST:String="GS_GetBossList";
		public static const GS_GetChessList:String="3401";
		public static const GS_BossResult:String="3404";
		public static const GS_BossSecKill:String="3403";
		public static const GS_ReceiveRewards:String="3406";
		public static const GS_BossRefresh:String="3402";
		public static const GS_ReadChapter:String="3405";
		public static const GS_RcvFirstKill:String="GS_RcvFirstKill";
		
		//邮件
		public static const GS_MailList:String="3361";
		public static const GS_MailRead:String="3363";
		public static const GS_MailDraw:String="3364";
		public static const GS_MailDelete:String="3362";
		public static const GS_MailNew:String="3365";
		
		
		// 佣兵任务
		public static const GS_MERCENARY_TASK_LIST:String = "3452";
		public static const GS_MERCENARY_AUTO_FINISH:String = "3453";
		public static const GS_MERCENARY_ANSWER:String = "3454";
		
		
		// 查看其他玩家信息
		public static const GS_GET_ANOTHER_INFO:String = "3009";
		public static const GS_GET_ANOTHER_BRIEF:String = "3010";
		

		//熔炼
		public static const GS_SmeltPrice:String="3455";
		public static const GS_Smelt:String="3456";
		public static const GS_SmeltInfo:String="3457";
		
		//阵营
		public static const GS_CampAutoResult:String="3011";
		public static const GS_CampRandom:String="3012";
		
		//防沉迷
		public static const GS_FcmCommit:String="3014";
		
		//神兵
		public static const GS_GetSweapons:String="3506";
		public static const GS_SweaponActive:String = "3508";
		public static const GS_SweaponTrain:String = "3509";
		public static const GS_SweaponFollow:String = "3510";
		public static const GS_JudgeSkillLevelUp:String = "3511";
		public static const GS_CanActiveSweapon:String = "3507";
		
		//引导
		public static const GS_GetUserGuids:String = "3556";
		public static const GS_GuidComplete:String = "3557";
		public static const GS_AdvancedEquip:String = "GS_AdvancedEquip";
		public static const GS_OneKeyEquip:String = "GS_OneKeyEquip";
		
		//恶魔城
		public static const GS_CastleInfo:String = "4351";
		public static const GS_CastleRank:String = "4352";
		public static const GS_CastleRwdList:String = "4353";
		public static const GS_CastleWipe:String = "4354";
		public static const GS_CastleWipeRcv:String = "4355";
		public static const GS_CastleFirstRcv:String = "4359";
		public static const GS_GetCastleVania:String = "4356";
		public static const GS_CastleVaniaRewardList:String = "4357";
		public static const GS_ReceiveCastleVaniaReward:String = "4358";
		
		//妹子
		public static const GS_SISTER_SYSTEM:String = "3551";		//妹子系统信息
		public static const GS_SISTER_INFO:String = "3552";		//请求妹子信息
		public static const GS_SHOW_LOVE:String = "3553";		//示爱
		public static const GS_GET_SISTER_REWARD:String = "3554";		//领取妹子奖励
		
		//黎明之战
		public static const GS_GetDawnState:String = "3601";
		public static const GS_GetGod:String = "3602";
		public static const GS_DawnSweep:String = "3605";
		
		//地牢猎手
		public static const GS_Dungeon_Entry:String = "3651";
		public static const GS_Dungeon_Exit:String = "3652";
		public static const GS_Dungeon_EntryEnd:String = "3653";
		public static const GS_Dungeon_UserDead:String = "3654";
		public static const GS_Dungeon_Stat:String = "3655";
		public static const GS_Dungeon_GameOver:String = "3656";
		public static const GS_Dungeon_HideName:String = "3657";
		
		public static const GS_GetRankInfo:String = "3555";
		
		//红龙宝藏
		public static const GS_RedDragon_TeamList:String = "3701";
		public static const GS_RedDragon_MatchSuccess:String = "3702";
		public static const GS_RedDragon_MatchBegin:String = "3703";
		public static const GS_RedDragon_MatchAction:String = "3704";
		public static const GS_RedDragon_GetRewardContent:String = "3705";
		public static const GS_RedDragon_FetchReward:String = "3706";
		public static const GS_RedDragon_RewardTimes:String = "3707";
		public static const GS_RedDragon_Rank:String = "3708";
		
		//队伍创建
		public static const GS_TeamJoin:String = "3751";
		public static const GS_TeamAction_Push:String = "3752";
		public static const GS_TeamAction:String = "3753";
		public static const GS_TeamInvite:String = "3754";
		public static const GS_TeamInvite_Push:String = "3755";
		public static const GS_TeamWorldInvite:String = "3756";
		public static const GS_TeamFormation:String = "3757";
		public static const GS_TeamFormationMove:String = "3758";
		public static const GS_TeamCreate:String = "3759";
		public static const GS_TeamDismiss_Push:String = "3760";
		
		//开服活动
		public static const GS_Act_Info:String = "3801";
		public static const GS_Rev_Act_Reward:String = "3804";
		public static const GS_ACTICOM_SHOW:String = "3802";
		public static const GS_OPEN_ZONE:String = "3803";
		
		//每日活动
		public static const GS_DailyAct:String = "3805";
		
		//客服
		public static const GS_Advice:String = "3604";
		
		// 通知对应功能点数
		public static const GS_NOTI_FUNC_NUM:String = "3851";
		public static const GS_NOTI_FUNC_TIME:String = "3853";
		public static const GS_ActNotify:String = "3854";
		public static const GS_ActCharge:String = "3855";
		public static const GS_WantStrengthen:String = "3857";
		
		// 成长线（坐骑、翅膀、神兵）
		public static const GS_GET_GROWUP_INFO:String = "3901";
		public static const GS_GROWUP_LEVEL_UP:String = "3902";
		public static const GS_GROWUP_SHOW:String = "3903";
		// 特殊（坐骑、翅膀、神兵）
		public static const GS_SpecialGrowupInfo:String = "3904";
		public static const GS_SpecialGrowupActive:String = "3905";
		public static const GS_SpecialGrowupShow:String = "3906";
		
		// 梦魇
		public static const GS_GetIncubusInfo:String = "3951";
		public static const GS_IntoIncubus:String = "3952";
		public static const GS_QuitIncubus:String = "3953";
		public static const GS_StartWipeIncubus:String = "3954";
		public static const GS_CancelWipeIncubus:String = "3955";
		public static const GS_GetWipeIncubusInfo:String = "3956";
		public static const GS_DiamondIncubus:String = "3957";
		public static const GS_GetWipeReward:String = "3958";
		public static const GS_GetThreeStarBox:String = "3959";
		public static const GS_BuyStam:String = "3017";
		public static const GS_BuyStamNum:String = "3018";
		
		//福利
		public static const GS_GetWelfareInfo:String = "4001";
		public static const GS_GetWelfareReward:String = "4002";
		public static const GS_ActivateCode:String = "4010";
		public static const GS_WeiXin:String = "4011";
		public static const GS_PhoneVerify:String = "4012";
		public static const GS_ChangeLog:String = "4020";

		//竞技场
		public static const GS_ArenaFightList:String = "4101";
		public static const GS_ArenaRankList:String = "4102";
		public static const GS_ArenaAddTimes:String = "4103";
		public static const GS_ArenaCD:String = "4104";
		public static const GS_ArenaReport:String = "4105";
		public static const GS_ArenaGetReward:String = "4106";
		public static const GS_ArenaReportsShow:String = "4107";
		
		//称号
		public static const GS_GetTitleList:String = "4051";
		public static const GS_ChangeTitle:String = "4052";
		
		
		// 打坐
		public static const GS_Zazen:String = "4151";
		public static const GS_ZazenUpdate:String = "4152";
		public static const GS_ZazenRwd:String = "4153";
		
		// 保卫长城
		public static const GS_WallInfo:String = "4200";
		public static const GS_WallRank:String = "4201";
		public static const GS_WallReward:String = "4202";
		
		//哥布林宝藏
		public static const GS_PreciousOpen:String = "4301";
		public static const GS_PreciousRequest:String = "4302";
		
		//多人副本
		public static const GS_FubenTeamList:String = "4401";
		public static const GS_FubenBegin:String = "4402";
		public static const GS_FubenInfo:String = "4403";
		public static const GS_FubenRewardContent:String = "4404";
		public static const GS_FubenRewardFetch:String = "4405";
		public static const GS_FubenList:String = "4406";
		
		//提示弹窗
		public static const GS_POPUP_LIST:String = "3116";
		public static const GS_POPUP_ACTION:String = "3117";
		
		//七日登陆
		public static const GS_7DayLogin:String = "4511";
		public static const GS_7DayLoginRcv:String = "4512";
		
		//守护天使
		public static const GS_AngelInfo:String = "4451";
		public static const GS_AngelSkill:String = "4452";
		public static const GS_AngelStar:String = "4453";
		public static const GS_AngelFollow:String = "4454";
		public static const GS_AngelSkillOrder:String = "4455";
		public static const GS_AngelActive:String = "4456";
		public static const GS_AngelInMap:String = "4457";
		public static const GS_AngelNew:String = "4458";
		public static const GS_AngelRename:String = "4459";
		
		// 签到
		public static const GS_GetSignInfo:String = "3806";
		public static const GS_DoSignIn:String = "3807";
		public static const GS_ReSignIn:String = "3808";
		
		// vip
		public static const GS_VipInfo:String = "4551";
		public static const GS_VipReward:String = "4552";
		
		// 世界boss
		public static const GS_WBossView:String = "4651";
		public static const GS_WBossInfo:String = "4652";
		public static const GS_WBossReborn:String = "4653";
		
		// 家族战
		public static const GS_FamilyWarRank:String = "4601";
		public static const GS_FamilyWarIO:String = "4602";
		public static const GS_FamilyWar1Result:String = "4603";
		public static const GS_FamilyWarReport:String = "4604";
		public static const GS_FamiyWar1List:String = "4605";
		public static const GS_FamilyWar1Attack:String = "4606";
		public static const GS_FamilyWarBuffActive:String = "4607";
		public static const GS_FamilyWarBuff:String = "4608";
		public static const GS_FamilyWarTower:String = "4609";
		public static const GS_FamilyWarRebirth:String = "4610";
		public static const GS_FamilyWarSmallRank:String = "4611";
		public static const GS_FamilyWarGameOver:String = "4612";
		public static const GS_Global:String = "4613";
		public static const GS_FamilyWarRebirthNum:String = "4614";
		
		// 活动状态通知
		public static const GS_Schedule:String = "3019";
	
		
		// 钓鱼
		public static const GS_FishInfo:String = "4701";
		public static const GS_FishAction:String = "4702";
		
		
		// 运镖
		public static const GS_SailList:String = "4751";
		public static const GS_SailRand:String = "4752";
		public static const GS_SailUpdate:String = "4753";
		public static const GS_DoSail:String = "4754";
		public static const GS_SailRwd:String = "4755";
		public static const GS_SailBoat:String = "4756";
		public static const GS_SailNotify:String = "4757";
		
		//欢乐送钻石
		public static const GS_Earn_Diamond:String = "4851";
		
		
		// 阵营战
		public static const GS_CampWarIO:String = "4951";
		public static const GS_CampWarFightList:String = "4952";
		public static const GS_CampWarReport:String = "4953";
		public static const GS_CampWarRank:String = "4954";
		
		//月卡
		public static const GS_MonthCardInfo:String = "5001";
		public static const GS_MonthCardBuy:String = "5002";
		public static const GS_MonthCardRcvRwd:String = "5003";
		
		//领取翅膀		
		public static const GS_WINGGET:String = "5051";

		//英雄试练		
		public static const GS_PlayerTrialInfo:String = "5101";
		
		//炼金
		public static const GS_DrugEat:String = "5151";
		public static const GS_DrugRoleInfo:String = "5152";

		//返回副本大厅，福利大厅对应的通知值		
		public static const GS_FunTabNumber:String = "3856";
		
		//精彩活动
		public static const GS_WonderfulActInfo:String = "5201";
		public static const GS_WonderfulActNotify:String = "5202";
		public static const GS_WonderfulActRcvRwd:String = "5203";
		
		//神铸
		public static const GS_GodCastInfo:String = "5301";
		public static const GS_GodCastOpen:String = "5302";
		public static const GS_GodCastLock:String = "5303";
		public static const GS_DoGodCast:String = "5304";
		public static const GS_GodCastRecycle:String = "5305";
		public static const GS_GodCastDress:String = "5306";

		// 赏金猎人
		public static const GS_HunterInfo:String = "5251";
		public static const GS_HunterFormation:String = "5252";
		public static const GS_HunterFormationMove:String = "5253";
		public static const GS_HunterReborn:String = "5254";
		
		//附魔
		public static const GS_GemEnchant:String = "5351";
		
		// 魔神英雄
		public static const GS_Mashin:String = "5401";
		public static const GS_MashinRank:String = "5402";
		public static const GS_MashinBuyTimes:String = "5403";
		
		//跨服相关
		//进入跨服场景
		public static const GS_CrossServer:String = "5451";
		
		//双蛋活动相关
		public static const GS_ChristmasInfo:String = "5604";
		public static const GS_ChristmasSway:String = "5605";
		public static const GS_ChristmasBagExtract:String = "5606";
		
		//勋章
		public static const GS_HeroMedalBonus:String = "3169";
		public static const GS_HeroMedalSell:String = "3170";
		public static const GS_HeroMedalCompose:String = "3171";
		public static const GS_HeroMedalLock:String = "3172";
		public static const GS_HeroMedalEquip:String = "3173";
		public static const GS_HeroMedalBagInfo:String = "3174";
		public static const GS_HeroMedalInfo:String = "3175";
		public static const GS_MedalBonusInfo:String = "3176";
		
		// 终结谷之战
		public static const GS_ValleyStep:String = "5651";
		public static const GS_ValleyCommonInfo:String = "5652";
		public static const GS_VallyCommonOpponent:String = "5653";
		public static const GS_VallyFinal:String = "5654";
		public static const GS_ValleyFinalCreateBattle:String = "5655";
		
		//许愿之树
		public static const GS_FamilyTreeInfo:String = "5701";
		public static const GS_FamilyTreeReqItem:String = "5702";
		public static const GS_FamilyTreeBlessList:String = "5703";
		public static const GS_FamilyTreeBlessOther:String = "5704";
		public static const GS_FamilyTreeVipComplete:String = "5705";
		public static const GS_FamilyTreeReward:String = "5706";
		public static const GS_FamilyTreeCall:String = "5707";
		public static const GS_FamilyTreeBeBlessedList:String = "5708";
		public static const GS_FamilyTreeShowIcon:String = "5709";
		
		//平台VIP
		public static const GS_PlatVip:String = "5751";
		
		//冰火投资
		public static const GS_InvestInfo:String = "5801";
		public static const GS_DoInvest:String = "5802";
		public static const GS_InvestRwd:String = "5803";
		public static const GS_OneKeyInvest:String = "5804";
		public static const GS_InvestTimesNotify:String = "5805";
		
		//团购活动
		public static const GS_GroupChargeInfo:String = "5900";
		public static const GS_GroupBuyInfo:String = "5901";
		public static const GS_GroupChargeRcv:String = "5902";
		public static const GS_GroupBuyPurchase:String = "5903";
		public static const GS_GroupBuyRcv:String = "5904";
		
		//练功房
		public static const GS_ExpRoomInfo:String = "5951";
		public static const GS_ExpRoomCancel:String = "5952";
		public static const GS_ExpRoomStart:String = "5953";
		public static const GS_ExpRoomNotify:String = "5954";
		public static const GS_ExpRoomSyncExp:String = "5955";
		
	}
}