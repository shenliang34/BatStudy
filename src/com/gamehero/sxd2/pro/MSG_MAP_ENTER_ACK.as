package com.gamehero.sxd2.pro {
	import com.netease.protobuf.*;
	use namespace com.netease.protobuf.used_by_generated_code;
	import com.netease.protobuf.fieldDescriptors.*;
	import flash.utils.Endian;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.errors.IOError;
	import com.gamehero.sxd2.pro.PRO_Map;
	// @@protoc_insertion_point(imports)

	// @@protoc_insertion_point(class_metadata)
	public final class MSG_MAP_ENTER_ACK extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const MAP:FieldDescriptor$TYPE_MESSAGE = new FieldDescriptor$TYPE_MESSAGE("com.gamehero.sxd2.pro.MSG_MAP_ENTER_ACK.map", "map", (1 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return com.gamehero.sxd2.pro.PRO_Map; });

		private var map$field:com.gamehero.sxd2.pro.PRO_Map;

		public function clearMap():void {
			map$field = null;
		}

		public function get hasMap():Boolean {
			return map$field != null;
		}

		public function set map(value:com.gamehero.sxd2.pro.PRO_Map):void {
			map$field = value;
		}

		public function get map():com.gamehero.sxd2.pro.PRO_Map {
			return map$field;
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			if (hasMap) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 1);
				com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, map$field);
			}
			for (var fieldKey:* in this) {
				super.writeUnknown(output, fieldKey);
			}
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function readFromSlice(input:flash.utils.IDataInput, bytesAfterSlice:uint):void {
			var map$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					if (map$count != 0) {
						throw new flash.errors.IOError('Bad data format: MSG_MAP_ENTER_ACK.map cannot be set twice.');
					}
					++map$count;
					this.map = new com.gamehero.sxd2.pro.PRO_Map();
					com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, this.map);
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
