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
	public final class MSG_SKILL_SET_REQ extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const GROUPID:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.MSG_SKILL_SET_REQ.groupId", "groupId", (1 << 3) | com.netease.protobuf.WireType.VARINT);

		private var groupId$field:uint;

		private var hasField$0:uint = 0;

		public function clearGroupId():void {
			hasField$0 &= 0xfffffffe;
			groupId$field = new uint();
		}

		public function get hasGroupId():Boolean {
			return (hasField$0 & 0x1) != 0;
		}

		public function set groupId(value:uint):void {
			hasField$0 |= 0x1;
			groupId$field = value;
		}

		public function get groupId():uint {
			return groupId$field;
		}

		/**
		 *  @private
		 */
		public static const POS:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.MSG_SKILL_SET_REQ.pos", "pos", (2 << 3) | com.netease.protobuf.WireType.VARINT);

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
			if (hasGroupId) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 1);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, groupId$field);
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
			var groupId$count:uint = 0;
			var pos$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					if (groupId$count != 0) {
						throw new flash.errors.IOError('Bad data format: MSG_SKILL_SET_REQ.groupId cannot be set twice.');
					}
					++groupId$count;
					this.groupId = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 2:
					if (pos$count != 0) {
						throw new flash.errors.IOError('Bad data format: MSG_SKILL_SET_REQ.pos cannot be set twice.');
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
