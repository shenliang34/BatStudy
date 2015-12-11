package com.gamehero.sxd2.pro {
	import com.netease.protobuf.*;
	use namespace com.netease.protobuf.used_by_generated_code;
	import com.netease.protobuf.fieldDescriptors.*;
	import flash.utils.Endian;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.errors.IOError;
	import com.gamehero.sxd2.pro.PRO_Skill;
	// @@protoc_insertion_point(imports)

	// @@protoc_insertion_point(class_metadata)
	public final class MSG_UPDATE_SKILL_ACK extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const SKILL:FieldDescriptor$TYPE_MESSAGE = new FieldDescriptor$TYPE_MESSAGE("com.gamehero.sxd2.pro.MSG_UPDATE_SKILL_ACK.skill", "skill", (1 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return com.gamehero.sxd2.pro.PRO_Skill; });

		private var skill$field:com.gamehero.sxd2.pro.PRO_Skill;

		public function clearSkill():void {
			skill$field = null;
		}

		public function get hasSkill():Boolean {
			return skill$field != null;
		}

		public function set skill(value:com.gamehero.sxd2.pro.PRO_Skill):void {
			skill$field = value;
		}

		public function get skill():com.gamehero.sxd2.pro.PRO_Skill {
			return skill$field;
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			if (hasSkill) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 1);
				com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, skill$field);
			}
			for (var fieldKey:* in this) {
				super.writeUnknown(output, fieldKey);
			}
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function readFromSlice(input:flash.utils.IDataInput, bytesAfterSlice:uint):void {
			var skill$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					if (skill$count != 0) {
						throw new flash.errors.IOError('Bad data format: MSG_UPDATE_SKILL_ACK.skill cannot be set twice.');
					}
					++skill$count;
					this.skill = new com.gamehero.sxd2.pro.PRO_Skill();
					com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, this.skill);
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
