package com.gamehero.sxd2.pro {
	import com.netease.protobuf.*;
	use namespace com.netease.protobuf.used_by_generated_code;
	import com.netease.protobuf.fieldDescriptors.*;
	import flash.utils.Endian;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.errors.IOError;
	import com.gamehero.sxd2.pro.PRO_BlackMarketItem;
	// @@protoc_insertion_point(imports)

	// @@protoc_insertion_point(class_metadata)
	public final class MSG_UPDATE_BLACK_MARKET_ACK extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const ITEM:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("com.gamehero.sxd2.pro.MSG_UPDATE_BLACK_MARKET_ACK.item", "item", (1 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return com.gamehero.sxd2.pro.PRO_BlackMarketItem; });

		[ArrayElementType("com.gamehero.sxd2.pro.PRO_BlackMarketItem")]
		public var item:Array = [];

		/**
		 *  @private
		 */
		public static const LAST_REFRESH_TIME:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.MSG_UPDATE_BLACK_MARKET_ACK.last_refresh_time", "lastRefreshTime", (2 << 3) | com.netease.protobuf.WireType.VARINT);

		private var last_refresh_time$field:uint;

		private var hasField$0:uint = 0;

		public function clearLastRefreshTime():void {
			hasField$0 &= 0xfffffffe;
			last_refresh_time$field = new uint();
		}

		public function get hasLastRefreshTime():Boolean {
			return (hasField$0 & 0x1) != 0;
		}

		public function set lastRefreshTime(value:uint):void {
			hasField$0 |= 0x1;
			last_refresh_time$field = value;
		}

		public function get lastRefreshTime():uint {
			return last_refresh_time$field;
		}

		/**
		 *  @private
		 */
		public static const FREE_NUM:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.MSG_UPDATE_BLACK_MARKET_ACK.free_num", "freeNum", (3 << 3) | com.netease.protobuf.WireType.VARINT);

		private var free_num$field:uint;

		public function clearFreeNum():void {
			hasField$0 &= 0xfffffffd;
			free_num$field = new uint();
		}

		public function get hasFreeNum():Boolean {
			return (hasField$0 & 0x2) != 0;
		}

		public function set freeNum(value:uint):void {
			hasField$0 |= 0x2;
			free_num$field = value;
		}

		public function get freeNum():uint {
			return free_num$field;
		}

		/**
		 *  @private
		 */
		public static const TOTAL_NUM:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.MSG_UPDATE_BLACK_MARKET_ACK.total_num", "totalNum", (4 << 3) | com.netease.protobuf.WireType.VARINT);

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
			for (var item$index:uint = 0; item$index < this.item.length; ++item$index) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 1);
				com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, this.item[item$index]);
			}
			if (hasLastRefreshTime) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 2);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, last_refresh_time$field);
			}
			if (hasFreeNum) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 3);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, free_num$field);
			}
			if (hasTotalNum) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 4);
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
			var last_refresh_time$count:uint = 0;
			var free_num$count:uint = 0;
			var total_num$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					this.item.push(com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, new com.gamehero.sxd2.pro.PRO_BlackMarketItem()));
					break;
				case 2:
					if (last_refresh_time$count != 0) {
						throw new flash.errors.IOError('Bad data format: MSG_UPDATE_BLACK_MARKET_ACK.lastRefreshTime cannot be set twice.');
					}
					++last_refresh_time$count;
					this.lastRefreshTime = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 3:
					if (free_num$count != 0) {
						throw new flash.errors.IOError('Bad data format: MSG_UPDATE_BLACK_MARKET_ACK.freeNum cannot be set twice.');
					}
					++free_num$count;
					this.freeNum = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 4:
					if (total_num$count != 0) {
						throw new flash.errors.IOError('Bad data format: MSG_UPDATE_BLACK_MARKET_ACK.totalNum cannot be set twice.');
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
