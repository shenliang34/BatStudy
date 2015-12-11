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
	public final class PRO_SkillSlot extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const SLOT_ID:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.PRO_SkillSlot.slot_id", "slotId", (1 << 3) | com.netease.protobuf.WireType.VARINT);

		private var slot_id$field:uint;

		private var hasField$0:uint = 0;

		public function clearSlotId():void {
			hasField$0 &= 0xfffffffe;
			slot_id$field = new uint();
		}

		public function get hasSlotId():Boolean {
			return (hasField$0 & 0x1) != 0;
		}

		public function set slotId(value:uint):void {
			hasField$0 |= 0x1;
			slot_id$field = value;
		}

		public function get slotId():uint {
			return slot_id$field;
		}

		/**
		 *  @private
		 */
		public static const IS_OPEN:FieldDescriptor$TYPE_BOOL = new FieldDescriptor$TYPE_BOOL("com.gamehero.sxd2.pro.PRO_SkillSlot.is_open", "isOpen", (2 << 3) | com.netease.protobuf.WireType.VARINT);

		private var is_open$field:Boolean;

		public function clearIsOpen():void {
			hasField$0 &= 0xfffffffd;
			is_open$field = new Boolean();
		}

		public function get hasIsOpen():Boolean {
			return (hasField$0 & 0x2) != 0;
		}

		public function set isOpen(value:Boolean):void {
			hasField$0 |= 0x2;
			is_open$field = value;
		}

		public function get isOpen():Boolean {
			return is_open$field;
		}

		/**
		 *  @private
		 */
		public static const GROUPID:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.PRO_SkillSlot.groupId", "groupId", (3 << 3) | com.netease.protobuf.WireType.VARINT);

		private var groupId$field:uint;

		public function clearGroupId():void {
			hasField$0 &= 0xfffffffb;
			groupId$field = new uint();
		}

		public function get hasGroupId():Boolean {
			return (hasField$0 & 0x4) != 0;
		}

		public function set groupId(value:uint):void {
			hasField$0 |= 0x4;
			groupId$field = value;
		}

		public function get groupId():uint {
			return groupId$field;
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			if (hasSlotId) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 1);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, slot_id$field);
			}
			if (hasIsOpen) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 2);
				com.netease.protobuf.WriteUtils.write$TYPE_BOOL(output, is_open$field);
			}
			if (hasGroupId) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 3);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, groupId$field);
			}
			for (var fieldKey:* in this) {
				super.writeUnknown(output, fieldKey);
			}
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function readFromSlice(input:flash.utils.IDataInput, bytesAfterSlice:uint):void {
			var slot_id$count:uint = 0;
			var is_open$count:uint = 0;
			var groupId$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					if (slot_id$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_SkillSlot.slotId cannot be set twice.');
					}
					++slot_id$count;
					this.slotId = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 2:
					if (is_open$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_SkillSlot.isOpen cannot be set twice.');
					}
					++is_open$count;
					this.isOpen = com.netease.protobuf.ReadUtils.read$TYPE_BOOL(input);
					break;
				case 3:
					if (groupId$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_SkillSlot.groupId cannot be set twice.');
					}
					++groupId$count;
					this.groupId = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
