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
	import com.gamehero.sxd2.pro.PRO_ArenaLog;
	// @@protoc_insertion_point(imports)

	// @@protoc_insertion_point(class_metadata)
	public final class MSG_UPDATE_ARENA_ACK extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const NEXT_REFRESH_TIME:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.MSG_UPDATE_ARENA_ACK.next_refresh_time", "nextRefreshTime", (1 << 3) | com.netease.protobuf.WireType.VARINT);

		private var next_refresh_time$field:uint;

		private var hasField$0:uint = 0;

		public function clearNextRefreshTime():void {
			hasField$0 &= 0xfffffffe;
			next_refresh_time$field = new uint();
		}

		public function get hasNextRefreshTime():Boolean {
			return (hasField$0 & 0x1) != 0;
		}

		public function set nextRefreshTime(value:uint):void {
			hasField$0 |= 0x1;
			next_refresh_time$field = value;
		}

		public function get nextRefreshTime():uint {
			return next_refresh_time$field;
		}

		/**
		 *  @private
		 */
		public static const FREE_NUM:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.MSG_UPDATE_ARENA_ACK.free_num", "freeNum", (2 << 3) | com.netease.protobuf.WireType.VARINT);

		private var free_num$field:uint;

		public function clearFreeNum():void {
			hasField$0 &= 0xfffffffd;
			free_num$field = new uint();
		}

		public function get hasFreeNum():Boolean {
			return (hasField$0 & 0x2) != 0;
		}

		public function set freeNum(value:uint):void {
			hasField$0 |= 0x2;
			free_num$field = value;
		}

		public function get freeNum():uint {
			return free_num$field;
		}

		/**
		 *  @private
		 */
		public static const TOTAL_WIN_NUM:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.MSG_UPDATE_ARENA_ACK.total_win_num", "totalWinNum", (3 << 3) | com.netease.protobuf.WireType.VARINT);

		private var total_win_num$field:uint;

		public function clearTotalWinNum():void {
			hasField$0 &= 0xfffffffb;
			total_win_num$field = new uint();
		}

		public function get hasTotalWinNum():Boolean {
			return (hasField$0 & 0x4) != 0;
		}

		public function set totalWinNum(value:uint):void {
			hasField$0 |= 0x4;
			total_win_num$field = value;
		}

		public function get totalWinNum():uint {
			return total_win_num$field;
		}

		/**
		 *  @private
		 */
		public static const STAR:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.MSG_UPDATE_ARENA_ACK.star", "star", (4 << 3) | com.netease.protobuf.WireType.VARINT);

		private var star$field:uint;

		public function clearStar():void {
			hasField$0 &= 0xfffffff7;
			star$field = new uint();
		}

		public function get hasStar():Boolean {
			return (hasField$0 & 0x8) != 0;
		}

		public function set star(value:uint):void {
			hasField$0 |= 0x8;
			star$field = value;
		}

		public function get star():uint {
			return star$field;
		}

		/**
		 *  @private
		 */
		public static const LEVEL:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.MSG_UPDATE_ARENA_ACK.level", "level", (5 << 3) | com.netease.protobuf.WireType.VARINT);

		private var level$field:uint;

		public function clearLevel():void {
			hasField$0 &= 0xffffffef;
			level$field = new uint();
		}

		public function get hasLevel():Boolean {
			return (hasField$0 & 0x10) != 0;
		}

		public function set level(value:uint):void {
			hasField$0 |= 0x10;
			level$field = value;
		}

		public function get level():uint {
			return level$field;
		}

		/**
		 *  @private
		 */
		public static const END_TIME:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.MSG_UPDATE_ARENA_ACK.end_time", "endTime", (6 << 3) | com.netease.protobuf.WireType.VARINT);

		private var end_time$field:uint;

		public function clearEndTime():void {
			hasField$0 &= 0xffffffdf;
			end_time$field = new uint();
		}

		public function get hasEndTime():Boolean {
			return (hasField$0 & 0x20) != 0;
		}

		public function set endTime(value:uint):void {
			hasField$0 |= 0x20;
			end_time$field = value;
		}

		public function get endTime():uint {
			return end_time$field;
		}

		/**
		 *  @private
		 */
		public static const ROUND:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.MSG_UPDATE_ARENA_ACK.round", "round", (7 << 3) | com.netease.protobuf.WireType.VARINT);

		private var round$field:uint;

		public function clearRound():void {
			hasField$0 &= 0xffffffbf;
			round$field = new uint();
		}

		public function get hasRound():Boolean {
			return (hasField$0 & 0x40) != 0;
		}

		public function set round(value:uint):void {
			hasField$0 |= 0x40;
			round$field = value;
		}

		public function get round():uint {
			return round$field;
		}

		/**
		 *  @private
		 */
		public static const TARGET:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("com.gamehero.sxd2.pro.MSG_UPDATE_ARENA_ACK.target", "target", (8 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return com.gamehero.sxd2.pro.PRO_PlayerBase; });

		[ArrayElementType("com.gamehero.sxd2.pro.PRO_PlayerBase")]
		public var target:Array = [];

		/**
		 *  @private
		 */
		public static const LOGS:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("com.gamehero.sxd2.pro.MSG_UPDATE_ARENA_ACK.logs", "logs", (9 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return com.gamehero.sxd2.pro.PRO_ArenaLog; });

		[ArrayElementType("com.gamehero.sxd2.pro.PRO_ArenaLog")]
		public var logs:Array = [];

		/**
		 *  @private
		 */
		public static const RANK:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.MSG_UPDATE_ARENA_ACK.rank", "rank", (10 << 3) | com.netease.protobuf.WireType.VARINT);

		private var rank$field:uint;

		public function clearRank():void {
			hasField$0 &= 0xffffff7f;
			rank$field = new uint();
		}

		public function get hasRank():Boolean {
			return (hasField$0 & 0x80) != 0;
		}

		public function set rank(value:uint):void {
			hasField$0 |= 0x80;
			rank$field = value;
		}

		public function get rank():uint {
			return rank$field;
		}

		/**
		 *  @private
		 */
		public static const TICKET_NUM:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.MSG_UPDATE_ARENA_ACK.ticket_num", "ticketNum", (11 << 3) | com.netease.protobuf.WireType.VARINT);

		private var ticket_num$field:uint;

		public function clearTicketNum():void {
			hasField$0 &= 0xfffffeff;
			ticket_num$field = new uint();
		}

		public function get hasTicketNum():Boolean {
			return (hasField$0 & 0x100) != 0;
		}

		public function set ticketNum(value:uint):void {
			hasField$0 |= 0x100;
			ticket_num$field = value;
		}

		public function get ticketNum():uint {
			return ticket_num$field;
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			if (hasNextRefreshTime) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 1);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, next_refresh_time$field);
			}
			if (hasFreeNum) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 2);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, free_num$field);
			}
			if (hasTotalWinNum) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 3);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, total_win_num$field);
			}
			if (hasStar) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 4);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, star$field);
			}
			if (hasLevel) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 5);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, level$field);
			}
			if (hasEndTime) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 6);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, end_time$field);
			}
			if (hasRound) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 7);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, round$field);
			}
			for (var target$index:uint = 0; target$index < this.target.length; ++target$index) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 8);
				com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, this.target[target$index]);
			}
			for (var logs$index:uint = 0; logs$index < this.logs.length; ++logs$index) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 9);
				com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, this.logs[logs$index]);
			}
			if (hasRank) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 10);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, rank$field);
			}
			if (hasTicketNum) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 11);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, ticket_num$field);
			}
			for (var fieldKey:* in this) {
				super.writeUnknown(output, fieldKey);
			}
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function readFromSlice(input:flash.utils.IDataInput, bytesAfterSlice:uint):void {
			var next_refresh_time$count:uint = 0;
			var free_num$count:uint = 0;
			var total_win_num$count:uint = 0;
			var star$count:uint = 0;
			var level$count:uint = 0;
			var end_time$count:uint = 0;
			var round$count:uint = 0;
			var rank$count:uint = 0;
			var ticket_num$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					if (next_refresh_time$count != 0) {
						throw new flash.errors.IOError('Bad data format: MSG_UPDATE_ARENA_ACK.nextRefreshTime cannot be set twice.');
					}
					++next_refresh_time$count;
					this.nextRefreshTime = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 2:
					if (free_num$count != 0) {
						throw new flash.errors.IOError('Bad data format: MSG_UPDATE_ARENA_ACK.freeNum cannot be set twice.');
					}
					++free_num$count;
					this.freeNum = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 3:
					if (total_win_num$count != 0) {
						throw new flash.errors.IOError('Bad data format: MSG_UPDATE_ARENA_ACK.totalWinNum cannot be set twice.');
					}
					++total_win_num$count;
					this.totalWinNum = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 4:
					if (star$count != 0) {
						throw new flash.errors.IOError('Bad data format: MSG_UPDATE_ARENA_ACK.star cannot be set twice.');
					}
					++star$count;
					this.star = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 5:
					if (level$count != 0) {
						throw new flash.errors.IOError('Bad data format: MSG_UPDATE_ARENA_ACK.level cannot be set twice.');
					}
					++level$count;
					this.level = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 6:
					if (end_time$count != 0) {
						throw new flash.errors.IOError('Bad data format: MSG_UPDATE_ARENA_ACK.endTime cannot be set twice.');
					}
					++end_time$count;
					this.endTime = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 7:
					if (round$count != 0) {
						throw new flash.errors.IOError('Bad data format: MSG_UPDATE_ARENA_ACK.round cannot be set twice.');
					}
					++round$count;
					this.round = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 8:
					this.target.push(com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, new com.gamehero.sxd2.pro.PRO_PlayerBase()));
					break;
				case 9:
					this.logs.push(com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, new com.gamehero.sxd2.pro.PRO_ArenaLog()));
					break;
				case 10:
					if (rank$count != 0) {
						throw new flash.errors.IOError('Bad data format: MSG_UPDATE_ARENA_ACK.rank cannot be set twice.');
					}
					++rank$count;
					this.rank = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 11:
					if (ticket_num$count != 0) {
						throw new flash.errors.IOError('Bad data format: MSG_UPDATE_ARENA_ACK.ticketNum cannot be set twice.');
					}
					++ticket_num$count;
					this.ticketNum = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
