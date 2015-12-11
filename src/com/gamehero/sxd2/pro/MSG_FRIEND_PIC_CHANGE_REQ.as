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
	public final class MSG_FRIEND_PIC_CHANGE_REQ extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const PORTRAIT_ID:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.MSG_FRIEND_PIC_CHANGE_REQ.portrait_id", "portraitId", (1 << 3) | com.netease.protobuf.WireType.VARINT);

		private var portrait_id$field:uint;

		private var hasField$0:uint = 0;

		public function clearPortraitId():void {
			hasField$0 &= 0xfffffffe;
			portrait_id$field = new uint();
		}

		public function get hasPortraitId():Boolean {
			return (hasField$0 & 0x1) != 0;
		}

		public function set portraitId(value:uint):void {
			hasField$0 |= 0x1;
			portrait_id$field = value;
		}

		public function get portraitId():uint {
			return portrait_id$field;
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			if (hasPortraitId) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 1);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, portrait_id$field);
			}
			for (var fieldKey:* in this) {
				super.writeUnknown(output, fieldKey);
			}
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function readFromSlice(input:flash.utils.IDataInput, bytesAfterSlice:uint):void {
			var portrait_id$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					if (portrait_id$count != 0) {
						throw new flash.errors.IOError('Bad data format: MSG_FRIEND_PIC_CHANGE_REQ.portraitId cannot be set twice.');
					}
					++portrait_id$count;
					this.portraitId = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
