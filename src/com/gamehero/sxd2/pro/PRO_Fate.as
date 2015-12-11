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
	public final class PRO_Fate extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const ID:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.PRO_Fate.id", "id", (1 << 3) | com.netease.protobuf.WireType.VARINT);

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
		public static const CURRENT:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.PRO_Fate.current", "current", (2 << 3) | com.netease.protobuf.WireType.VARINT);

		private var current$field:uint;

		public function clearCurrent():void {
			hasField$0 &= 0xfffffffd;
			current$field = new uint();
		}

		public function get hasCurrent():Boolean {
			return (hasField$0 & 0x2) != 0;
		}

		public function set current(value:uint):void {
			hasField$0 |= 0x2;
			current$field = value;
		}

		public function get current():uint {
			return current$field;
		}

		/**
		 *  @private
		 */
		public static const LAST:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.PRO_Fate.last", "last", (3 << 3) | com.netease.protobuf.WireType.VARINT);

		private var last$field:uint;

		public function clearLast():void {
			hasField$0 &= 0xfffffffb;
			last$field = new uint();
		}

		public function get hasLast():Boolean {
			return (hasField$0 & 0x4) != 0;
		}

		public function set last(value:uint):void {
			hasField$0 |= 0x4;
			last$field = value;
		}

		public function get last():uint {
			return last$field;
		}

		/**
		 *  @private
		 */
		public static const IS_DISCOUNT:FieldDescriptor$TYPE_BOOL = new FieldDescriptor$TYPE_BOOL("com.gamehero.sxd2.pro.PRO_Fate.is_discount", "isDiscount", (4 << 3) | com.netease.protobuf.WireType.VARINT);

		private var is_discount$field:Boolean;

		public function clearIsDiscount():void {
			hasField$0 &= 0xfffffff7;
			is_discount$field = new Boolean();
		}

		public function get hasIsDiscount():Boolean {
			return (hasField$0 & 0x8) != 0;
		}

		public function set isDiscount(value:Boolean):void {
			hasField$0 |= 0x8;
			is_discount$field = value;
		}

		public function get isDiscount():Boolean {
			return is_discount$field;
		}

		/**
		 *  @private
		 */
		public static const COST:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.PRO_Fate.cost", "cost", (5 << 3) | com.netease.protobuf.WireType.VARINT);

		private var cost$field:uint;

		public function clearCost():void {
			hasField$0 &= 0xffffffef;
			cost$field = new uint();
		}

		public function get hasCost():Boolean {
			return (hasField$0 & 0x10) != 0;
		}

		public function set cost(value:uint):void {
			hasField$0 |= 0x10;
			cost$field = value;
		}

		public function get cost():uint {
			return cost$field;
		}

		/**
		 *  @private
		 */
		public static const SOUL:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.PRO_Fate.soul", "soul", (6 << 3) | com.netease.protobuf.WireType.VARINT);

		private var soul$field:uint;

		public function clearSoul():void {
			hasField$0 &= 0xffffffdf;
			soul$field = new uint();
		}

		public function get hasSoul():Boolean {
			return (hasField$0 & 0x20) != 0;
		}

		public function set soul(value:uint):void {
			hasField$0 |= 0x20;
			soul$field = value;
		}

		public function get soul():uint {
			return soul$field;
		}

		/**
		 *  @private
		 */
		public static const ROLL_TIMES:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.PRO_Fate.roll_times", "rollTimes", (7 << 3) | com.netease.protobuf.WireType.VARINT);

		private var roll_times$field:uint;

		public function clearRollTimes():void {
			hasField$0 &= 0xffffffbf;
			roll_times$field = new uint();
		}

		public function get hasRollTimes():Boolean {
			return (hasField$0 & 0x40) != 0;
		}

		public function set rollTimes(value:uint):void {
			hasField$0 |= 0x40;
			roll_times$field = value;
		}

		public function get rollTimes():uint {
			return roll_times$field;
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			if (hasId) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 1);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, id$field);
			}
			if (hasCurrent) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 2);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, current$field);
			}
			if (hasLast) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 3);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, last$field);
			}
			if (hasIsDiscount) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 4);
				com.netease.protobuf.WriteUtils.write$TYPE_BOOL(output, is_discount$field);
			}
			if (hasCost) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 5);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, cost$field);
			}
			if (hasSoul) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 6);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, soul$field);
			}
			if (hasRollTimes) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 7);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, roll_times$field);
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
			var current$count:uint = 0;
			var last$count:uint = 0;
			var is_discount$count:uint = 0;
			var cost$count:uint = 0;
			var soul$count:uint = 0;
			var roll_times$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					if (id$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_Fate.id cannot be set twice.');
					}
					++id$count;
					this.id = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 2:
					if (current$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_Fate.current cannot be set twice.');
					}
					++current$count;
					this.current = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 3:
					if (last$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_Fate.last cannot be set twice.');
					}
					++last$count;
					this.last = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 4:
					if (is_discount$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_Fate.isDiscount cannot be set twice.');
					}
					++is_discount$count;
					this.isDiscount = com.netease.protobuf.ReadUtils.read$TYPE_BOOL(input);
					break;
				case 5:
					if (cost$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_Fate.cost cannot be set twice.');
					}
					++cost$count;
					this.cost = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 6:
					if (soul$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_Fate.soul cannot be set twice.');
					}
					++soul$count;
					this.soul = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 7:
					if (roll_times$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_Fate.rollTimes cannot be set twice.');
					}
					++roll_times$count;
					this.rollTimes = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
