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
	public final class BuyCount extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const ITEM_ID:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.BuyCount.item_id", "itemId", (1 << 3) | com.netease.protobuf.WireType.VARINT);

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
		public static const BUY_COUNT:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.BuyCount.buy_count", "buyCount", (2 << 3) | com.netease.protobuf.WireType.VARINT);

		private var buy_count$field:uint;

		public function clearBuyCount():void {
			hasField$0 &= 0xfffffffd;
			buy_count$field = new uint();
		}

		public function get hasBuyCount():Boolean {
			return (hasField$0 & 0x2) != 0;
		}

		public function set buyCount(value:uint):void {
			hasField$0 |= 0x2;
			buy_count$field = value;
		}

		public function get buyCount():uint {
			return buy_count$field;
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			if (hasItemId) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 1);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, item_id$field);
			}
			if (hasBuyCount) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 2);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, buy_count$field);
			}
			for (var fieldKey:* in this) {
				super.writeUnknown(output, fieldKey);
			}
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function readFromSlice(input:flash.utils.IDataInput, bytesAfterSlice:uint):void {
			var item_id$count:uint = 0;
			var buy_count$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					if (item_id$count != 0) {
						throw new flash.errors.IOError('Bad data format: BuyCount.itemId cannot be set twice.');
					}
					++item_id$count;
					this.itemId = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 2:
					if (buy_count$count != 0) {
						throw new flash.errors.IOError('Bad data format: BuyCount.buyCount cannot be set twice.');
					}
					++buy_count$count;
					this.buyCount = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
