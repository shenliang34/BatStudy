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
	public final class PRO_Item extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const ID:FieldDescriptor$TYPE_UINT64 = new FieldDescriptor$TYPE_UINT64("com.gamehero.sxd2.pro.PRO_Item.id", "id", (1 << 3) | com.netease.protobuf.WireType.VARINT);

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
		public static const ITEM_ID:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.PRO_Item.item_id", "itemId", (2 << 3) | com.netease.protobuf.WireType.VARINT);

		private var item_id$field:uint;

		private var hasField$0:uint = 0;

		public function clearItemId():void {
			hasField$0 &= 0xfffffffe;
			item_id$field = new uint();
		}

		public function get hasItemId():Boolean {
			return (hasField$0 & 0x1) != 0;
		}

		public function set itemId(value:uint):void {
			hasField$0 |= 0x1;
			item_id$field = value;
		}

		public function get itemId():uint {
			return item_id$field;
		}

		/**
		 *  @private
		 */
		public static const NUM:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.PRO_Item.num", "num", (3 << 3) | com.netease.protobuf.WireType.VARINT);

		private var num$field:uint;

		public function clearNum():void {
			hasField$0 &= 0xfffffffd;
			num$field = new uint();
		}

		public function get hasNum():Boolean {
			return (hasField$0 & 0x2) != 0;
		}

		public function set num(value:uint):void {
			hasField$0 |= 0x2;
			num$field = value;
		}

		public function get num():uint {
			return num$field;
		}

		/**
		 *  @private
		 */
		public static const ADD_LEVEL:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.PRO_Item.add_level", "addLevel", (4 << 3) | com.netease.protobuf.WireType.VARINT);

		private var add_level$field:uint;

		public function clearAddLevel():void {
			hasField$0 &= 0xfffffffb;
			add_level$field = new uint();
		}

		public function get hasAddLevel():Boolean {
			return (hasField$0 & 0x4) != 0;
		}

		public function set addLevel(value:uint):void {
			hasField$0 |= 0x4;
			add_level$field = value;
		}

		public function get addLevel():uint {
			return add_level$field;
		}

		/**
		 *  @private
		 */
		public static const TYPE:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.PRO_Item.type", "type", (5 << 3) | com.netease.protobuf.WireType.VARINT);

		private var type$field:uint;

		public function clearType():void {
			hasField$0 &= 0xfffffff7;
			type$field = new uint();
		}

		public function get hasType():Boolean {
			return (hasField$0 & 0x8) != 0;
		}

		public function set type(value:uint):void {
			hasField$0 |= 0x8;
			type$field = value;
		}

		public function get type():uint {
			return type$field;
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			if (hasId) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 1);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT64(output, id$field);
			}
			if (hasItemId) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 2);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, item_id$field);
			}
			if (hasNum) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 3);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, num$field);
			}
			if (hasAddLevel) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 4);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, add_level$field);
			}
			if (hasType) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 5);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, type$field);
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
			var item_id$count:uint = 0;
			var num$count:uint = 0;
			var add_level$count:uint = 0;
			var type$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					if (id$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_Item.id cannot be set twice.');
					}
					++id$count;
					this.id = com.netease.protobuf.ReadUtils.read$TYPE_UINT64(input);
					break;
				case 2:
					if (item_id$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_Item.itemId cannot be set twice.');
					}
					++item_id$count;
					this.itemId = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 3:
					if (num$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_Item.num cannot be set twice.');
					}
					++num$count;
					this.num = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 4:
					if (add_level$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_Item.addLevel cannot be set twice.');
					}
					++add_level$count;
					this.addLevel = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 5:
					if (type$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_Item.type cannot be set twice.');
					}
					++type$count;
					this.type = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
