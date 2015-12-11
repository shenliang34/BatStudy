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
	public final class MSG_ITEM_UPGRADE_REQ extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const ITEM_ID:FieldDescriptor$TYPE_UINT64 = new FieldDescriptor$TYPE_UINT64("com.gamehero.sxd2.pro.MSG_ITEM_UPGRADE_REQ.item_id", "itemId", (1 << 3) | com.netease.protobuf.WireType.VARINT);

		private var item_id$field:UInt64;

		public function clearItemId():void {
			item_id$field = null;
		}

		public function get hasItemId():Boolean {
			return item_id$field != null;
		}

		public function set itemId(value:UInt64):void {
			item_id$field = value;
		}

		public function get itemId():UInt64 {
			return item_id$field;
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			if (hasItemId) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 1);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT64(output, item_id$field);
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
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					if (item_id$count != 0) {
						throw new flash.errors.IOError('Bad data format: MSG_ITEM_UPGRADE_REQ.itemId cannot be set twice.');
					}
					++item_id$count;
					this.itemId = com.netease.protobuf.ReadUtils.read$TYPE_UINT64(input);
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
