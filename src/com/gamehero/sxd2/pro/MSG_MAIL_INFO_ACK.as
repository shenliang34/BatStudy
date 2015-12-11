package com.gamehero.sxd2.pro {
	import com.netease.protobuf.*;
	use namespace com.netease.protobuf.used_by_generated_code;
	import com.netease.protobuf.fieldDescriptors.*;
	import flash.utils.Endian;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.errors.IOError;
	import com.gamehero.sxd2.pro.PRO_Mail_Info;
	import com.gamehero.sxd2.pro.PRO_Page;
	// @@protoc_insertion_point(imports)

	// @@protoc_insertion_point(class_metadata)
	public final class MSG_MAIL_INFO_ACK extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const PAGE_INFO:FieldDescriptor$TYPE_MESSAGE = new FieldDescriptor$TYPE_MESSAGE("com.gamehero.sxd2.pro.MSG_MAIL_INFO_ACK.page_info", "pageInfo", (1 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return com.gamehero.sxd2.pro.PRO_Page; });

		private var page_info$field:com.gamehero.sxd2.pro.PRO_Page;

		public function clearPageInfo():void {
			page_info$field = null;
		}

		public function get hasPageInfo():Boolean {
			return page_info$field != null;
		}

		public function set pageInfo(value:com.gamehero.sxd2.pro.PRO_Page):void {
			page_info$field = value;
		}

		public function get pageInfo():com.gamehero.sxd2.pro.PRO_Page {
			return page_info$field;
		}

		/**
		 *  @private
		 */
		public static const MAIL:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("com.gamehero.sxd2.pro.MSG_MAIL_INFO_ACK.mail", "mail", (2 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return com.gamehero.sxd2.pro.PRO_Mail_Info; });

		[ArrayElementType("com.gamehero.sxd2.pro.PRO_Mail_Info")]
		public var mail:Array = [];

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			if (hasPageInfo) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 1);
				com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, page_info$field);
			}
			for (var mail$index:uint = 0; mail$index < this.mail.length; ++mail$index) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 2);
				com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, this.mail[mail$index]);
			}
			for (var fieldKey:* in this) {
				super.writeUnknown(output, fieldKey);
			}
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function readFromSlice(input:flash.utils.IDataInput, bytesAfterSlice:uint):void {
			var page_info$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					if (page_info$count != 0) {
						throw new flash.errors.IOError('Bad data format: MSG_MAIL_INFO_ACK.pageInfo cannot be set twice.');
					}
					++page_info$count;
					this.pageInfo = new com.gamehero.sxd2.pro.PRO_Page();
					com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, this.pageInfo);
					break;
				case 2:
					this.mail.push(com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, new com.gamehero.sxd2.pro.PRO_Mail_Info()));
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
