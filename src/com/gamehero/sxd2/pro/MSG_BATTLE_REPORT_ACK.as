package com.gamehero.sxd2.pro {
	import com.netease.protobuf.*;
	use namespace com.netease.protobuf.used_by_generated_code;
	import com.netease.protobuf.fieldDescriptors.*;
	import flash.utils.Endian;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.errors.IOError;
	import com.gamehero.sxd2.pro.PRO_BattleDetail;
	// @@protoc_insertion_point(imports)

	// @@protoc_insertion_point(class_metadata)
	public final class MSG_BATTLE_REPORT_ACK extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const DETAIL:FieldDescriptor$TYPE_MESSAGE = new FieldDescriptor$TYPE_MESSAGE("com.gamehero.sxd2.pro.MSG_BATTLE_REPORT_ACK.detail", "detail", (1 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return com.gamehero.sxd2.pro.PRO_BattleDetail; });

		private var detail$field:com.gamehero.sxd2.pro.PRO_BattleDetail;

		public function clearDetail():void {
			detail$field = null;
		}

		public function get hasDetail():Boolean {
			return detail$field != null;
		}

		public function set detail(value:com.gamehero.sxd2.pro.PRO_BattleDetail):void {
			detail$field = value;
		}

		public function get detail():com.gamehero.sxd2.pro.PRO_BattleDetail {
			return detail$field;
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			if (hasDetail) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 1);
				com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, detail$field);
			}
			for (var fieldKey:* in this) {
				super.writeUnknown(output, fieldKey);
			}
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function readFromSlice(input:flash.utils.IDataInput, bytesAfterSlice:uint):void {
			var detail$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					if (detail$count != 0) {
						throw new flash.errors.IOError('Bad data format: MSG_BATTLE_REPORT_ACK.detail cannot be set twice.');
					}
					++detail$count;
					this.detail = new com.gamehero.sxd2.pro.PRO_BattleDetail();
					com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, this.detail);
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
