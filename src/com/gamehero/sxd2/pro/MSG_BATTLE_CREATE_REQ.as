package com.gamehero.sxd2.pro {
	import com.netease.protobuf.*;
	use namespace com.netease.protobuf.used_by_generated_code;
	import com.netease.protobuf.fieldDescriptors.*;
	import flash.utils.Endian;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)

	// @@protoc_insertion_point(class_metadata)
	public final class MSG_BATTLE_CREATE_REQ extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const BATTLE_ID:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.MSG_BATTLE_CREATE_REQ.battle_id", "battleId", (1 << 3) | com.netease.protobuf.WireType.VARINT);

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
		public static const PLAYER_ID:FieldDescriptor$TYPE_UINT64 = new FieldDescriptor$TYPE_UINT64("com.gamehero.sxd2.pro.MSG_BATTLE_CREATE_REQ.player_id", "playerId", (2 << 3) | com.netease.protobuf.WireType.VARINT);

		private var player_id$field:UInt64;

		public function clearPlayerId():void {
			player_id$field = null;
		}

		public function get hasPlayerId():Boolean {
			return player_id$field != null;
		}

		public function set playerId(value:UInt64):void {
			player_id$field = value;
		}

		public function get playerId():UInt64 {
			return player_id$field;
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			if (hasBattleId) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 1);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, battle_id$field);
			}
			if (hasPlayerId) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 2);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT64(output, player_id$field);
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
			var player_id$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					if (battle_id$count != 0) {
						throw new flash.errors.IOError('Bad data format: MSG_BATTLE_CREATE_REQ.battleId cannot be set twice.');
					}
					++battle_id$count;
					this.battleId = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 2:
					if (player_id$count != 0) {
						throw new flash.errors.IOError('Bad data format: MSG_BATTLE_CREATE_REQ.playerId cannot be set twice.');
					}
					++player_id$count;
					this.playerId = com.netease.protobuf.ReadUtils.read$TYPE_UINT64(input);
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
