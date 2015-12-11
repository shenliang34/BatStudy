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
	public final class PRO_PlayerExtra extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const EXP:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.PRO_PlayerExtra.exp", "exp", (1 << 3) | com.netease.protobuf.WireType.VARINT);

		private var exp$field:uint;

		private var hasField$0:uint = 0;

		public function clearExp():void {
			hasField$0 &= 0xfffffffe;
			exp$field = new uint();
		}

		public function get hasExp():Boolean {
			return (hasField$0 & 0x1) != 0;
		}

		public function set exp(value:uint):void {
			hasField$0 |= 0x1;
			exp$field = value;
		}

		public function get exp():uint {
			return exp$field;
		}

		/**
		 *  @private
		 */
		public static const STAMINA:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.PRO_PlayerExtra.stamina", "stamina", (2 << 3) | com.netease.protobuf.WireType.VARINT);

		private var stamina$field:uint;

		public function clearStamina():void {
			hasField$0 &= 0xfffffffd;
			stamina$field = new uint();
		}

		public function get hasStamina():Boolean {
			return (hasField$0 & 0x2) != 0;
		}

		public function set stamina(value:uint):void {
			hasField$0 |= 0x2;
			stamina$field = value;
		}

		public function get stamina():uint {
			return stamina$field;
		}

		/**
		 *  @private
		 */
		public static const VIP:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.PRO_PlayerExtra.vip", "vip", (3 << 3) | com.netease.protobuf.WireType.VARINT);

		private var vip$field:uint;

		public function clearVip():void {
			hasField$0 &= 0xfffffffb;
			vip$field = new uint();
		}

		public function get hasVip():Boolean {
			return (hasField$0 & 0x4) != 0;
		}

		public function set vip(value:uint):void {
			hasField$0 |= 0x4;
			vip$field = value;
		}

		public function get vip():uint {
			return vip$field;
		}

		/**
		 *  @private
		 */
		public static const COIN:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.PRO_PlayerExtra.coin", "coin", (4 << 3) | com.netease.protobuf.WireType.VARINT);

		private var coin$field:uint;

		public function clearCoin():void {
			hasField$0 &= 0xfffffff7;
			coin$field = new uint();
		}

		public function get hasCoin():Boolean {
			return (hasField$0 & 0x8) != 0;
		}

		public function set coin(value:uint):void {
			hasField$0 |= 0x8;
			coin$field = value;
		}

		public function get coin():uint {
			return coin$field;
		}

		/**
		 *  @private
		 */
		public static const GOLD:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.PRO_PlayerExtra.gold", "gold", (5 << 3) | com.netease.protobuf.WireType.VARINT);

		private var gold$field:uint;

		public function clearGold():void {
			hasField$0 &= 0xffffffef;
			gold$field = new uint();
		}

		public function get hasGold():Boolean {
			return (hasField$0 & 0x10) != 0;
		}

		public function set gold(value:uint):void {
			hasField$0 |= 0x10;
			gold$field = value;
		}

		public function get gold():uint {
			return gold$field;
		}

		/**
		 *  @private
		 */
		public static const SPIRIT:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.PRO_PlayerExtra.spirit", "spirit", (6 << 3) | com.netease.protobuf.WireType.VARINT);

		private var spirit$field:uint;

		public function clearSpirit():void {
			hasField$0 &= 0xffffffdf;
			spirit$field = new uint();
		}

		public function get hasSpirit():Boolean {
			return (hasField$0 & 0x20) != 0;
		}

		public function set spirit(value:uint):void {
			hasField$0 |= 0x20;
			spirit$field = value;
		}

		public function get spirit():uint {
			return spirit$field;
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			if (hasExp) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 1);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, exp$field);
			}
			if (hasStamina) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 2);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, stamina$field);
			}
			if (hasVip) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 3);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, vip$field);
			}
			if (hasCoin) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 4);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, coin$field);
			}
			if (hasGold) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 5);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, gold$field);
			}
			if (hasSpirit) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 6);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, spirit$field);
			}
			for (var fieldKey:* in this) {
				super.writeUnknown(output, fieldKey);
			}
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function readFromSlice(input:flash.utils.IDataInput, bytesAfterSlice:uint):void {
			var exp$count:uint = 0;
			var stamina$count:uint = 0;
			var vip$count:uint = 0;
			var coin$count:uint = 0;
			var gold$count:uint = 0;
			var spirit$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					if (exp$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_PlayerExtra.exp cannot be set twice.');
					}
					++exp$count;
					this.exp = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 2:
					if (stamina$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_PlayerExtra.stamina cannot be set twice.');
					}
					++stamina$count;
					this.stamina = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 3:
					if (vip$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_PlayerExtra.vip cannot be set twice.');
					}
					++vip$count;
					this.vip = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 4:
					if (coin$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_PlayerExtra.coin cannot be set twice.');
					}
					++coin$count;
					this.coin = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 5:
					if (gold$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_PlayerExtra.gold cannot be set twice.');
					}
					++gold$count;
					this.gold = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 6:
					if (spirit$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_PlayerExtra.spirit cannot be set twice.');
					}
					++spirit$count;
					this.spirit = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
