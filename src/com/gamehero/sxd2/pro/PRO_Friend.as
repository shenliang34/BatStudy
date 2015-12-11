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
	public final class PRO_Friend extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const BASE:FieldDescriptor$TYPE_MESSAGE = new FieldDescriptor$TYPE_MESSAGE("com.gamehero.sxd2.pro.PRO_Friend.base", "base", (1 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return com.gamehero.sxd2.pro.PRO_PlayerBase; });

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
		public static const IS_ONLINE:FieldDescriptor$TYPE_BOOL = new FieldDescriptor$TYPE_BOOL("com.gamehero.sxd2.pro.PRO_Friend.is_online", "isOnline", (2 << 3) | com.netease.protobuf.WireType.VARINT);

		private var is_online$field:Boolean;

		private var hasField$0:uint = 0;

		public function clearIsOnline():void {
			hasField$0 &= 0xfffffffe;
			is_online$field = new Boolean();
		}

		public function get hasIsOnline():Boolean {
			return (hasField$0 & 0x1) != 0;
		}

		public function set isOnline(value:Boolean):void {
			hasField$0 |= 0x1;
			is_online$field = value;
		}

		public function get isOnline():Boolean {
			return is_online$field;
		}

		/**
		 *  @private
		 */
		public static const IS_FRIEND:FieldDescriptor$TYPE_BOOL = new FieldDescriptor$TYPE_BOOL("com.gamehero.sxd2.pro.PRO_Friend.is_friend", "isFriend", (3 << 3) | com.netease.protobuf.WireType.VARINT);

		private var is_friend$field:Boolean;

		public function clearIsFriend():void {
			hasField$0 &= 0xfffffffd;
			is_friend$field = new Boolean();
		}

		public function get hasIsFriend():Boolean {
			return (hasField$0 & 0x2) != 0;
		}

		public function set isFriend(value:Boolean):void {
			hasField$0 |= 0x2;
			is_friend$field = value;
		}

		public function get isFriend():Boolean {
			return is_friend$field;
		}

		/**
		 *  @private
		 */
		public static const IS_ATTENTION:FieldDescriptor$TYPE_BOOL = new FieldDescriptor$TYPE_BOOL("com.gamehero.sxd2.pro.PRO_Friend.is_attention", "isAttention", (4 << 3) | com.netease.protobuf.WireType.VARINT);

		private var is_attention$field:Boolean;

		public function clearIsAttention():void {
			hasField$0 &= 0xfffffffb;
			is_attention$field = new Boolean();
		}

		public function get hasIsAttention():Boolean {
			return (hasField$0 & 0x4) != 0;
		}

		public function set isAttention(value:Boolean):void {
			hasField$0 |= 0x4;
			is_attention$field = value;
		}

		public function get isAttention():Boolean {
			return is_attention$field;
		}

		/**
		 *  @private
		 */
		public static const IS_BLACK:FieldDescriptor$TYPE_BOOL = new FieldDescriptor$TYPE_BOOL("com.gamehero.sxd2.pro.PRO_Friend.is_black", "isBlack", (5 << 3) | com.netease.protobuf.WireType.VARINT);

		private var is_black$field:Boolean;

		public function clearIsBlack():void {
			hasField$0 &= 0xfffffff7;
			is_black$field = new Boolean();
		}

		public function get hasIsBlack():Boolean {
			return (hasField$0 & 0x8) != 0;
		}

		public function set isBlack(value:Boolean):void {
			hasField$0 |= 0x8;
			is_black$field = value;
		}

		public function get isBlack():Boolean {
			return is_black$field;
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			if (hasBase) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 1);
				com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, base$field);
			}
			if (hasIsOnline) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 2);
				com.netease.protobuf.WriteUtils.write$TYPE_BOOL(output, is_online$field);
			}
			if (hasIsFriend) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 3);
				com.netease.protobuf.WriteUtils.write$TYPE_BOOL(output, is_friend$field);
			}
			if (hasIsAttention) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 4);
				com.netease.protobuf.WriteUtils.write$TYPE_BOOL(output, is_attention$field);
			}
			if (hasIsBlack) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 5);
				com.netease.protobuf.WriteUtils.write$TYPE_BOOL(output, is_black$field);
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
			var is_online$count:uint = 0;
			var is_friend$count:uint = 0;
			var is_attention$count:uint = 0;
			var is_black$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					if (base$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_Friend.base cannot be set twice.');
					}
					++base$count;
					this.base = new com.gamehero.sxd2.pro.PRO_PlayerBase();
					com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, this.base);
					break;
				case 2:
					if (is_online$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_Friend.isOnline cannot be set twice.');
					}
					++is_online$count;
					this.isOnline = com.netease.protobuf.ReadUtils.read$TYPE_BOOL(input);
					break;
				case 3:
					if (is_friend$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_Friend.isFriend cannot be set twice.');
					}
					++is_friend$count;
					this.isFriend = com.netease.protobuf.ReadUtils.read$TYPE_BOOL(input);
					break;
				case 4:
					if (is_attention$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_Friend.isAttention cannot be set twice.');
					}
					++is_attention$count;
					this.isAttention = com.netease.protobuf.ReadUtils.read$TYPE_BOOL(input);
					break;
				case 5:
					if (is_black$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_Friend.isBlack cannot be set twice.');
					}
					++is_black$count;
					this.isBlack = com.netease.protobuf.ReadUtils.read$TYPE_BOOL(input);
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
