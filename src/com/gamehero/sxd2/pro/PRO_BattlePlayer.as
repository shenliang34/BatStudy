package com.gamehero.sxd2.pro {
	import com.netease.protobuf.*;
	use namespace com.netease.protobuf.used_by_generated_code;
	import com.netease.protobuf.fieldDescriptors.*;
	import flash.utils.Endian;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.errors.IOError;
	import com.gamehero.sxd2.pro.PRO_BattleActionInfo;
	import com.gamehero.sxd2.pro.PRO_BattleBuff;
	import com.gamehero.sxd2.pro.PRO_PlayerBase;
	import com.gamehero.sxd2.pro.PRO_BattlePlayerType;
	import com.gamehero.sxd2.pro.PRO_BattleJointAtk;
	// @@protoc_insertion_point(imports)

	// @@protoc_insertion_point(class_metadata)
	public final class PRO_BattlePlayer extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const BASE:FieldDescriptor$TYPE_MESSAGE = new FieldDescriptor$TYPE_MESSAGE("com.gamehero.sxd2.pro.PRO_BattlePlayer.base", "base", (1 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return com.gamehero.sxd2.pro.PRO_PlayerBase; });

		private var base$field:com.gamehero.sxd2.pro.PRO_PlayerBase;

		public function clearBase():void {
			base$field = null;
		}

		public function get hasBase():Boolean {
			return base$field != null;
		}

		public function set base(value:com.gamehero.sxd2.pro.PRO_PlayerBase):void {
			base$field = value;
		}

		public function get base():com.gamehero.sxd2.pro.PRO_PlayerBase {
			return base$field;
		}

		/**
		 *  @private
		 */
		public static const ANGER:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.gamehero.sxd2.pro.PRO_BattlePlayer.anger", "anger", (2 << 3) | com.netease.protobuf.WireType.VARINT);

		private var anger$field:int;

		private var hasField$0:uint = 0;

		public function clearAnger():void {
			hasField$0 &= 0xfffffffe;
			anger$field = new int();
		}

		public function get hasAnger():Boolean {
			return (hasField$0 & 0x1) != 0;
		}

		public function set anger(value:int):void {
			hasField$0 |= 0x1;
			anger$field = value;
		}

		public function get anger():int {
			return anger$field;
		}

		/**
		 *  @private
		 */
		public static const MAXANGER:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.gamehero.sxd2.pro.PRO_BattlePlayer.maxAnger", "maxAnger", (3 << 3) | com.netease.protobuf.WireType.VARINT);

		private var maxAnger$field:int;

		public function clearMaxAnger():void {
			hasField$0 &= 0xfffffffd;
			maxAnger$field = new int();
		}

		public function get hasMaxAnger():Boolean {
			return (hasField$0 & 0x2) != 0;
		}

		public function set maxAnger(value:int):void {
			hasField$0 |= 0x2;
			maxAnger$field = value;
		}

		public function get maxAnger():int {
			return maxAnger$field;
		}

		/**
		 *  @private
		 */
		public static const CAMP:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.gamehero.sxd2.pro.PRO_BattlePlayer.camp", "camp", (4 << 3) | com.netease.protobuf.WireType.VARINT);

		private var camp$field:int;

		public function clearCamp():void {
			hasField$0 &= 0xfffffffb;
			camp$field = new int();
		}

		public function get hasCamp():Boolean {
			return (hasField$0 & 0x4) != 0;
		}

		public function set camp(value:int):void {
			hasField$0 |= 0x4;
			camp$field = value;
		}

		public function get camp():int {
			return camp$field;
		}

		/**
		 *  @private
		 */
		public static const TEMPID:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.gamehero.sxd2.pro.PRO_BattlePlayer.tempID", "tempID", (5 << 3) | com.netease.protobuf.WireType.VARINT);

		private var tempID$field:int;

		public function clearTempID():void {
			hasField$0 &= 0xfffffff7;
			tempID$field = new int();
		}

		public function get hasTempID():Boolean {
			return (hasField$0 & 0x8) != 0;
		}

		public function set tempID(value:int):void {
			hasField$0 |= 0x8;
			tempID$field = value;
		}

		public function get tempID():int {
			return tempID$field;
		}

		/**
		 *  @private
		 */
		public static const POS:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.gamehero.sxd2.pro.PRO_BattlePlayer.pos", "pos", (6 << 3) | com.netease.protobuf.WireType.VARINT);

		private var pos$field:int;

		public function clearPos():void {
			hasField$0 &= 0xffffffef;
			pos$field = new int();
		}

		public function get hasPos():Boolean {
			return (hasField$0 & 0x10) != 0;
		}

		public function set pos(value:int):void {
			hasField$0 |= 0x10;
			pos$field = value;
		}

		public function get pos():int {
			return pos$field;
		}

		/**
		 *  @private
		 */
		public static const PLAYERTYPE:FieldDescriptor$TYPE_ENUM = new FieldDescriptor$TYPE_ENUM("com.gamehero.sxd2.pro.PRO_BattlePlayer.playerType", "playerType", (7 << 3) | com.netease.protobuf.WireType.VARINT, com.gamehero.sxd2.pro.PRO_BattlePlayerType);

		private var playerType$field:int;

		public function clearPlayerType():void {
			hasField$0 &= 0xffffffdf;
			playerType$field = new int();
		}

		public function get hasPlayerType():Boolean {
			return (hasField$0 & 0x20) != 0;
		}

		public function set playerType(value:int):void {
			hasField$0 |= 0x20;
			playerType$field = value;
		}

		public function get playerType():int {
			return playerType$field;
		}

		/**
		 *  @private
		 */
		public static const SKILLS:RepeatedFieldDescriptor$TYPE_UINT32 = new RepeatedFieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.PRO_BattlePlayer.skills", "skills", (8 << 3) | com.netease.protobuf.WireType.VARINT);

		[ArrayElementType("uint")]
		public var skills:Array = [];

		/**
		 *  @private
		 */
		public static const ROUND:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.gamehero.sxd2.pro.PRO_BattlePlayer.round", "round", (9 << 3) | com.netease.protobuf.WireType.VARINT);

		private var round$field:int;

		public function clearRound():void {
			hasField$0 &= 0xffffffbf;
			round$field = new int();
		}

		public function get hasRound():Boolean {
			return (hasField$0 & 0x40) != 0;
		}

		public function set round(value:int):void {
			hasField$0 |= 0x40;
			round$field = value;
		}

		public function get round():int {
			return round$field;
		}

		/**
		 *  @private
		 */
		public static const USESKILL:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.gamehero.sxd2.pro.PRO_BattlePlayer.useSkill", "useSkill", (10 << 3) | com.netease.protobuf.WireType.VARINT);

		private var useSkill$field:int;

		public function clearUseSkill():void {
			hasField$0 &= 0xffffff7f;
			useSkill$field = new int();
		}

		public function get hasUseSkill():Boolean {
			return (hasField$0 & 0x80) != 0;
		}

		public function set useSkill(value:int):void {
			hasField$0 |= 0x80;
			useSkill$field = value;
		}

		public function get useSkill():int {
			return useSkill$field;
		}

		/**
		 *  @private
		 */
		public static const ACTIONS:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("com.gamehero.sxd2.pro.PRO_BattlePlayer.actions", "actions", (11 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return com.gamehero.sxd2.pro.PRO_BattleActionInfo; });

		[ArrayElementType("com.gamehero.sxd2.pro.PRO_BattleActionInfo")]
		public var actions:Array = [];

		/**
		 *  @private
		 */
		public static const BUFFS:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("com.gamehero.sxd2.pro.PRO_BattlePlayer.buffs", "buffs", (12 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return com.gamehero.sxd2.pro.PRO_BattleBuff; });

		[ArrayElementType("com.gamehero.sxd2.pro.PRO_BattleBuff")]
		public var buffs:Array = [];

		/**
		 *  @private
		 */
		public static const DMGSBEFOREACTION:RepeatedFieldDescriptor$TYPE_INT32 = new RepeatedFieldDescriptor$TYPE_INT32("com.gamehero.sxd2.pro.PRO_BattlePlayer.dmgsBeforeAction", "dmgsBeforeAction", (13 << 3) | com.netease.protobuf.WireType.VARINT);

		[ArrayElementType("int")]
		public var dmgsBeforeAction:Array = [];

		/**
		 *  @private
		 */
		public static const JOINTATK:FieldDescriptor$TYPE_MESSAGE = new FieldDescriptor$TYPE_MESSAGE("com.gamehero.sxd2.pro.PRO_BattlePlayer.jointatk", "jointatk", (14 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return com.gamehero.sxd2.pro.PRO_BattleJointAtk; });

		private var jointatk$field:com.gamehero.sxd2.pro.PRO_BattleJointAtk;

		public function clearJointatk():void {
			jointatk$field = null;
		}

		public function get hasJointatk():Boolean {
			return jointatk$field != null;
		}

		public function set jointatk(value:com.gamehero.sxd2.pro.PRO_BattleJointAtk):void {
			jointatk$field = value;
		}

		public function get jointatk():com.gamehero.sxd2.pro.PRO_BattleJointAtk {
			return jointatk$field;
		}

		/**
		 *  @private
		 */
		public static const TEAM_SPEED:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.gamehero.sxd2.pro.PRO_BattlePlayer.team_speed", "teamSpeed", (15 << 3) | com.netease.protobuf.WireType.VARINT);

		private var team_speed$field:int;

		public function clearTeamSpeed():void {
			hasField$0 &= 0xfffffeff;
			team_speed$field = new int();
		}

		public function get hasTeamSpeed():Boolean {
			return (hasField$0 & 0x100) != 0;
		}

		public function set teamSpeed(value:int):void {
			hasField$0 |= 0x100;
			team_speed$field = value;
		}

		public function get teamSpeed():int {
			return team_speed$field;
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			if (hasBase) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 1);
				com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, base$field);
			}
			if (hasAnger) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 2);
				com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, anger$field);
			}
			if (hasMaxAnger) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 3);
				com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, maxAnger$field);
			}
			if (hasCamp) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 4);
				com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, camp$field);
			}
			if (hasTempID) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 5);
				com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, tempID$field);
			}
			if (hasPos) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 6);
				com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, pos$field);
			}
			if (hasPlayerType) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 7);
				com.netease.protobuf.WriteUtils.write$TYPE_ENUM(output, playerType$field);
			}
			for (var skills$index:uint = 0; skills$index < this.skills.length; ++skills$index) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 8);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, this.skills[skills$index]);
			}
			if (hasRound) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 9);
				com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, round$field);
			}
			if (hasUseSkill) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 10);
				com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, useSkill$field);
			}
			for (var actions$index:uint = 0; actions$index < this.actions.length; ++actions$index) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 11);
				com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, this.actions[actions$index]);
			}
			for (var buffs$index:uint = 0; buffs$index < this.buffs.length; ++buffs$index) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 12);
				com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, this.buffs[buffs$index]);
			}
			for (var dmgsBeforeAction$index:uint = 0; dmgsBeforeAction$index < this.dmgsBeforeAction.length; ++dmgsBeforeAction$index) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 13);
				com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, this.dmgsBeforeAction[dmgsBeforeAction$index]);
			}
			if (hasJointatk) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 14);
				com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, jointatk$field);
			}
			if (hasTeamSpeed) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 15);
				com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, team_speed$field);
			}
			for (var fieldKey:* in this) {
				super.writeUnknown(output, fieldKey);
			}
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function readFromSlice(input:flash.utils.IDataInput, bytesAfterSlice:uint):void {
			var base$count:uint = 0;
			var anger$count:uint = 0;
			var maxAnger$count:uint = 0;
			var camp$count:uint = 0;
			var tempID$count:uint = 0;
			var pos$count:uint = 0;
			var playerType$count:uint = 0;
			var round$count:uint = 0;
			var useSkill$count:uint = 0;
			var jointatk$count:uint = 0;
			var team_speed$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					if (base$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_BattlePlayer.base cannot be set twice.');
					}
					++base$count;
					this.base = new com.gamehero.sxd2.pro.PRO_PlayerBase();
					com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, this.base);
					break;
				case 2:
					if (anger$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_BattlePlayer.anger cannot be set twice.');
					}
					++anger$count;
					this.anger = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 3:
					if (maxAnger$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_BattlePlayer.maxAnger cannot be set twice.');
					}
					++maxAnger$count;
					this.maxAnger = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 4:
					if (camp$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_BattlePlayer.camp cannot be set twice.');
					}
					++camp$count;
					this.camp = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 5:
					if (tempID$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_BattlePlayer.tempID cannot be set twice.');
					}
					++tempID$count;
					this.tempID = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 6:
					if (pos$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_BattlePlayer.pos cannot be set twice.');
					}
					++pos$count;
					this.pos = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 7:
					if (playerType$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_BattlePlayer.playerType cannot be set twice.');
					}
					++playerType$count;
					this.playerType = com.netease.protobuf.ReadUtils.read$TYPE_ENUM(input);
					break;
				case 8:
					if ((tag & 7) == com.netease.protobuf.WireType.LENGTH_DELIMITED) {
						com.netease.protobuf.ReadUtils.readPackedRepeated(input, com.netease.protobuf.ReadUtils.read$TYPE_UINT32, this.skills);
						break;
					}
					this.skills.push(com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input));
					break;
				case 9:
					if (round$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_BattlePlayer.round cannot be set twice.');
					}
					++round$count;
					this.round = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 10:
					if (useSkill$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_BattlePlayer.useSkill cannot be set twice.');
					}
					++useSkill$count;
					this.useSkill = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 11:
					this.actions.push(com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, new com.gamehero.sxd2.pro.PRO_BattleActionInfo()));
					break;
				case 12:
					this.buffs.push(com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, new com.gamehero.sxd2.pro.PRO_BattleBuff()));
					break;
				case 13:
					if ((tag & 7) == com.netease.protobuf.WireType.LENGTH_DELIMITED) {
						com.netease.protobuf.ReadUtils.readPackedRepeated(input, com.netease.protobuf.ReadUtils.read$TYPE_INT32, this.dmgsBeforeAction);
						break;
					}
					this.dmgsBeforeAction.push(com.netease.protobuf.ReadUtils.read$TYPE_INT32(input));
					break;
				case 14:
					if (jointatk$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_BattlePlayer.jointatk cannot be set twice.');
					}
					++jointatk$count;
					this.jointatk = new com.gamehero.sxd2.pro.PRO_BattleJointAtk();
					com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, this.jointatk);
					break;
				case 15:
					if (team_speed$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_BattlePlayer.teamSpeed cannot be set twice.');
					}
					++team_speed$count;
					this.teamSpeed = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
