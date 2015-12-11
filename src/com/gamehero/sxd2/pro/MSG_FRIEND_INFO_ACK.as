package com.gamehero.sxd2.pro {
	import com.netease.protobuf.*;
	use namespace com.netease.protobuf.used_by_generated_code;
	import com.netease.protobuf.fieldDescriptors.*;
	import flash.utils.Endian;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.errors.IOError;
	import com.gamehero.sxd2.pro.PRO_Friend;
	// @@protoc_insertion_point(imports)

	// @@protoc_insertion_point(class_metadata)
	public final class MSG_FRIEND_INFO_ACK extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const NUM:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.MSG_FRIEND_INFO_ACK.num", "num", (1 << 3) | com.netease.protobuf.WireType.VARINT);

		private var num$field:uint;

		private var hasField$0:uint = 0;

		public function clearNum():void {
			hasField$0 &= 0xfffffffe;
			num$field = new uint();
		}

		public function get hasNum():Boolean {
			return (hasField$0 & 0x1) != 0;
		}

		public function set num(value:uint):void {
			hasField$0 |= 0x1;
			num$field = value;
		}

		public function get num():uint {
			return num$field;
		}

		/**
		 *  @private
		 */
		public static const FRIENDS:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("com.gamehero.sxd2.pro.MSG_FRIEND_INFO_ACK.friends", "friends", (2 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return com.gamehero.sxd2.pro.PRO_Friend; });

		[ArrayElementType("com.gamehero.sxd2.pro.PRO_Friend")]
		public var friends:Array = [];

		/**
		 *  @private
		 */
		public static const CONTACTS:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("com.gamehero.sxd2.pro.MSG_FRIEND_INFO_ACK.contacts", "contacts", (3 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return com.gamehero.sxd2.pro.PRO_Friend; });

		[ArrayElementType("com.gamehero.sxd2.pro.PRO_Friend")]
		public var contacts:Array = [];

		/**
		 *  @private
		 */
		public static const BLACKLIST:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("com.gamehero.sxd2.pro.MSG_FRIEND_INFO_ACK.Blacklist", "blacklist", (4 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return com.gamehero.sxd2.pro.PRO_Friend; });

		[ArrayElementType("com.gamehero.sxd2.pro.PRO_Friend")]
		public var blacklist:Array = [];

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			if (hasNum) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 1);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, num$field);
			}
			for (var friends$index:uint = 0; friends$index < this.friends.length; ++friends$index) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 2);
				com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, this.friends[friends$index]);
			}
			for (var contacts$index:uint = 0; contacts$index < this.contacts.length; ++contacts$index) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 3);
				com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, this.contacts[contacts$index]);
			}
			for (var blacklist$index:uint = 0; blacklist$index < this.blacklist.length; ++blacklist$index) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 4);
				com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, this.blacklist[blacklist$index]);
			}
			for (var fieldKey:* in this) {
				super.writeUnknown(output, fieldKey);
			}
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function readFromSlice(input:flash.utils.IDataInput, bytesAfterSlice:uint):void {
			var num$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					if (num$count != 0) {
						throw new flash.errors.IOError('Bad data format: MSG_FRIEND_INFO_ACK.num cannot be set twice.');
					}
					++num$count;
					this.num = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 2:
					this.friends.push(com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, new com.gamehero.sxd2.pro.PRO_Friend()));
					break;
				case 3:
					this.contacts.push(com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, new com.gamehero.sxd2.pro.PRO_Friend()));
					break;
				case 4:
					this.blacklist.push(com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, new com.gamehero.sxd2.pro.PRO_Friend()));
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
