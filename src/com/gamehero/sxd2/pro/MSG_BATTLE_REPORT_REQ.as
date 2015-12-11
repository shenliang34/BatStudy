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
	public final class MSG_BATTLE_REPORT_REQ extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const REPORT_ID:FieldDescriptor$TYPE_UINT64 = new FieldDescriptor$TYPE_UINT64("com.gamehero.sxd2.pro.MSG_BATTLE_REPORT_REQ.report_id", "reportId", (1 << 3) | com.netease.protobuf.WireType.VARINT);

		private var report_id$field:UInt64;

		public function clearReportId():void {
			report_id$field = null;
		}

		public function get hasReportId():Boolean {
			return report_id$field != null;
		}

		public function set reportId(value:UInt64):void {
			report_id$field = value;
		}

		public function get reportId():UInt64 {
			return report_id$field;
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			if (hasReportId) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 1);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT64(output, report_id$field);
			}
			for (var fieldKey:* in this) {
				super.writeUnknown(output, fieldKey);
			}
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function readFromSlice(input:flash.utils.IDataInput, bytesAfterSlice:uint):void {
			var report_id$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					if (report_id$count != 0) {
						throw new flash.errors.IOError('Bad data format: MSG_BATTLE_REPORT_REQ.reportId cannot be set twice.');
					}
					++report_id$count;
					this.reportId = com.netease.protobuf.ReadUtils.read$TYPE_UINT64(input);
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
