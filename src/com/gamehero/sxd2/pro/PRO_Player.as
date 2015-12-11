package com.gamehero.sxd2.pro {
	import com.netease.protobuf.*;
	use namespace com.netease.protobuf.used_by_generated_code;
	import com.netease.protobuf.fieldDescriptors.*;
	import flash.utils.Endian;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.errors.IOError;
	import com.gamehero.sxd2.pro.PRO_PlayerBase;
	import com.gamehero.sxd2.pro.PRO_PlayerExtra;
	import com.gamehero.sxd2.pro.PRO_Map;
	// @@protoc_insertion_point(imports)

	// @@protoc_insertion_point(class_metadata)
	public final class PRO_Player extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const ID:FieldDescriptor$TYPE_UINT64 = new FieldDescriptor$TYPE_UINT64("com.gamehero.sxd2.pro.PRO_Player.id", "id", (1 << 3) | com.netease.protobuf.WireType.VARINT);

		private var id$field:UInt64;

		public function clearId():void {
			id$field = null;
		}

		public function get hasId():Boolean {
			return id$field != null;
		}

		public function set id(value:UInt64):void {
			id$field = value;
		}

		public function get id():UInt64 {
			return id$field;
		}

		/**
		 *  @private
		 */
		public static const MAP:FieldDescriptor$TYPE_MESSAGE = new FieldDescriptor$TYPE_MESSAGE("com.gamehero.sxd2.pro.PRO_Player.map", "map", (2 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return com.gamehero.sxd2.pro.PRO_Map; });

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
		public static const BASE:FieldDescriptor$TYPE_MESSAGE = new FieldDescriptor$TYPE_MESSAGE("com.gamehero.sxd2.pro.PRO_Player.base", "base", (3 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return com.gamehero.sxd2.pro.PRO_PlayerBase; });

		private var base$field:com.gamehero.sxd2.pro.PRO_PlayerBase;

		public function clearBase():void {
			base$field = null;
		}

		public function get hasBase():Boolean {
			return base$field != null;
		}

		public function set base(value:com.gamehero.sxd2.pro.PRO_PlayerBase):void {
			base$field = value;
		}

		public function get base():com.gamehero.sxd2.pro.PRO_PlayerBase {
			return base$field;
		}

		/**
		 *  @private
		 */
		public static const EXTRA:FieldDescriptor$TYPE_MESSAGE = new FieldDescriptor$TYPE_MESSAGE("com.gamehero.sxd2.pro.PRO_Player.extra", "extra", (4 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return com.gamehero.sxd2.pro.PRO_PlayerExtra; });

		private var extra$field:com.gamehero.sxd2.pro.PRO_PlayerExtra;

		public function clearExtra():void {
			extra$field = null;
		}

		public function get hasExtra():Boolean {
			return extra$field != null;
		}

		public function set extra(value:com.gamehero.sxd2.pro.PRO_PlayerExtra):void {
			extra$field = value;
		}

		public function get extra():com.gamehero.sxd2.pro.PRO_PlayerExtra {
			return extra$field;
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			if (hasId) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 1);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT64(output, id$field);
			}
			if (hasMap) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 2);
				com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, map$field);
			}
			if (hasBase) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 3);
				com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, base$field);
			}
			if (hasExtra) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 4);
				com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, extra$field);
			}
			for (var fieldKey:* in this) {
				super.writeUnknown(output, fieldKey);
			}
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function readFromSlice(input:flash.utils.IDataInput, bytesAfterSlice:uint):void {
			var id$count:uint = 0;
			var map$count:uint = 0;
			var base$count:uint = 0;
			var extra$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					if (id$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_Player.id cannot be set twice.');
					}
					++id$count;
					this.id = com.netease.protobuf.ReadUtils.read$TYPE_UINT64(input);
					break;
				case 2:
					if (map$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_Player.map cannot be set twice.');
					}
					++map$count;
					this.map = new com.gamehero.sxd2.pro.PRO_Map();
					com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, this.map);
					break;
				case 3:
					if (base$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_Player.base cannot be set twice.');
					}
					++base$count;
					this.base = new com.gamehero.sxd2.pro.PRO_PlayerBase();
					com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, this.base);
					break;
				case 4:
					if (extra$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_Player.extra cannot be set twice.');
					}
					++extra$count;
					this.extra = new com.gamehero.sxd2.pro.PRO_PlayerExtra();
					com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, this.extra);
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
