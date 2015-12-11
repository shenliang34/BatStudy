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
	public final class MSG_CENTER_LOGIN_REQ extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const SERVER:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.MSG_CENTER_LOGIN_REQ.server", "server", (1 << 3) | com.netease.protobuf.WireType.VARINT);

		private var server$field:uint;

		private var hasField$0:uint = 0;

		public function clearServer():void {
			hasField$0 &= 0xfffffffe;
			server$field = new uint();
		}

		public function get hasServer():Boolean {
			return (hasField$0 & 0x1) != 0;
		}

		public function set server(value:uint):void {
			hasField$0 |= 0x1;
			server$field = value;
		}

		public function get server():uint {
			return server$field;
		}

		/**
		 *  @private
		 */
		public static const USERID:FieldDescriptor$TYPE_STRING = new FieldDescriptor$TYPE_STRING("com.gamehero.sxd2.pro.MSG_CENTER_LOGIN_REQ.userId", "userId", (2 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED);

		private var userId$field:String;

		public function clearUserId():void {
			userId$field = null;
		}

		public function get hasUserId():Boolean {
			return userId$field != null;
		}

		public function set userId(value:String):void {
			userId$field = value;
		}

		public function get userId():String {
			return userId$field;
		}

		/**
		 *  @private
		 */
		public static const KEY:FieldDescriptor$TYPE_STRING = new FieldDescriptor$TYPE_STRING("com.gamehero.sxd2.pro.MSG_CENTER_LOGIN_REQ.key", "key", (3 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED);

		private var key$field:String;

		public function clearKey():void {
			key$field = null;
		}

		public function get hasKey():Boolean {
			return key$field != null;
		}

		public function set key(value:String):void {
			key$field = value;
		}

		public function get key():String {
			return key$field;
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			if (hasServer) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 1);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, server$field);
			}
			if (hasUserId) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 2);
				com.netease.protobuf.WriteUtils.write$TYPE_STRING(output, userId$field);
			}
			if (hasKey) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 3);
				com.netease.protobuf.WriteUtils.write$TYPE_STRING(output, key$field);
			}
			for (var fieldKey:* in this) {
				super.writeUnknown(output, fieldKey);
			}
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function readFromSlice(input:flash.utils.IDataInput, bytesAfterSlice:uint):void {
			var server$count:uint = 0;
			var userId$count:uint = 0;
			var key$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					if (server$count != 0) {
						throw new flash.errors.IOError('Bad data format: MSG_CENTER_LOGIN_REQ.server cannot be set twice.');
					}
					++server$count;
					this.server = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 2:
					if (userId$count != 0) {
						throw new flash.errors.IOError('Bad data format: MSG_CENTER_LOGIN_REQ.userId cannot be set twice.');
					}
					++userId$count;
					this.userId = com.netease.protobuf.ReadUtils.read$TYPE_STRING(input);
					break;
				case 3:
					if (key$count != 0) {
						throw new flash.errors.IOError('Bad data format: MSG_CENTER_LOGIN_REQ.key cannot be set twice.');
					}
					++key$count;
					this.key = com.netease.protobuf.ReadUtils.read$TYPE_STRING(input);
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
