package com.gamehero.sxd2.pro {
	import com.netease.protobuf.*;
	use namespace com.netease.protobuf.used_by_generated_code;
	import com.netease.protobuf.fieldDescriptors.*;
	import flash.utils.Endian;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.errors.IOError;
	import com.gamehero.sxd2.pro.PRO_Item;
	// @@protoc_insertion_point(imports)

	// @@protoc_insertion_point(class_metadata)
	public final class MSG_CHAT_NOTIFY_ACK extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const CHANNEL:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.MSG_CHAT_NOTIFY_ACK.channel", "channel", (1 << 3) | com.netease.protobuf.WireType.VARINT);

		private var channel$field:uint;

		private var hasField$0:uint = 0;

		public function clearChannel():void {
			hasField$0 &= 0xfffffffe;
			channel$field = new uint();
		}

		public function get hasChannel():Boolean {
			return (hasField$0 & 0x1) != 0;
		}

		public function set channel(value:uint):void {
			hasField$0 |= 0x1;
			channel$field = value;
		}

		public function get channel():uint {
			return channel$field;
		}

		/**
		 *  @private
		 */
		public static const SENDER_ID:FieldDescriptor$TYPE_UINT64 = new FieldDescriptor$TYPE_UINT64("com.gamehero.sxd2.pro.MSG_CHAT_NOTIFY_ACK.sender_id", "senderId", (2 << 3) | com.netease.protobuf.WireType.VARINT);

		private var sender_id$field:UInt64;

		public function clearSenderId():void {
			sender_id$field = null;
		}

		public function get hasSenderId():Boolean {
			return sender_id$field != null;
		}

		public function set senderId(value:UInt64):void {
			sender_id$field = value;
		}

		public function get senderId():UInt64 {
			return sender_id$field;
		}

		/**
		 *  @private
		 */
		public static const SENDER_NAME:FieldDescriptor$TYPE_STRING = new FieldDescriptor$TYPE_STRING("com.gamehero.sxd2.pro.MSG_CHAT_NOTIFY_ACK.sender_name", "senderName", (3 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED);

		private var sender_name$field:String;

		public function clearSenderName():void {
			sender_name$field = null;
		}

		public function get hasSenderName():Boolean {
			return sender_name$field != null;
		}

		public function set senderName(value:String):void {
			sender_name$field = value;
		}

		public function get senderName():String {
			return sender_name$field;
		}

		/**
		 *  @private
		 */
		public static const MESSAGE:FieldDescriptor$TYPE_STRING = new FieldDescriptor$TYPE_STRING("com.gamehero.sxd2.pro.MSG_CHAT_NOTIFY_ACK.message", "message", (4 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED);

		private var message$field:String;

		public function clearMessage():void {
			message$field = null;
		}

		public function get hasMessage():Boolean {
			return message$field != null;
		}

		public function set message(value:String):void {
			message$field = value;
		}

		public function get message():String {
			return message$field;
		}

		/**
		 *  @private
		 */
		public static const DATA:FieldDescriptor$TYPE_MESSAGE = new FieldDescriptor$TYPE_MESSAGE("com.gamehero.sxd2.pro.MSG_CHAT_NOTIFY_ACK.data", "data", (5 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return com.gamehero.sxd2.pro.PRO_Item; });

		private var data$field:com.gamehero.sxd2.pro.PRO_Item;

		public function clearData():void {
			data$field = null;
		}

		public function get hasData():Boolean {
			return data$field != null;
		}

		public function set data(value:com.gamehero.sxd2.pro.PRO_Item):void {
			data$field = value;
		}

		public function get data():com.gamehero.sxd2.pro.PRO_Item {
			return data$field;
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			if (hasChannel) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 1);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, channel$field);
			}
			if (hasSenderId) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 2);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT64(output, sender_id$field);
			}
			if (hasSenderName) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 3);
				com.netease.protobuf.WriteUtils.write$TYPE_STRING(output, sender_name$field);
			}
			if (hasMessage) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 4);
				com.netease.protobuf.WriteUtils.write$TYPE_STRING(output, message$field);
			}
			if (hasData) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 5);
				com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, data$field);
			}
			for (var fieldKey:* in this) {
				super.writeUnknown(output, fieldKey);
			}
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function readFromSlice(input:flash.utils.IDataInput, bytesAfterSlice:uint):void {
			var channel$count:uint = 0;
			var sender_id$count:uint = 0;
			var sender_name$count:uint = 0;
			var message$count:uint = 0;
			var data$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					if (channel$count != 0) {
						throw new flash.errors.IOError('Bad data format: MSG_CHAT_NOTIFY_ACK.channel cannot be set twice.');
					}
					++channel$count;
					this.channel = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 2:
					if (sender_id$count != 0) {
						throw new flash.errors.IOError('Bad data format: MSG_CHAT_NOTIFY_ACK.senderId cannot be set twice.');
					}
					++sender_id$count;
					this.senderId = com.netease.protobuf.ReadUtils.read$TYPE_UINT64(input);
					break;
				case 3:
					if (sender_name$count != 0) {
						throw new flash.errors.IOError('Bad data format: MSG_CHAT_NOTIFY_ACK.senderName cannot be set twice.');
					}
					++sender_name$count;
					this.senderName = com.netease.protobuf.ReadUtils.read$TYPE_STRING(input);
					break;
				case 4:
					if (message$count != 0) {
						throw new flash.errors.IOError('Bad data format: MSG_CHAT_NOTIFY_ACK.message cannot be set twice.');
					}
					++message$count;
					this.message = com.netease.protobuf.ReadUtils.read$TYPE_STRING(input);
					break;
				case 5:
					if (data$count != 0) {
						throw new flash.errors.IOError('Bad data format: MSG_CHAT_NOTIFY_ACK.data cannot be set twice.');
					}
					++data$count;
					this.data = new com.gamehero.sxd2.pro.PRO_Item();
					com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, this.data);
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
