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
	public final class MSG_CENTER_LOGIN_ACK extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const IP:FieldDescriptor$TYPE_STRING = new FieldDescriptor$TYPE_STRING("com.gamehero.sxd2.pro.MSG_CENTER_LOGIN_ACK.ip", "ip", (1 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED);

		private var ip$field:String;

		public function clearIp():void {
			ip$field = null;
		}

		public function get hasIp():Boolean {
			return ip$field != null;
		}

		public function set ip(value:String):void {
			ip$field = value;
		}

		public function get ip():String {
			return ip$field;
		}

		/**
		 *  @private
		 */
		public static const PORT:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.MSG_CENTER_LOGIN_ACK.port", "port", (2 << 3) | com.netease.protobuf.WireType.VARINT);

		private var port$field:uint;

		private var hasField$0:uint = 0;

		public function clearPort():void {
			hasField$0 &= 0xfffffffe;
			port$field = new uint();
		}

		public function get hasPort():Boolean {
			return (hasField$0 & 0x1) != 0;
		}

		public function set port(value:uint):void {
			hasField$0 |= 0x1;
			port$field = value;
		}

		public function get port():uint {
			return port$field;
		}

		/**
		 *  @private
		 */
		public static const LOGINKEY:FieldDescriptor$TYPE_STRING = new FieldDescriptor$TYPE_STRING("com.gamehero.sxd2.pro.MSG_CENTER_LOGIN_ACK.loginKey", "loginKey", (3 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED);

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
			if (hasIp) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 1);
				com.netease.protobuf.WriteUtils.write$TYPE_STRING(output, ip$field);
			}
			if (hasPort) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 2);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, port$field);
			}
			if (hasLoginKey) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 3);
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
			var ip$count:uint = 0;
			var port$count:uint = 0;
			var loginKey$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					if (ip$count != 0) {
						throw new flash.errors.IOError('Bad data format: MSG_CENTER_LOGIN_ACK.ip cannot be set twice.');
					}
					++ip$count;
					this.ip = com.netease.protobuf.ReadUtils.read$TYPE_STRING(input);
					break;
				case 2:
					if (port$count != 0) {
						throw new flash.errors.IOError('Bad data format: MSG_CENTER_LOGIN_ACK.port cannot be set twice.');
					}
					++port$count;
					this.port = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 3:
					if (loginKey$count != 0) {
						throw new flash.errors.IOError('Bad data format: MSG_CENTER_LOGIN_ACK.loginKey cannot be set twice.');
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
