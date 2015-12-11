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
	public final class MSG_INSTANCE_CLEANUP_REQ extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const INSTANCE_ID:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.MSG_INSTANCE_CLEANUP_REQ.instance_id", "instanceId", (1 << 3) | com.netease.protobuf.WireType.VARINT);

		private var instance_id$field:uint;

		private var hasField$0:uint = 0;

		public function clearInstanceId():void {
			hasField$0 &= 0xfffffffe;
			instance_id$field = new uint();
		}

		public function get hasInstanceId():Boolean {
			return (hasField$0 & 0x1) != 0;
		}

		public function set instanceId(value:uint):void {
			hasField$0 |= 0x1;
			instance_id$field = value;
		}

		public function get instanceId():uint {
			return instance_id$field;
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			if (hasInstanceId) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 1);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, instance_id$field);
			}
			for (var fieldKey:* in this) {
				super.writeUnknown(output, fieldKey);
			}
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function readFromSlice(input:flash.utils.IDataInput, bytesAfterSlice:uint):void {
			var instance_id$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					if (instance_id$count != 0) {
						throw new flash.errors.IOError('Bad data format: MSG_INSTANCE_CLEANUP_REQ.instanceId cannot be set twice.');
					}
					++instance_id$count;
					this.instanceId = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
