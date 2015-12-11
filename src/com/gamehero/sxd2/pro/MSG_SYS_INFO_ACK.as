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
	public final class MSG_SYS_INFO_ACK extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const SERVER_TIME:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.MSG_SYS_INFO_ACK.server_time", "serverTime", (1 << 3) | com.netease.protobuf.WireType.VARINT);

		private var server_time$field:uint;

		private var hasField$0:uint = 0;

		public function clearServerTime():void {
			hasField$0 &= 0xfffffffe;
			server_time$field = new uint();
		}

		public function get hasServerTime():Boolean {
			return (hasField$0 & 0x1) != 0;
		}

		public function set serverTime(value:uint):void {
			hasField$0 |= 0x1;
			server_time$field = value;
		}

		public function get serverTime():uint {
			return server_time$field;
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			if (hasServerTime) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 1);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, server_time$field);
			}
			for (var fieldKey:* in this) {
				super.writeUnknown(output, fieldKey);
			}
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function readFromSlice(input:flash.utils.IDataInput, bytesAfterSlice:uint):void {
			var server_time$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					if (server_time$count != 0) {
						throw new flash.errors.IOError('Bad data format: MSG_SYS_INFO_ACK.serverTime cannot be set twice.');
					}
					++server_time$count;
					this.serverTime = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
