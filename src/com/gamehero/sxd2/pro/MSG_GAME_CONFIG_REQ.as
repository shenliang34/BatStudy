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
	public final class MSG_GAME_CONFIG_REQ extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const CONFIG:FieldDescriptor$TYPE_STRING = new FieldDescriptor$TYPE_STRING("com.gamehero.sxd2.pro.MSG_GAME_CONFIG_REQ.config", "config", (1 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED);

		private var config$field:String;

		public function clearConfig():void {
			config$field = null;
		}

		public function get hasConfig():Boolean {
			return config$field != null;
		}

		public function set config(value:String):void {
			config$field = value;
		}

		public function get config():String {
			return config$field;
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			if (hasConfig) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 1);
				com.netease.protobuf.WriteUtils.write$TYPE_STRING(output, config$field);
			}
			for (var fieldKey:* in this) {
				super.writeUnknown(output, fieldKey);
			}
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function readFromSlice(input:flash.utils.IDataInput, bytesAfterSlice:uint):void {
			var config$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					if (config$count != 0) {
						throw new flash.errors.IOError('Bad data format: MSG_GAME_CONFIG_REQ.config cannot be set twice.');
					}
					++config$count;
					this.config = com.netease.protobuf.ReadUtils.read$TYPE_STRING(input);
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
