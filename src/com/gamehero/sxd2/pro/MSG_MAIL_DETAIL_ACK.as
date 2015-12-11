package com.gamehero.sxd2.pro {
	import com.netease.protobuf.*;
	use namespace com.netease.protobuf.used_by_generated_code;
	import com.netease.protobuf.fieldDescriptors.*;
	import flash.utils.Endian;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.errors.IOError;
	import com.gamehero.sxd2.pro.PRO_Mail_Detail;
	// @@protoc_insertion_point(imports)

	// @@protoc_insertion_point(class_metadata)
	public final class MSG_MAIL_DETAIL_ACK extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const MAIL_DETAIL:FieldDescriptor$TYPE_MESSAGE = new FieldDescriptor$TYPE_MESSAGE("com.gamehero.sxd2.pro.MSG_MAIL_DETAIL_ACK.mail_detail", "mailDetail", (1 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return com.gamehero.sxd2.pro.PRO_Mail_Detail; });

		private var mail_detail$field:com.gamehero.sxd2.pro.PRO_Mail_Detail;

		public function clearMailDetail():void {
			mail_detail$field = null;
		}

		public function get hasMailDetail():Boolean {
			return mail_detail$field != null;
		}

		public function set mailDetail(value:com.gamehero.sxd2.pro.PRO_Mail_Detail):void {
			mail_detail$field = value;
		}

		public function get mailDetail():com.gamehero.sxd2.pro.PRO_Mail_Detail {
			return mail_detail$field;
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			if (hasMailDetail) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 1);
				com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, mail_detail$field);
			}
			for (var fieldKey:* in this) {
				super.writeUnknown(output, fieldKey);
			}
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function readFromSlice(input:flash.utils.IDataInput, bytesAfterSlice:uint):void {
			var mail_detail$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					if (mail_detail$count != 0) {
						throw new flash.errors.IOError('Bad data format: MSG_MAIL_DETAIL_ACK.mailDetail cannot be set twice.');
					}
					++mail_detail$count;
					this.mailDetail = new com.gamehero.sxd2.pro.PRO_Mail_Detail();
					com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, this.mailDetail);
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
