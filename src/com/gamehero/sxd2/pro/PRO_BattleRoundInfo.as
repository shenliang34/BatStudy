package com.gamehero.sxd2.pro {
	import com.netease.protobuf.*;
	use namespace com.netease.protobuf.used_by_generated_code;
	import com.netease.protobuf.fieldDescriptors.*;
	import flash.utils.Endian;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.errors.IOError;
	import com.gamehero.sxd2.pro.PRO_BattlePlayer;
	// @@protoc_insertion_point(imports)

	// @@protoc_insertion_point(class_metadata)
	public final class PRO_BattleRoundInfo extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const INITPLAYERS:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("com.gamehero.sxd2.pro.PRO_BattleRoundInfo.initPlayers", "initPlayers", (1 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return com.gamehero.sxd2.pro.PRO_BattlePlayer; });

		[ArrayElementType("com.gamehero.sxd2.pro.PRO_BattlePlayer")]
		public var initPlayers:Array = [];

		/**
		 *  @private
		 */
		public static const ACTIONPLAYERS:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("com.gamehero.sxd2.pro.PRO_BattleRoundInfo.actionPlayers", "actionPlayers", (2 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return com.gamehero.sxd2.pro.PRO_BattlePlayer; });

		[ArrayElementType("com.gamehero.sxd2.pro.PRO_BattlePlayer")]
		public var actionPlayers:Array = [];

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			for (var initPlayers$index:uint = 0; initPlayers$index < this.initPlayers.length; ++initPlayers$index) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 1);
				com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, this.initPlayers[initPlayers$index]);
			}
			for (var actionPlayers$index:uint = 0; actionPlayers$index < this.actionPlayers.length; ++actionPlayers$index) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 2);
				com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, this.actionPlayers[actionPlayers$index]);
			}
			for (var fieldKey:* in this) {
				super.writeUnknown(output, fieldKey);
			}
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function readFromSlice(input:flash.utils.IDataInput, bytesAfterSlice:uint):void {
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					this.initPlayers.push(com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, new com.gamehero.sxd2.pro.PRO_BattlePlayer()));
					break;
				case 2:
					this.actionPlayers.push(com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, new com.gamehero.sxd2.pro.PRO_BattlePlayer()));
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
