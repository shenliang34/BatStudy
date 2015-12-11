package com.gamehero.sxd2.pro {
	import com.netease.protobuf.*;
	use namespace com.netease.protobuf.used_by_generated_code;
	import com.netease.protobuf.fieldDescriptors.*;
	import flash.utils.Endian;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.errors.IOError;
	import com.gamehero.sxd2.pro.BuyCount;
	// @@protoc_insertion_point(imports)

	// @@protoc_insertion_point(class_metadata)
	public final class MSG_UPDATE_QUICK_BUY_ACK extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const ITEMS:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("com.gamehero.sxd2.pro.MSG_UPDATE_QUICK_BUY_ACK.items", "items", (1 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return com.gamehero.sxd2.pro.BuyCount; });

		[ArrayElementType("com.gamehero.sxd2.pro.BuyCount")]
		public var items:Array = [];

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			for (var items$index:uint = 0; items$index < this.items.length; ++items$index) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 1);
				com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, this.items[items$index]);
			}
			for (var fieldKey:* in this) {
				super.writeUnknown(output, fieldKey);
			}
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function readFromSlice(input:flash.utils.IDataInput, bytesAfterSlice:uint):void {
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					this.items.push(com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, new com.gamehero.sxd2.pro.BuyCount()));
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
