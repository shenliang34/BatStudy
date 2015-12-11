package com.gamehero.sxd2.pro {
	import com.netease.protobuf.*;
	use namespace com.netease.protobuf.used_by_generated_code;
	import com.netease.protobuf.fieldDescriptors.*;
	import flash.utils.Endian;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.errors.IOError;
	import com.gamehero.sxd2.pro.PRO_PlayerBase;
	// @@protoc_insertion_point(imports)

	// @@protoc_insertion_point(class_metadata)
	public final class PRO_ChatContents extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const BASE:FieldDescriptor$TYPE_MESSAGE = new FieldDescriptor$TYPE_MESSAGE("com.gamehero.sxd2.pro.PRO_ChatContents.base", "base", (1 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return com.gamehero.sxd2.pro.PRO_PlayerBase; });

		private var base$field:com.gamehero.sxd2.pro.PRO_PlayerBase;

		public function clearBase():void {
			base$field = null;
		}

		public function get hasBase():Boolean {
			return base$field != null;
		}

		public function set base(value:com.gamehero.sxd2.pro.PRO_PlayerBase):void {
			base$field = value;
		}

		public function get base():com.gamehero.sxd2.pro.PRO_PlayerBase {
			return base$field;
		}

		/**
		 *  @private
		 */
		public static const MESSAGE:FieldDescriptor$TYPE_STRING = new FieldDescriptor$TYPE_STRING("com.gamehero.sxd2.pro.PRO_ChatContents.message", "message", (2 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED);

		private var message$field:String;

		public function clearMessage():void {
			message$field = null;
		}

		public function get hasMessage():Boolean {
			return message$field != null;
		}

		public function set message(value:String):void {
			message$field = value;
		}

		public function get message():String {
			return message$field;
		}

		/**
		 *  @private
		 */
		public static const TIME:FieldDescriptor$TYPE_UINT64 = new FieldDescriptor$TYPE_UINT64("com.gamehero.sxd2.pro.PRO_ChatContents.time", "time", (3 << 3) | com.netease.protobuf.WireType.VARINT);

		private var time$field:UInt64;

		public function clearTime():void {
			time$field = null;
		}

		public function get hasTime():Boolean {
			return time$field != null;
		}

		public function set time(value:UInt64):void {
			time$field = value;
		}

		public function get time():UInt64 {
			return time$field;
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			if (hasBase) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 1);
				com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, base$field);
			}
			if (hasMessage) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 2);
				com.netease.protobuf.WriteUtils.write$TYPE_STRING(output, message$field);
			}
			if (hasTime) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 3);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT64(output, time$field);
			}
			for (var fieldKey:* in this) {
				super.writeUnknown(output, fieldKey);
			}
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function readFromSlice(input:flash.utils.IDataInput, bytesAfterSlice:uint):void {
			var base$count:uint = 0;
			var message$count:uint = 0;
			var time$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					if (base$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_ChatContents.base cannot be set twice.');
					}
					++base$count;
					this.base = new com.gamehero.sxd2.pro.PRO_PlayerBase();
					com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, this.base);
					break;
				case 2:
					if (message$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_ChatContents.message cannot be set twice.');
					}
					++message$count;
					this.message = com.netease.protobuf.ReadUtils.read$TYPE_STRING(input);
					break;
				case 3:
					if (time$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_ChatContents.time cannot be set twice.');
					}
					++time$count;
					this.time = com.netease.protobuf.ReadUtils.read$TYPE_UINT64(input);
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
