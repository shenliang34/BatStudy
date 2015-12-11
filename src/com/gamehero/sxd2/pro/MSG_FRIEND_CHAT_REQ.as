package com.gamehero.sxd2.pro {
	import com.netease.protobuf.*;
	use namespace com.netease.protobuf.used_by_generated_code;
	import com.netease.protobuf.fieldDescriptors.*;
	import flash.utils.Endian;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.errors.IOError;
	import com.gamehero.sxd2.pro.PRO_ChatContents;
	// @@protoc_insertion_point(imports)

	// @@protoc_insertion_point(class_metadata)
	public final class MSG_FRIEND_CHAT_REQ extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const CONTENTS:FieldDescriptor$TYPE_MESSAGE = new FieldDescriptor$TYPE_MESSAGE("com.gamehero.sxd2.pro.MSG_FRIEND_CHAT_REQ.contents", "contents", (1 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return com.gamehero.sxd2.pro.PRO_ChatContents; });

		private var contents$field:com.gamehero.sxd2.pro.PRO_ChatContents;

		public function clearContents():void {
			contents$field = null;
		}

		public function get hasContents():Boolean {
			return contents$field != null;
		}

		public function set contents(value:com.gamehero.sxd2.pro.PRO_ChatContents):void {
			contents$field = value;
		}

		public function get contents():com.gamehero.sxd2.pro.PRO_ChatContents {
			return contents$field;
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			if (hasContents) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 1);
				com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, contents$field);
			}
			for (var fieldKey:* in this) {
				super.writeUnknown(output, fieldKey);
			}
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function readFromSlice(input:flash.utils.IDataInput, bytesAfterSlice:uint):void {
			var contents$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					if (contents$count != 0) {
						throw new flash.errors.IOError('Bad data format: MSG_FRIEND_CHAT_REQ.contents cannot be set twice.');
					}
					++contents$count;
					this.contents = new com.gamehero.sxd2.pro.PRO_ChatContents();
					com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, this.contents);
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
