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
	public final class MSG_MAP_MOVE_REQ extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const MAP:FieldDescriptor$TYPE_MESSAGE = new FieldDescriptor$TYPE_MESSAGE("com.gamehero.sxd2.pro.MSG_MAP_MOVE_REQ.map", "map", (1 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return com.gamehero.sxd2.pro.PRO_Map; });

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
		public static const IS_STOP:FieldDescriptor$TYPE_BOOL = new FieldDescriptor$TYPE_BOOL("com.gamehero.sxd2.pro.MSG_MAP_MOVE_REQ.is_stop", "isStop", (2 << 3) | com.netease.protobuf.WireType.VARINT);

		private var is_stop$field:Boolean;

		private var hasField$0:uint = 0;

		public function clearIsStop():void {
			hasField$0 &= 0xfffffffe;
			is_stop$field = new Boolean();
		}

		public function get hasIsStop():Boolean {
			return (hasField$0 & 0x1) != 0;
		}

		public function set isStop(value:Boolean):void {
			hasField$0 |= 0x1;
			is_stop$field = value;
		}

		public function get isStop():Boolean {
			return is_stop$field;
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			if (hasMap) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 1);
				com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, map$field);
			}
			if (hasIsStop) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 2);
				com.netease.protobuf.WriteUtils.write$TYPE_BOOL(output, is_stop$field);
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
			var is_stop$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					if (map$count != 0) {
						throw new flash.errors.IOError('Bad data format: MSG_MAP_MOVE_REQ.map cannot be set twice.');
					}
					++map$count;
					this.map = new com.gamehero.sxd2.pro.PRO_Map();
					com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, this.map);
					break;
				case 2:
					if (is_stop$count != 0) {
						throw new flash.errors.IOError('Bad data format: MSG_MAP_MOVE_REQ.isStop cannot be set twice.');
					}
					++is_stop$count;
					this.isStop = com.netease.protobuf.ReadUtils.read$TYPE_BOOL(input);
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
