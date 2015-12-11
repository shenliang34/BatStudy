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
	public final class MSG_RAND_NAME_REQ extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const SEX:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.MSG_RAND_NAME_REQ.sex", "sex", (1 << 3) | com.netease.protobuf.WireType.VARINT);

		private var sex$field:uint;

		private var hasField$0:uint = 0;

		public function clearSex():void {
			hasField$0 &= 0xfffffffe;
			sex$field = new uint();
		}

		public function get hasSex():Boolean {
			return (hasField$0 & 0x1) != 0;
		}

		public function set sex(value:uint):void {
			hasField$0 |= 0x1;
			sex$field = value;
		}

		public function get sex():uint {
			return sex$field;
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			if (hasSex) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 1);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, sex$field);
			}
			for (var fieldKey:* in this) {
				super.writeUnknown(output, fieldKey);
			}
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function readFromSlice(input:flash.utils.IDataInput, bytesAfterSlice:uint):void {
			var sex$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					if (sex$count != 0) {
						throw new flash.errors.IOError('Bad data format: MSG_RAND_NAME_REQ.sex cannot be set twice.');
					}
					++sex$count;
					this.sex = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
