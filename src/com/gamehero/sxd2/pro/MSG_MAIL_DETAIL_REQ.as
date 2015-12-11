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
	public final class MSG_MAIL_DETAIL_REQ extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const MAIL_ID:FieldDescriptor$TYPE_UINT64 = new FieldDescriptor$TYPE_UINT64("com.gamehero.sxd2.pro.MSG_MAIL_DETAIL_REQ.mail_id", "mailId", (1 << 3) | com.netease.protobuf.WireType.VARINT);

		private var mail_id$field:UInt64;

		public function clearMailId():void {
			mail_id$field = null;
		}

		public function get hasMailId():Boolean {
			return mail_id$field != null;
		}

		public function set mailId(value:UInt64):void {
			mail_id$field = value;
		}

		public function get mailId():UInt64 {
			return mail_id$field;
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			if (hasMailId) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 1);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT64(output, mail_id$field);
			}
			for (var fieldKey:* in this) {
				super.writeUnknown(output, fieldKey);
			}
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function readFromSlice(input:flash.utils.IDataInput, bytesAfterSlice:uint):void {
			var mail_id$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					if (mail_id$count != 0) {
						throw new flash.errors.IOError('Bad data format: MSG_MAIL_DETAIL_REQ.mailId cannot be set twice.');
					}
					++mail_id$count;
					this.mailId = com.netease.protobuf.ReadUtils.read$TYPE_UINT64(input);
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
