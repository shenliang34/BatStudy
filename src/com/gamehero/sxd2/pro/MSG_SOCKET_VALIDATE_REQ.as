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
	public final class MSG_SOCKET_VALIDATE_REQ extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const TIMESTAMP:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.MSG_SOCKET_VALIDATE_REQ.timestamp", "timestamp", (1 << 3) | com.netease.protobuf.WireType.VARINT);

		private var timestamp$field:uint;

		private var hasField$0:uint = 0;

		public function clearTimestamp():void {
			hasField$0 &= 0xfffffffe;
			timestamp$field = new uint();
		}

		public function get hasTimestamp():Boolean {
			return (hasField$0 & 0x1) != 0;
		}

		public function set timestamp(value:uint):void {
			hasField$0 |= 0x1;
			timestamp$field = value;
		}

		public function get timestamp():uint {
			return timestamp$field;
		}

		/**
		 *  @private
		 */
		public static const CRC:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.MSG_SOCKET_VALIDATE_REQ.crc", "crc", (2 << 3) | com.netease.protobuf.WireType.VARINT);

		private var crc$field:uint;

		public function clearCrc():void {
			hasField$0 &= 0xfffffffd;
			crc$field = new uint();
		}

		public function get hasCrc():Boolean {
			return (hasField$0 & 0x2) != 0;
		}

		public function set crc(value:uint):void {
			hasField$0 |= 0x2;
			crc$field = value;
		}

		public function get crc():uint {
			return crc$field;
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			if (hasTimestamp) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 1);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, timestamp$field);
			}
			if (hasCrc) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 2);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, crc$field);
			}
			for (var fieldKey:* in this) {
				super.writeUnknown(output, fieldKey);
			}
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function readFromSlice(input:flash.utils.IDataInput, bytesAfterSlice:uint):void {
			var timestamp$count:uint = 0;
			var crc$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					if (timestamp$count != 0) {
						throw new flash.errors.IOError('Bad data format: MSG_SOCKET_VALIDATE_REQ.timestamp cannot be set twice.');
					}
					++timestamp$count;
					this.timestamp = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 2:
					if (crc$count != 0) {
						throw new flash.errors.IOError('Bad data format: MSG_SOCKET_VALIDATE_REQ.crc cannot be set twice.');
					}
					++crc$count;
					this.crc = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
