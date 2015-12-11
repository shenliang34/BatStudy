package com.gamehero.sxd2.pro {
	import com.netease.protobuf.*;
	use namespace com.netease.protobuf.used_by_generated_code;
	import com.netease.protobuf.fieldDescriptors.*;
	import flash.utils.Endian;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.errors.IOError;
	import com.gamehero.sxd2.pro.PRO_Hero;
	// @@protoc_insertion_point(imports)

	// @@protoc_insertion_point(class_metadata)
	public final class MSG_HREO_BATTLE_ACK extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const HERO:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("com.gamehero.sxd2.pro.MSG_HREO_BATTLE_ACK.hero", "hero", (1 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return com.gamehero.sxd2.pro.PRO_Hero; });

		[ArrayElementType("com.gamehero.sxd2.pro.PRO_Hero")]
		public var hero:Array = [];

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			for (var hero$index:uint = 0; hero$index < this.hero.length; ++hero$index) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 1);
				com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, this.hero[hero$index]);
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
					this.hero.push(com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, new com.gamehero.sxd2.pro.PRO_Hero()));
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
