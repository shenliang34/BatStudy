package com.gamehero.sxd2.pro {
	import com.netease.protobuf.*;
	use namespace com.netease.protobuf.used_by_generated_code;
	import com.netease.protobuf.fieldDescriptors.*;
	import flash.utils.Endian;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.errors.IOError;
	import com.gamehero.sxd2.pro.PRO_BattleRoundInfo;
	import com.gamehero.sxd2.pro.PRO_BattleResult;
	// @@protoc_insertion_point(imports)

	// @@protoc_insertion_point(class_metadata)
	public final class PRO_BattleDetail extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const BATTLE_ID:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.PRO_BattleDetail.battle_id", "battleId", (1 << 3) | com.netease.protobuf.WireType.VARINT);

		private var battle_id$field:uint;

		private var hasField$0:uint = 0;

		public function clearBattleId():void {
			hasField$0 &= 0xfffffffe;
			battle_id$field = new uint();
		}

		public function get hasBattleId():Boolean {
			return (hasField$0 & 0x1) != 0;
		}

		public function set battleId(value:uint):void {
			hasField$0 |= 0x1;
			battle_id$field = value;
		}

		public function get battleId():uint {
			return battle_id$field;
		}

		/**
		 *  @private
		 */
		public static const REPORT_ID:FieldDescriptor$TYPE_UINT64 = new FieldDescriptor$TYPE_UINT64("com.gamehero.sxd2.pro.PRO_BattleDetail.report_id", "reportId", (2 << 3) | com.netease.protobuf.WireType.VARINT);

		private var report_id$field:UInt64;

		public function clearReportId():void {
			report_id$field = null;
		}

		public function get hasReportId():Boolean {
			return report_id$field != null;
		}

		public function set reportId(value:UInt64):void {
			report_id$field = value;
		}

		public function get reportId():UInt64 {
			return report_id$field;
		}

		/**
		 *  @private
		 */
		public static const SELFCAMP:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.PRO_BattleDetail.selfCamp", "selfCamp", (3 << 3) | com.netease.protobuf.WireType.VARINT);

		private var selfCamp$field:uint;

		public function clearSelfCamp():void {
			hasField$0 &= 0xfffffffd;
			selfCamp$field = new uint();
		}

		public function get hasSelfCamp():Boolean {
			return (hasField$0 & 0x2) != 0;
		}

		public function set selfCamp(value:uint):void {
			hasField$0 |= 0x2;
			selfCamp$field = value;
		}

		public function get selfCamp():uint {
			return selfCamp$field;
		}

		/**
		 *  @private
		 */
		public static const ROUNDINFOS:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("com.gamehero.sxd2.pro.PRO_BattleDetail.roundInfos", "roundInfos", (4 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return com.gamehero.sxd2.pro.PRO_BattleRoundInfo; });

		[ArrayElementType("com.gamehero.sxd2.pro.PRO_BattleRoundInfo")]
		public var roundInfos:Array = [];

		/**
		 *  @private
		 */
		public static const BOSHU:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.PRO_BattleDetail.boshu", "boshu", (5 << 3) | com.netease.protobuf.WireType.VARINT);

		private var boshu$field:uint;

		public function clearBoshu():void {
			hasField$0 &= 0xfffffffb;
			boshu$field = new uint();
		}

		public function get hasBoshu():Boolean {
			return (hasField$0 & 0x4) != 0;
		}

		public function set boshu(value:uint):void {
			hasField$0 |= 0x4;
			boshu$field = value;
		}

		public function get boshu():uint {
			return boshu$field;
		}

		/**
		 *  @private
		 */
		public static const RESULT:FieldDescriptor$TYPE_MESSAGE = new FieldDescriptor$TYPE_MESSAGE("com.gamehero.sxd2.pro.PRO_BattleDetail.result", "result", (6 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return com.gamehero.sxd2.pro.PRO_BattleResult; });

		private var result$field:com.gamehero.sxd2.pro.PRO_BattleResult;

		public function clearResult():void {
			result$field = null;
		}

		public function get hasResult():Boolean {
			return result$field != null;
		}

		public function set result(value:com.gamehero.sxd2.pro.PRO_BattleResult):void {
			result$field = value;
		}

		public function get result():com.gamehero.sxd2.pro.PRO_BattleResult {
			return result$field;
		}

		/**
		 *  @private
		 */
		public static const IS_FIRST_BATTLE:FieldDescriptor$TYPE_BOOL = new FieldDescriptor$TYPE_BOOL("com.gamehero.sxd2.pro.PRO_BattleDetail.is_first_battle", "isFirstBattle", (7 << 3) | com.netease.protobuf.WireType.VARINT);

		private var is_first_battle$field:Boolean;

		public function clearIsFirstBattle():void {
			hasField$0 &= 0xfffffff7;
			is_first_battle$field = new Boolean();
		}

		public function get hasIsFirstBattle():Boolean {
			return (hasField$0 & 0x8) != 0;
		}

		public function set isFirstBattle(value:Boolean):void {
			hasField$0 |= 0x8;
			is_first_battle$field = value;
		}

		public function get isFirstBattle():Boolean {
			return is_first_battle$field;
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			if (hasBattleId) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 1);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, battle_id$field);
			}
			if (hasReportId) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 2);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT64(output, report_id$field);
			}
			if (hasSelfCamp) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 3);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, selfCamp$field);
			}
			for (var roundInfos$index:uint = 0; roundInfos$index < this.roundInfos.length; ++roundInfos$index) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 4);
				com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, this.roundInfos[roundInfos$index]);
			}
			if (hasBoshu) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 5);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, boshu$field);
			}
			if (hasResult) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 6);
				com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, result$field);
			}
			if (hasIsFirstBattle) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 7);
				com.netease.protobuf.WriteUtils.write$TYPE_BOOL(output, is_first_battle$field);
			}
			for (var fieldKey:* in this) {
				super.writeUnknown(output, fieldKey);
			}
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function readFromSlice(input:flash.utils.IDataInput, bytesAfterSlice:uint):void {
			var battle_id$count:uint = 0;
			var report_id$count:uint = 0;
			var selfCamp$count:uint = 0;
			var boshu$count:uint = 0;
			var result$count:uint = 0;
			var is_first_battle$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					if (battle_id$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_BattleDetail.battleId cannot be set twice.');
					}
					++battle_id$count;
					this.battleId = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 2:
					if (report_id$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_BattleDetail.reportId cannot be set twice.');
					}
					++report_id$count;
					this.reportId = com.netease.protobuf.ReadUtils.read$TYPE_UINT64(input);
					break;
				case 3:
					if (selfCamp$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_BattleDetail.selfCamp cannot be set twice.');
					}
					++selfCamp$count;
					this.selfCamp = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 4:
					this.roundInfos.push(com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, new com.gamehero.sxd2.pro.PRO_BattleRoundInfo()));
					break;
				case 5:
					if (boshu$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_BattleDetail.boshu cannot be set twice.');
					}
					++boshu$count;
					this.boshu = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 6:
					if (result$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_BattleDetail.result cannot be set twice.');
					}
					++result$count;
					this.result = new com.gamehero.sxd2.pro.PRO_BattleResult();
					com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, this.result);
					break;
				case 7:
					if (is_first_battle$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_BattleDetail.isFirstBattle cannot be set twice.');
					}
					++is_first_battle$count;
					this.isFirstBattle = com.netease.protobuf.ReadUtils.read$TYPE_BOOL(input);
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
