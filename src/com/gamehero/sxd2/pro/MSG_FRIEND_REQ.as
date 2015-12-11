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
	public final class MSG_FRIEND_REQ extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const FRIEND_TYPE:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.MSG_FRIEND_REQ.friend_type", "friendType", (1 << 3) | com.netease.protobuf.WireType.VARINT);

		private var friend_type$field:uint;

		private var hasField$0:uint = 0;

		public function clearFriendType():void {
			hasField$0 &= 0xfffffffe;
			friend_type$field = new uint();
		}

		public function get hasFriendType():Boolean {
			return (hasField$0 & 0x1) != 0;
		}

		public function set friendType(value:uint):void {
			hasField$0 |= 0x1;
			friend_type$field = value;
		}

		public function get friendType():uint {
			return friend_type$field;
		}

		/**
		 *  @private
		 */
		public static const FRIEND_NAME:FieldDescriptor$TYPE_STRING = new FieldDescriptor$TYPE_STRING("com.gamehero.sxd2.pro.MSG_FRIEND_REQ.friend_name", "friendName", (2 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED);

		private var friend_name$field:String;

		public function clearFriendName():void {
			friend_name$field = null;
		}

		public function get hasFriendName():Boolean {
			return friend_name$field != null;
		}

		public function set friendName(value:String):void {
			friend_name$field = value;
		}

		public function get friendName():String {
			return friend_name$field;
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			if (hasFriendType) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 1);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, friend_type$field);
			}
			if (hasFriendName) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 2);
				com.netease.protobuf.WriteUtils.write$TYPE_STRING(output, friend_name$field);
			}
			for (var fieldKey:* in this) {
				super.writeUnknown(output, fieldKey);
			}
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function readFromSlice(input:flash.utils.IDataInput, bytesAfterSlice:uint):void {
			var friend_type$count:uint = 0;
			var friend_name$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					if (friend_type$count != 0) {
						throw new flash.errors.IOError('Bad data format: MSG_FRIEND_REQ.friendType cannot be set twice.');
					}
					++friend_type$count;
					this.friendType = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 2:
					if (friend_name$count != 0) {
						throw new flash.errors.IOError('Bad data format: MSG_FRIEND_REQ.friendName cannot be set twice.');
					}
					++friend_name$count;
					this.friendName = com.netease.protobuf.ReadUtils.read$TYPE_STRING(input);
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
