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
	public final class MSG_PHOTOAPPRAISAL_RWD_REQ extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const RACE:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.MSG_PHOTOAPPRAISAL_RWD_REQ.race", "race", (1 << 3) | com.netease.protobuf.WireType.VARINT);

		private var race$field:uint;

		private var hasField$0:uint = 0;

		public function clearRace():void {
			hasField$0 &= 0xfffffffe;
			race$field = new uint();
		}

		public function get hasRace():Boolean {
			return (hasField$0 & 0x1) != 0;
		}

		public function set race(value:uint):void {
			hasField$0 |= 0x1;
			race$field = value;
		}

		public function get race():uint {
			return race$field;
		}

		/**
		 *  @private
		 */
		public static const NUM:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.MSG_PHOTOAPPRAISAL_RWD_REQ.num", "num", (2 << 3) | com.netease.protobuf.WireType.VARINT);

		private var num$field:uint;

		public function clearNum():void {
			hasField$0 &= 0xfffffffd;
			num$field = new uint();
		}

		public function get hasNum():Boolean {
			return (hasField$0 & 0x2) != 0;
		}

		public function set num(value:uint):void {
			hasField$0 |= 0x2;
			num$field = value;
		}

		public function get num():uint {
			return num$field;
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			if (hasRace) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 1);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, race$field);
			}
			if (hasNum) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 2);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, num$field);
			}
			for (var fieldKey:* in this) {
				super.writeUnknown(output, fieldKey);
			}
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function readFromSlice(input:flash.utils.IDataInput, bytesAfterSlice:uint):void {
			var race$count:uint = 0;
			var num$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					if (race$count != 0) {
						throw new flash.errors.IOError('Bad data format: MSG_PHOTOAPPRAISAL_RWD_REQ.race cannot be set twice.');
					}
					++race$count;
					this.race = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 2:
					if (num$count != 0) {
						throw new flash.errors.IOError('Bad data format: MSG_PHOTOAPPRAISAL_RWD_REQ.num cannot be set twice.');
					}
					++num$count;
					this.num = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
