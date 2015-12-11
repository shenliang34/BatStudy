package com.gamehero.sxd2.pro {
	import com.netease.protobuf.*;
	use namespace com.netease.protobuf.used_by_generated_code;
	import com.netease.protobuf.fieldDescriptors.*;
	import flash.utils.Endian;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.errors.IOError;
	import com.gamehero.sxd2.pro.PRO_Instance;
	// @@protoc_insertion_point(imports)

	// @@protoc_insertion_point(class_metadata)
	public final class MSG_UPDATE_INSTANCE_ACK extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const INSTANCE:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("com.gamehero.sxd2.pro.MSG_UPDATE_INSTANCE_ACK.instance", "instance", (1 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return com.gamehero.sxd2.pro.PRO_Instance; });

		[ArrayElementType("com.gamehero.sxd2.pro.PRO_Instance")]
		public var instance:Array = [];

		/**
		 *  @private
		 */
		public static const BOX_RECEIVED:RepeatedFieldDescriptor$TYPE_BOOL = new RepeatedFieldDescriptor$TYPE_BOOL("com.gamehero.sxd2.pro.MSG_UPDATE_INSTANCE_ACK.box_received", "boxReceived", (2 << 3) | com.netease.protobuf.WireType.VARINT);

		[ArrayElementType("Boolean")]
		public var boxReceived:Array = [];

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			for (var instance$index:uint = 0; instance$index < this.instance.length; ++instance$index) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 1);
				com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, this.instance[instance$index]);
			}
			for (var boxReceived$index:uint = 0; boxReceived$index < this.boxReceived.length; ++boxReceived$index) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 2);
				com.netease.protobuf.WriteUtils.write$TYPE_BOOL(output, this.boxReceived[boxReceived$index]);
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
					this.instance.push(com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, new com.gamehero.sxd2.pro.PRO_Instance()));
					break;
				case 2:
					if ((tag & 7) == com.netease.protobuf.WireType.LENGTH_DELIMITED) {
						com.netease.protobuf.ReadUtils.readPackedRepeated(input, com.netease.protobuf.ReadUtils.read$TYPE_BOOL, this.boxReceived);
						break;
					}
					this.boxReceived.push(com.netease.protobuf.ReadUtils.read$TYPE_BOOL(input));
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
