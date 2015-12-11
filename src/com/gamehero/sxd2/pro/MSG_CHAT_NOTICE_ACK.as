package com.gamehero.sxd2.pro {
	import com.netease.protobuf.*;
	use namespace com.netease.protobuf.used_by_generated_code;
	import com.netease.protobuf.fieldDescriptors.*;
	import flash.utils.Endian;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.errors.IOError;
	import com.gamehero.sxd2.pro.PRO_Notice;
	// @@protoc_insertion_point(imports)

	// @@protoc_insertion_point(class_metadata)
	public final class MSG_CHAT_NOTICE_ACK extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const NOTICE:FieldDescriptor$TYPE_MESSAGE = new FieldDescriptor$TYPE_MESSAGE("com.gamehero.sxd2.pro.MSG_CHAT_NOTICE_ACK.notice", "notice", (1 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return com.gamehero.sxd2.pro.PRO_Notice; });

		private var notice$field:com.gamehero.sxd2.pro.PRO_Notice;

		public function clearNotice():void {
			notice$field = null;
		}

		public function get hasNotice():Boolean {
			return notice$field != null;
		}

		public function set notice(value:com.gamehero.sxd2.pro.PRO_Notice):void {
			notice$field = value;
		}

		public function get notice():com.gamehero.sxd2.pro.PRO_Notice {
			return notice$field;
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			if (hasNotice) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 1);
				com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, notice$field);
			}
			for (var fieldKey:* in this) {
				super.writeUnknown(output, fieldKey);
			}
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function readFromSlice(input:flash.utils.IDataInput, bytesAfterSlice:uint):void {
			var notice$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					if (notice$count != 0) {
						throw new flash.errors.IOError('Bad data format: MSG_CHAT_NOTICE_ACK.notice cannot be set twice.');
					}
					++notice$count;
					this.notice = new com.gamehero.sxd2.pro.PRO_Notice();
					com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, this.notice);
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
