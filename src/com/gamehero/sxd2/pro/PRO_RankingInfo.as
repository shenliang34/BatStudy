package com.gamehero.sxd2.pro {
	import com.netease.protobuf.*;
	use namespace com.netease.protobuf.used_by_generated_code;
	import com.netease.protobuf.fieldDescriptors.*;
	import flash.utils.Endian;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.errors.IOError;
	import com.gamehero.sxd2.pro.PRO_Player;
	// @@protoc_insertion_point(imports)

	// @@protoc_insertion_point(class_metadata)
	public final class PRO_RankingInfo extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const RANK:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.PRO_RankingInfo.rank", "rank", (1 << 3) | com.netease.protobuf.WireType.VARINT);

		private var rank$field:uint;

		private var hasField$0:uint = 0;

		public function clearRank():void {
			hasField$0 &= 0xfffffffe;
			rank$field = new uint();
		}

		public function get hasRank():Boolean {
			return (hasField$0 & 0x1) != 0;
		}

		public function set rank(value:uint):void {
			hasField$0 |= 0x1;
			rank$field = value;
		}

		public function get rank():uint {
			return rank$field;
		}

		/**
		 *  @private
		 */
		public static const PLAYER:FieldDescriptor$TYPE_MESSAGE = new FieldDescriptor$TYPE_MESSAGE("com.gamehero.sxd2.pro.PRO_RankingInfo.player", "player", (2 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return com.gamehero.sxd2.pro.PRO_Player; });

		private var player$field:com.gamehero.sxd2.pro.PRO_Player;

		public function clearPlayer():void {
			player$field = null;
		}

		public function get hasPlayer():Boolean {
			return player$field != null;
		}

		public function set player(value:com.gamehero.sxd2.pro.PRO_Player):void {
			player$field = value;
		}

		public function get player():com.gamehero.sxd2.pro.PRO_Player {
			return player$field;
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			if (hasRank) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 1);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, rank$field);
			}
			if (hasPlayer) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 2);
				com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, player$field);
			}
			for (var fieldKey:* in this) {
				super.writeUnknown(output, fieldKey);
			}
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function readFromSlice(input:flash.utils.IDataInput, bytesAfterSlice:uint):void {
			var rank$count:uint = 0;
			var player$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					if (rank$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_RankingInfo.rank cannot be set twice.');
					}
					++rank$count;
					this.rank = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 2:
					if (player$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_RankingInfo.player cannot be set twice.');
					}
					++player$count;
					this.player = new com.gamehero.sxd2.pro.PRO_Player();
					com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, this.player);
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
