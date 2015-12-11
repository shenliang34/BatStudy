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
	public final class MSG_FRIEND_HISTORY_CONTENTS_REQ extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const FRIEND_ID:FieldDescriptor$TYPE_UINT64 = new FieldDescriptor$TYPE_UINT64("com.gamehero.sxd2.pro.MSG_FRIEND_HISTORY_CONTENTS_REQ.friend_id", "friendId", (1 << 3) | com.netease.protobuf.WireType.VARINT);

		private var friend_id$field:UInt64;

		public function clearFriendId():void {
			friend_id$field = null;
		}

		public function get hasFriendId():Boolean {
			return friend_id$field != null;
		}

		public function set friendId(value:UInt64):void {
			friend_id$field = value;
		}

		public function get friendId():UInt64 {
			return friend_id$field;
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			if (hasFriendId) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 1);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT64(output, friend_id$field);
			}
			for (var fieldKey:* in this) {
				super.writeUnknown(output, fieldKey);
			}
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function readFromSlice(input:flash.utils.IDataInput, bytesAfterSlice:uint):void {
			var friend_id$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					if (friend_id$count != 0) {
						throw new flash.errors.IOError('Bad data format: MSG_FRIEND_HISTORY_CONTENTS_REQ.friendId cannot be set twice.');
					}
					++friend_id$count;
					this.friendId = com.netease.protobuf.ReadUtils.read$TYPE_UINT64(input);
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
