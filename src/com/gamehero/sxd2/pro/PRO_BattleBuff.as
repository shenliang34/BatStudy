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
	public final class PRO_BattleBuff extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const BUFFID:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.gamehero.sxd2.pro.PRO_BattleBuff.buffId", "buffId", (1 << 3) | com.netease.protobuf.WireType.VARINT);

		private var buffId$field:int;

		private var hasField$0:uint = 0;

		public function clearBuffId():void {
			hasField$0 &= 0xfffffffe;
			buffId$field = new int();
		}

		public function get hasBuffId():Boolean {
			return (hasField$0 & 0x1) != 0;
		}

		public function set buffId(value:int):void {
			hasField$0 |= 0x1;
			buffId$field = value;
		}

		public function get buffId():int {
			return buffId$field;
		}

		/**
		 *  @private
		 */
		public static const NUM:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.gamehero.sxd2.pro.PRO_BattleBuff.num", "num", (2 << 3) | com.netease.protobuf.WireType.VARINT);

		private var num$field:int;

		public function clearNum():void {
			hasField$0 &= 0xfffffffd;
			num$field = new int();
		}

		public function get hasNum():Boolean {
			return (hasField$0 & 0x2) != 0;
		}

		public function set num(value:int):void {
			hasField$0 |= 0x2;
			num$field = value;
		}

		public function get num():int {
			return num$field;
		}

		/**
		 *  @private
		 */
		public static const EXPIRE:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.gamehero.sxd2.pro.PRO_BattleBuff.expire", "expire", (3 << 3) | com.netease.protobuf.WireType.VARINT);

		private var expire$field:int;

		public function clearExpire():void {
			hasField$0 &= 0xfffffffb;
			expire$field = new int();
		}

		public function get hasExpire():Boolean {
			return (hasField$0 & 0x4) != 0;
		}

		public function set expire(value:int):void {
			hasField$0 |= 0x4;
			expire$field = value;
		}

		public function get expire():int {
			return expire$field;
		}

		/**
		 *  @private
		 */
		public static const TRIGGERTIME:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.gamehero.sxd2.pro.PRO_BattleBuff.triggerTime", "triggerTime", (4 << 3) | com.netease.protobuf.WireType.VARINT);

		private var triggerTime$field:int;

		public function clearTriggerTime():void {
			hasField$0 &= 0xfffffff7;
			triggerTime$field = new int();
		}

		public function get hasTriggerTime():Boolean {
			return (hasField$0 & 0x8) != 0;
		}

		public function set triggerTime(value:int):void {
			hasField$0 |= 0x8;
			triggerTime$field = value;
		}

		public function get triggerTime():int {
			return triggerTime$field;
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			if (hasBuffId) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 1);
				com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, buffId$field);
			}
			if (hasNum) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 2);
				com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, num$field);
			}
			if (hasExpire) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 3);
				com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, expire$field);
			}
			if (hasTriggerTime) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 4);
				com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, triggerTime$field);
			}
			for (var fieldKey:* in this) {
				super.writeUnknown(output, fieldKey);
			}
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function readFromSlice(input:flash.utils.IDataInput, bytesAfterSlice:uint):void {
			var buffId$count:uint = 0;
			var num$count:uint = 0;
			var expire$count:uint = 0;
			var triggerTime$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					if (buffId$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_BattleBuff.buffId cannot be set twice.');
					}
					++buffId$count;
					this.buffId = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 2:
					if (num$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_BattleBuff.num cannot be set twice.');
					}
					++num$count;
					this.num = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 3:
					if (expire$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_BattleBuff.expire cannot be set twice.');
					}
					++expire$count;
					this.expire = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 4:
					if (triggerTime$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_BattleBuff.triggerTime cannot be set twice.');
					}
					++triggerTime$count;
					this.triggerTime = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
