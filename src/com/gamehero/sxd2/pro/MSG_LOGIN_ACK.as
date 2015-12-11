package com.gamehero.sxd2.pro {
	import com.netease.protobuf.*;
	use namespace com.netease.protobuf.used_by_generated_code;
	import com.netease.protobuf.fieldDescriptors.*;
	import flash.utils.Endian;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.errors.IOError;
	import com.gamehero.sxd2.pro.CHAR_ID_INFO;
	// @@protoc_insertion_point(imports)

	// @@protoc_insertion_point(class_metadata)
	public final class MSG_LOGIN_ACK extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const CHARS:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("com.gamehero.sxd2.pro.MSG_LOGIN_ACK.chars", "chars", (1 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return com.gamehero.sxd2.pro.CHAR_ID_INFO; });

		[ArrayElementType("com.gamehero.sxd2.pro.CHAR_ID_INFO")]
		public var chars:Array = [];

		/**
		 *  @private
		 */
		public static const SERVERVER:FieldDescriptor$TYPE_STRING = new FieldDescriptor$TYPE_STRING("com.gamehero.sxd2.pro.MSG_LOGIN_ACK.serverVer", "serverVer", (2 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED);

		private var serverVer$field:String;

		public function clearServerVer():void {
			serverVer$field = null;
		}

		public function get hasServerVer():Boolean {
			return serverVer$field != null;
		}

		public function set serverVer(value:String):void {
			serverVer$field = value;
		}

		public function get serverVer():String {
			return serverVer$field;
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			for (var chars$index:uint = 0; chars$index < this.chars.length; ++chars$index) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 1);
				com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, this.chars[chars$index]);
			}
			if (hasServerVer) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 2);
				com.netease.protobuf.WriteUtils.write$TYPE_STRING(output, serverVer$field);
			}
			for (var fieldKey:* in this) {
				super.writeUnknown(output, fieldKey);
			}
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function readFromSlice(input:flash.utils.IDataInput, bytesAfterSlice:uint):void {
			var serverVer$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					this.chars.push(com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, new com.gamehero.sxd2.pro.CHAR_ID_INFO()));
					break;
				case 2:
					if (serverVer$count != 0) {
						throw new flash.errors.IOError('Bad data format: MSG_LOGIN_ACK.serverVer cannot be set twice.');
					}
					++serverVer$count;
					this.serverVer = com.netease.protobuf.ReadUtils.read$TYPE_STRING(input);
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
