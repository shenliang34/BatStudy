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
	public final class MSG_UPDATE_PRAY_ACK extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const LUCKY:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.MSG_UPDATE_PRAY_ACK.lucky", "lucky", (1 << 3) | com.netease.protobuf.WireType.VARINT);

		private var lucky$field:uint;

		private var hasField$0:uint = 0;

		public function clearLucky():void {
			hasField$0 &= 0xfffffffe;
			lucky$field = new uint();
		}

		public function get hasLucky():Boolean {
			return (hasField$0 & 0x1) != 0;
		}

		public function set lucky(value:uint):void {
			hasField$0 |= 0x1;
			lucky$field = value;
		}

		public function get lucky():uint {
			return lucky$field;
		}

		/**
		 *  @private
		 */
		public static const ITEMS:RepeatedFieldDescriptor$TYPE_UINT32 = new RepeatedFieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.MSG_UPDATE_PRAY_ACK.items", "items", (2 << 3) | com.netease.protobuf.WireType.VARINT);

		[ArrayElementType("uint")]
		public var items:Array = [];

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			if (hasLucky) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 1);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, lucky$field);
			}
			for (var items$index:uint = 0; items$index < this.items.length; ++items$index) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 2);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, this.items[items$index]);
			}
			for (var fieldKey:* in this) {
				super.writeUnknown(output, fieldKey);
			}
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function readFromSlice(input:flash.utils.IDataInput, bytesAfterSlice:uint):void {
			var lucky$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					if (lucky$count != 0) {
						throw new flash.errors.IOError('Bad data format: MSG_UPDATE_PRAY_ACK.lucky cannot be set twice.');
					}
					++lucky$count;
					this.lucky = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 2:
					if ((tag & 7) == com.netease.protobuf.WireType.LENGTH_DELIMITED) {
						com.netease.protobuf.ReadUtils.readPackedRepeated(input, com.netease.protobuf.ReadUtils.read$TYPE_UINT32, this.items);
						break;
					}
					this.items.push(com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input));
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
