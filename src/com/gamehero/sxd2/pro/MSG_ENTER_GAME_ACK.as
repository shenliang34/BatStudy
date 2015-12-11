package com.gamehero.sxd2.pro {
	import com.netease.protobuf.*;
	use namespace com.netease.protobuf.used_by_generated_code;
	import com.netease.protobuf.fieldDescriptors.*;
	import flash.utils.Endian;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.errors.IOError;
	import com.gamehero.sxd2.pro.PRO_Drama;
	import com.gamehero.sxd2.pro.PRO_Player;
	import com.gamehero.sxd2.pro.PRO_FunctionInfo;
	// @@protoc_insertion_point(imports)

	// @@protoc_insertion_point(class_metadata)
	public final class MSG_ENTER_GAME_ACK extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const PLAYER:FieldDescriptor$TYPE_MESSAGE = new FieldDescriptor$TYPE_MESSAGE("com.gamehero.sxd2.pro.MSG_ENTER_GAME_ACK.player", "player", (1 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return com.gamehero.sxd2.pro.PRO_Player; });

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
		public static const GAME_CONFIG:FieldDescriptor$TYPE_STRING = new FieldDescriptor$TYPE_STRING("com.gamehero.sxd2.pro.MSG_ENTER_GAME_ACK.game_config", "gameConfig", (2 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED);

		private var game_config$field:String;

		public function clearGameConfig():void {
			game_config$field = null;
		}

		public function get hasGameConfig():Boolean {
			return game_config$field != null;
		}

		public function set gameConfig(value:String):void {
			game_config$field = value;
		}

		public function get gameConfig():String {
			return game_config$field;
		}

		/**
		 *  @private
		 */
		public static const DRAMAS:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("com.gamehero.sxd2.pro.MSG_ENTER_GAME_ACK.dramas", "dramas", (3 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return com.gamehero.sxd2.pro.PRO_Drama; });

		[ArrayElementType("com.gamehero.sxd2.pro.PRO_Drama")]
		public var dramas:Array = [];

		/**
		 *  @private
		 */
		public static const FUNCTIONS:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("com.gamehero.sxd2.pro.MSG_ENTER_GAME_ACK.functions", "functions", (4 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return com.gamehero.sxd2.pro.PRO_FunctionInfo; });

		[ArrayElementType("com.gamehero.sxd2.pro.PRO_FunctionInfo")]
		public var functions:Array = [];

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			if (hasPlayer) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 1);
				com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, player$field);
			}
			if (hasGameConfig) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 2);
				com.netease.protobuf.WriteUtils.write$TYPE_STRING(output, game_config$field);
			}
			for (var dramas$index:uint = 0; dramas$index < this.dramas.length; ++dramas$index) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 3);
				com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, this.dramas[dramas$index]);
			}
			for (var functions$index:uint = 0; functions$index < this.functions.length; ++functions$index) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 4);
				com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, this.functions[functions$index]);
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
			var game_config$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					if (player$count != 0) {
						throw new flash.errors.IOError('Bad data format: MSG_ENTER_GAME_ACK.player cannot be set twice.');
					}
					++player$count;
					this.player = new com.gamehero.sxd2.pro.PRO_Player();
					com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, this.player);
					break;
				case 2:
					if (game_config$count != 0) {
						throw new flash.errors.IOError('Bad data format: MSG_ENTER_GAME_ACK.gameConfig cannot be set twice.');
					}
					++game_config$count;
					this.gameConfig = com.netease.protobuf.ReadUtils.read$TYPE_STRING(input);
					break;
				case 3:
					this.dramas.push(com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, new com.gamehero.sxd2.pro.PRO_Drama()));
					break;
				case 4:
					this.functions.push(com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, new com.gamehero.sxd2.pro.PRO_FunctionInfo()));
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
