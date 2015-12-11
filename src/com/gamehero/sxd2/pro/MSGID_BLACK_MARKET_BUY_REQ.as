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
	public final class MSGID_BLACK_MARKET_BUY_REQ extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const INDEX:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.MSGID_BLACK_MARKET_BUY_REQ.index", "index", (1 << 3) | com.netease.protobuf.WireType.VARINT);

		private var index$field:uint;

		private var hasField$0:uint = 0;

		public function clearIndex():void {
			hasField$0 &= 0xfffffffe;
			index$field = new uint();
		}

		public function get hasIndex():Boolean {
			return (hasField$0 & 0x1) != 0;
		}

		public function set index(value:uint):void {
			hasField$0 |= 0x1;
			index$field = value;
		}

		public function get index():uint {
			return index$field;
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			if (hasIndex) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 1);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, index$field);
			}
			for (var fieldKey:* in this) {
				super.writeUnknown(output, fieldKey);
			}
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function readFromSlice(input:flash.utils.IDataInput, bytesAfterSlice:uint):void {
			var index$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					if (index$count != 0) {
						throw new flash.errors.IOError('Bad data format: MSGID_BLACK_MARKET_BUY_REQ.index cannot be set twice.');
					}
					++index$count;
					this.index = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
