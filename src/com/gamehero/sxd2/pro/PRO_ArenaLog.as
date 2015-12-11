package com.gamehero.sxd2.pro {
	import com.netease.protobuf.*;
	use namespace com.netease.protobuf.used_by_generated_code;
	import com.netease.protobuf.fieldDescriptors.*;
	import flash.utils.Endian;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.errors.IOError;
	import com.gamehero.sxd2.pro.PRO_PlayerBase;
	// @@protoc_insertion_point(imports)

	// @@protoc_insertion_point(class_metadata)
	public final class PRO_ArenaLog extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const BASE:FieldDescriptor$TYPE_MESSAGE = new FieldDescriptor$TYPE_MESSAGE("com.gamehero.sxd2.pro.PRO_ArenaLog.base", "base", (1 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return com.gamehero.sxd2.pro.PRO_PlayerBase; });

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
		public static const TIME:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.PRO_ArenaLog.time", "time", (2 << 3) | com.netease.protobuf.WireType.VARINT);

		private var time$field:uint;

		private var hasField$0:uint = 0;

		public function clearTime():void {
			hasField$0 &= 0xfffffffe;
			time$field = new uint();
		}

		public function get hasTime():Boolean {
			return (hasField$0 & 0x1) != 0;
		}

		public function set time(value:uint):void {
			hasField$0 |= 0x1;
			time$field = value;
		}

		public function get time():uint {
			return time$field;
		}

		/**
		 *  @private
		 */
		public static const WIN:FieldDescriptor$TYPE_BOOL = new FieldDescriptor$TYPE_BOOL("com.gamehero.sxd2.pro.PRO_ArenaLog.win", "win", (3 << 3) | com.netease.protobuf.WireType.VARINT);

		private var win$field:Boolean;

		public function clearWin():void {
			hasField$0 &= 0xfffffffd;
			win$field = new Boolean();
		}

		public function get hasWin():Boolean {
			return (hasField$0 & 0x2) != 0;
		}

		public function set win(value:Boolean):void {
			hasField$0 |= 0x2;
			win$field = value;
		}

		public function get win():Boolean {
			return win$field;
		}

		/**
		 *  @private
		 */
		public static const BATTLE_REPORT_ID:FieldDescriptor$TYPE_UINT64 = new FieldDescriptor$TYPE_UINT64("com.gamehero.sxd2.pro.PRO_ArenaLog.battle_report_id", "battleReportId", (4 << 3) | com.netease.protobuf.WireType.VARINT);

		private var battle_report_id$field:UInt64;

		public function clearBattleReportId():void {
			battle_report_id$field = null;
		}

		public function get hasBattleReportId():Boolean {
			return battle_report_id$field != null;
		}

		public function set battleReportId(value:UInt64):void {
			battle_report_id$field = value;
		}

		public function get battleReportId():UInt64 {
			return battle_report_id$field;
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			if (hasBase) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 1);
				com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, base$field);
			}
			if (hasTime) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 2);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, time$field);
			}
			if (hasWin) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 3);
				com.netease.protobuf.WriteUtils.write$TYPE_BOOL(output, win$field);
			}
			if (hasBattleReportId) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 4);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT64(output, battle_report_id$field);
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
			var time$count:uint = 0;
			var win$count:uint = 0;
			var battle_report_id$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					if (base$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_ArenaLog.base cannot be set twice.');
					}
					++base$count;
					this.base = new com.gamehero.sxd2.pro.PRO_PlayerBase();
					com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, this.base);
					break;
				case 2:
					if (time$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_ArenaLog.time cannot be set twice.');
					}
					++time$count;
					this.time = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 3:
					if (win$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_ArenaLog.win cannot be set twice.');
					}
					++win$count;
					this.win = com.netease.protobuf.ReadUtils.read$TYPE_BOOL(input);
					break;
				case 4:
					if (battle_report_id$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_ArenaLog.battleReportId cannot be set twice.');
					}
					++battle_report_id$count;
					this.battleReportId = com.netease.protobuf.ReadUtils.read$TYPE_UINT64(input);
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
