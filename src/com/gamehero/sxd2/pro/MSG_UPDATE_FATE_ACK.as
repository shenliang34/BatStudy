package com.gamehero.sxd2.pro {
	import com.netease.protobuf.*;
	use namespace com.netease.protobuf.used_by_generated_code;
	import com.netease.protobuf.fieldDescriptors.*;
	import flash.utils.Endian;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.errors.IOError;
	import com.gamehero.sxd2.pro.PRO_Fate;
	// @@protoc_insertion_point(imports)

	// @@protoc_insertion_point(class_metadata)
	public final class MSG_UPDATE_FATE_ACK extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const FATE:FieldDescriptor$TYPE_MESSAGE = new FieldDescriptor$TYPE_MESSAGE("com.gamehero.sxd2.pro.MSG_UPDATE_FATE_ACK.fate", "fate", (1 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return com.gamehero.sxd2.pro.PRO_Fate; });

		private var fate$field:com.gamehero.sxd2.pro.PRO_Fate;

		public function clearFate():void {
			fate$field = null;
		}

		public function get hasFate():Boolean {
			return fate$field != null;
		}

		public function set fate(value:com.gamehero.sxd2.pro.PRO_Fate):void {
			fate$field = value;
		}

		public function get fate():com.gamehero.sxd2.pro.PRO_Fate {
			return fate$field;
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			if (hasFate) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 1);
				com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, fate$field);
			}
			for (var fieldKey:* in this) {
				super.writeUnknown(output, fieldKey);
			}
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function readFromSlice(input:flash.utils.IDataInput, bytesAfterSlice:uint):void {
			var fate$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					if (fate$count != 0) {
						throw new flash.errors.IOError('Bad data format: MSG_UPDATE_FATE_ACK.fate cannot be set twice.');
					}
					++fate$count;
					this.fate = new com.gamehero.sxd2.pro.PRO_Fate();
					com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, this.fate);
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
