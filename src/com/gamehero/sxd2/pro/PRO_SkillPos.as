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
	public final class PRO_SkillPos extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const SKILL_ID:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.PRO_SkillPos.skill_id", "skillId", (1 << 3) | com.netease.protobuf.WireType.VARINT);

		private var skill_id$field:uint;

		private var hasField$0:uint = 0;

		public function clearSkillId():void {
			hasField$0 &= 0xfffffffe;
			skill_id$field = new uint();
		}

		public function get hasSkillId():Boolean {
			return (hasField$0 & 0x1) != 0;
		}

		public function set skillId(value:uint):void {
			hasField$0 |= 0x1;
			skill_id$field = value;
		}

		public function get skillId():uint {
			return skill_id$field;
		}

		/**
		 *  @private
		 */
		public static const POS:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.PRO_SkillPos.pos", "pos", (2 << 3) | com.netease.protobuf.WireType.VARINT);

		private var pos$field:uint;

		public function clearPos():void {
			hasField$0 &= 0xfffffffd;
			pos$field = new uint();
		}

		public function get hasPos():Boolean {
			return (hasField$0 & 0x2) != 0;
		}

		public function set pos(value:uint):void {
			hasField$0 |= 0x2;
			pos$field = value;
		}

		public function get pos():uint {
			return pos$field;
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			if (hasSkillId) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 1);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, skill_id$field);
			}
			if (hasPos) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 2);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, pos$field);
			}
			for (var fieldKey:* in this) {
				super.writeUnknown(output, fieldKey);
			}
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function readFromSlice(input:flash.utils.IDataInput, bytesAfterSlice:uint):void {
			var skill_id$count:uint = 0;
			var pos$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					if (skill_id$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_SkillPos.skillId cannot be set twice.');
					}
					++skill_id$count;
					this.skillId = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 2:
					if (pos$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_SkillPos.pos cannot be set twice.');
					}
					++pos$count;
					this.pos = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
