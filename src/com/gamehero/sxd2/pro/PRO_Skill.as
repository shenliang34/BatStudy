package com.gamehero.sxd2.pro {
	import com.netease.protobuf.*;
	use namespace com.netease.protobuf.used_by_generated_code;
	import com.netease.protobuf.fieldDescriptors.*;
	import flash.utils.Endian;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.errors.IOError;
	import com.gamehero.sxd2.pro.PRO_SkillPos;
	import com.gamehero.sxd2.pro.PRO_SkillSlot;
	// @@protoc_insertion_point(imports)

	// @@protoc_insertion_point(class_metadata)
	public final class PRO_Skill extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const SKILLS:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("com.gamehero.sxd2.pro.PRO_Skill.skills", "skills", (1 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return com.gamehero.sxd2.pro.PRO_SkillPos; });

		[ArrayElementType("com.gamehero.sxd2.pro.PRO_SkillPos")]
		public var skills:Array = [];

		/**
		 *  @private
		 */
		public static const SLOTS:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("com.gamehero.sxd2.pro.PRO_Skill.slots", "slots", (2 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return com.gamehero.sxd2.pro.PRO_SkillSlot; });

		[ArrayElementType("com.gamehero.sxd2.pro.PRO_SkillSlot")]
		public var slots:Array = [];

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			for (var skills$index:uint = 0; skills$index < this.skills.length; ++skills$index) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 1);
				com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, this.skills[skills$index]);
			}
			for (var slots$index:uint = 0; slots$index < this.slots.length; ++slots$index) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 2);
				com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, this.slots[slots$index]);
			}
			for (var fieldKey:* in this) {
				super.writeUnknown(output, fieldKey);
			}
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function readFromSlice(input:flash.utils.IDataInput, bytesAfterSlice:uint):void {
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					this.skills.push(com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, new com.gamehero.sxd2.pro.PRO_SkillPos()));
					break;
				case 2:
					this.slots.push(com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, new com.gamehero.sxd2.pro.PRO_SkillSlot()));
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
