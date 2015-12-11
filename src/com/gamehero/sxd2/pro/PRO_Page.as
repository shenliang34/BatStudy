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
	public final class PRO_Page extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const CUR_PAGE:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.PRO_Page.cur_page", "curPage", (1 << 3) | com.netease.protobuf.WireType.VARINT);

		private var cur_page$field:uint;

		private var hasField$0:uint = 0;

		public function clearCurPage():void {
			hasField$0 &= 0xfffffffe;
			cur_page$field = new uint();
		}

		public function get hasCurPage():Boolean {
			return (hasField$0 & 0x1) != 0;
		}

		public function set curPage(value:uint):void {
			hasField$0 |= 0x1;
			cur_page$field = value;
		}

		public function get curPage():uint {
			return cur_page$field;
		}

		/**
		 *  @private
		 */
		public static const TOTAL_PAGE:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.PRO_Page.total_page", "totalPage", (2 << 3) | com.netease.protobuf.WireType.VARINT);

		private var total_page$field:uint;

		public function clearTotalPage():void {
			hasField$0 &= 0xfffffffd;
			total_page$field = new uint();
		}

		public function get hasTotalPage():Boolean {
			return (hasField$0 & 0x2) != 0;
		}

		public function set totalPage(value:uint):void {
			hasField$0 |= 0x2;
			total_page$field = value;
		}

		public function get totalPage():uint {
			return total_page$field;
		}

		/**
		 *  @private
		 */
		public static const TOTAL_NUM:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.PRO_Page.total_num", "totalNum", (3 << 3) | com.netease.protobuf.WireType.VARINT);

		private var total_num$field:uint;

		public function clearTotalNum():void {
			hasField$0 &= 0xfffffffb;
			total_num$field = new uint();
		}

		public function get hasTotalNum():Boolean {
			return (hasField$0 & 0x4) != 0;
		}

		public function set totalNum(value:uint):void {
			hasField$0 |= 0x4;
			total_num$field = value;
		}

		public function get totalNum():uint {
			return total_num$field;
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			if (hasCurPage) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 1);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, cur_page$field);
			}
			if (hasTotalPage) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 2);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, total_page$field);
			}
			if (hasTotalNum) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 3);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, total_num$field);
			}
			for (var fieldKey:* in this) {
				super.writeUnknown(output, fieldKey);
			}
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function readFromSlice(input:flash.utils.IDataInput, bytesAfterSlice:uint):void {
			var cur_page$count:uint = 0;
			var total_page$count:uint = 0;
			var total_num$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					if (cur_page$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_Page.curPage cannot be set twice.');
					}
					++cur_page$count;
					this.curPage = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 2:
					if (total_page$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_Page.totalPage cannot be set twice.');
					}
					++total_page$count;
					this.totalPage = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 3:
					if (total_num$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_Page.totalNum cannot be set twice.');
					}
					++total_num$count;
					this.totalNum = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
