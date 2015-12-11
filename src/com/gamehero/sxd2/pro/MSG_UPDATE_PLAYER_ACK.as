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
	public final class MSG_UPDATE_PLAYER_ACK extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const PLAYER:FieldDescriptor$TYPE_MESSAGE = new FieldDescriptor$TYPE_MESSAGE("com.gamehero.sxd2.pro.MSG_UPDATE_PLAYER_ACK.player", "player", (1 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return com.gamehero.sxd2.pro.PRO_Player; });

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
			if (hasPlayer) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 1);
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
			var player$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					if (player$count != 0) {
						throw new flash.errors.IOError('Bad data format: MSG_UPDATE_PLAYER_ACK.player cannot be set twice.');
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
