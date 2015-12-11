package com.gamehero.sxd2.pro {
	import com.netease.protobuf.*;
	use namespace com.netease.protobuf.used_by_generated_code;
	import com.netease.protobuf.fieldDescriptors.*;
	import flash.utils.Endian;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.errors.IOError;
	import com.gamehero.sxd2.pro.STORE_TYPE;
	// @@protoc_insertion_point(imports)

	// @@protoc_insertion_point(class_metadata)
	public final class MSG_COMMON_BUY_REQ extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const TYPE:FieldDescriptor$TYPE_ENUM = new FieldDescriptor$TYPE_ENUM("com.gamehero.sxd2.pro.MSG_COMMON_BUY_REQ.type", "type", (1 << 3) | com.netease.protobuf.WireType.VARINT, com.gamehero.sxd2.pro.STORE_TYPE);

		public var type:int;

		/**
		 *  @private
		 */
		public static const ITEM_ID:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.MSG_COMMON_BUY_REQ.item_id", "itemId", (2 << 3) | com.netease.protobuf.WireType.VARINT);

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
		public static const OPT:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.MSG_COMMON_BUY_REQ.opt", "opt", (3 << 3) | com.netease.protobuf.WireType.VARINT);

		private var opt$field:uint;

		public function clearOpt():void {
			hasField$0 &= 0xfffffffd;
			opt$field = new uint();
		}

		public function get hasOpt():Boolean {
			return (hasField$0 & 0x2) != 0;
		}

		public function set opt(value:uint):void {
			hasField$0 |= 0x2;
			opt$field = value;
		}

		public function get opt():uint {
			return opt$field;
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 1);
			com.netease.protobuf.WriteUtils.write$TYPE_ENUM(output, this.type);
			if (hasItemId) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 2);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, item_id$field);
			}
			if (hasOpt) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 3);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, opt$field);
			}
			for (var fieldKey:* in this) {
				super.writeUnknown(output, fieldKey);
			}
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function readFromSlice(input:flash.utils.IDataInput, bytesAfterSlice:uint):void {
			var type$count:uint = 0;
			var item_id$count:uint = 0;
			var opt$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					if (type$count != 0) {
						throw new flash.errors.IOError('Bad data format: MSG_COMMON_BUY_REQ.type cannot be set twice.');
					}
					++type$count;
					this.type = com.netease.protobuf.ReadUtils.read$TYPE_ENUM(input);
					break;
				case 2:
					if (item_id$count != 0) {
						throw new flash.errors.IOError('Bad data format: MSG_COMMON_BUY_REQ.itemId cannot be set twice.');
					}
					++item_id$count;
					this.itemId = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 3:
					if (opt$count != 0) {
						throw new flash.errors.IOError('Bad data format: MSG_COMMON_BUY_REQ.opt cannot be set twice.');
					}
					++opt$count;
					this.opt = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
