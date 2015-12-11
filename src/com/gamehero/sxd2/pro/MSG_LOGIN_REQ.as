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
	public final class MSG_LOGIN_REQ extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const LOGINKEY:FieldDescriptor$TYPE_STRING = new FieldDescriptor$TYPE_STRING("com.gamehero.sxd2.pro.MSG_LOGIN_REQ.loginKey", "loginKey", (1 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED);

		private var loginKey$field:String;

		public function clearLoginKey():void {
			loginKey$field = null;
		}

		public function get hasLoginKey():Boolean {
			return loginKey$field != null;
		}

		public function set loginKey(value:String):void {
			loginKey$field = value;
		}

		public function get loginKey():String {
			return loginKey$field;
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			if (hasLoginKey) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 1);
				com.netease.protobuf.WriteUtils.write$TYPE_STRING(output, loginKey$field);
			}
			for (var fieldKey:* in this) {
				super.writeUnknown(output, fieldKey);
			}
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function readFromSlice(input:flash.utils.IDataInput, bytesAfterSlice:uint):void {
			var loginKey$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					if (loginKey$count != 0) {
						throw new flash.errors.IOError('Bad data format: MSG_LOGIN_REQ.loginKey cannot be set twice.');
					}
					++loginKey$count;
					this.loginKey = com.netease.protobuf.ReadUtils.read$TYPE_STRING(input);
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
