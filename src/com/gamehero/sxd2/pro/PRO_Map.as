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
	public final class PRO_Map extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const ID:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.PRO_Map.id", "id", (1 << 3) | com.netease.protobuf.WireType.VARINT);

		private var id$field:uint;

		private var hasField$0:uint = 0;

		public function clearId():void {
			hasField$0 &= 0xfffffffe;
			id$field = new uint();
		}

		public function get hasId():Boolean {
			return (hasField$0 & 0x1) != 0;
		}

		public function set id(value:uint):void {
			hasField$0 |= 0x1;
			id$field = value;
		}

		public function get id():uint {
			return id$field;
		}

		/**
		 *  @private
		 */
		public static const X:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.PRO_Map.x", "x", (2 << 3) | com.netease.protobuf.WireType.VARINT);

		private var x$field:uint;

		public function clearX():void {
			hasField$0 &= 0xfffffffd;
			x$field = new uint();
		}

		public function get hasX():Boolean {
			return (hasField$0 & 0x2) != 0;
		}

		public function set x(value:uint):void {
			hasField$0 |= 0x2;
			x$field = value;
		}

		public function get x():uint {
			return x$field;
		}

		/**
		 *  @private
		 */
		public static const Y:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.PRO_Map.y", "y", (3 << 3) | com.netease.protobuf.WireType.VARINT);

		private var y$field:uint;

		public function clearY():void {
			hasField$0 &= 0xfffffffb;
			y$field = new uint();
		}

		public function get hasY():Boolean {
			return (hasField$0 & 0x4) != 0;
		}

		public function set y(value:uint):void {
			hasField$0 |= 0x4;
			y$field = value;
		}

		public function get y():uint {
			return y$field;
		}

		/**
		 *  @private
		 */
		public static const IS_ENTER:FieldDescriptor$TYPE_BOOL = new FieldDescriptor$TYPE_BOOL("com.gamehero.sxd2.pro.PRO_Map.is_enter", "isEnter", (4 << 3) | com.netease.protobuf.WireType.VARINT);

		private var is_enter$field:Boolean;

		public function clearIsEnter():void {
			hasField$0 &= 0xfffffff7;
			is_enter$field = new Boolean();
		}

		public function get hasIsEnter():Boolean {
			return (hasField$0 & 0x8) != 0;
		}

		public function set isEnter(value:Boolean):void {
			hasField$0 |= 0x8;
			is_enter$field = value;
		}

		public function get isEnter():Boolean {
			return is_enter$field;
		}

		/**
		 *  @private
		 */
		public static const IS_LEAVE:FieldDescriptor$TYPE_BOOL = new FieldDescriptor$TYPE_BOOL("com.gamehero.sxd2.pro.PRO_Map.is_leave", "isLeave", (5 << 3) | com.netease.protobuf.WireType.VARINT);

		private var is_leave$field:Boolean;

		public function clearIsLeave():void {
			hasField$0 &= 0xffffffef;
			is_leave$field = new Boolean();
		}

		public function get hasIsLeave():Boolean {
			return (hasField$0 & 0x10) != 0;
		}

		public function set isLeave(value:Boolean):void {
			hasField$0 |= 0x10;
			is_leave$field = value;
		}

		public function get isLeave():Boolean {
			return is_leave$field;
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			if (hasId) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 1);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, id$field);
			}
			if (hasX) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 2);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, x$field);
			}
			if (hasY) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 3);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, y$field);
			}
			if (hasIsEnter) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 4);
				com.netease.protobuf.WriteUtils.write$TYPE_BOOL(output, is_enter$field);
			}
			if (hasIsLeave) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 5);
				com.netease.protobuf.WriteUtils.write$TYPE_BOOL(output, is_leave$field);
			}
			for (var fieldKey:* in this) {
				super.writeUnknown(output, fieldKey);
			}
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function readFromSlice(input:flash.utils.IDataInput, bytesAfterSlice:uint):void {
			var id$count:uint = 0;
			var x$count:uint = 0;
			var y$count:uint = 0;
			var is_enter$count:uint = 0;
			var is_leave$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					if (id$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_Map.id cannot be set twice.');
					}
					++id$count;
					this.id = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 2:
					if (x$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_Map.x cannot be set twice.');
					}
					++x$count;
					this.x = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 3:
					if (y$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_Map.y cannot be set twice.');
					}
					++y$count;
					this.y = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 4:
					if (is_enter$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_Map.isEnter cannot be set twice.');
					}
					++is_enter$count;
					this.isEnter = com.netease.protobuf.ReadUtils.read$TYPE_BOOL(input);
					break;
				case 5:
					if (is_leave$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_Map.isLeave cannot be set twice.');
					}
					++is_leave$count;
					this.isLeave = com.netease.protobuf.ReadUtils.read$TYPE_BOOL(input);
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
