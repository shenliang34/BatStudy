package com.gamehero.sxd2.pro {
	import com.netease.protobuf.*;
	use namespace com.netease.protobuf.used_by_generated_code;
	import com.netease.protobuf.fieldDescriptors.*;
	import flash.utils.Endian;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.errors.IOError;
	import com.gamehero.sxd2.pro.PRO_PlayerBase;
	// @@protoc_insertion_point(imports)

	// @@protoc_insertion_point(class_metadata)
	public final class PRO_Hero extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const HERO_ID:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.PRO_Hero.hero_id", "heroId", (1 << 3) | com.netease.protobuf.WireType.VARINT);

		private var hero_id$field:uint;

		private var hasField$0:uint = 0;

		public function clearHeroId():void {
			hasField$0 &= 0xfffffffe;
			hero_id$field = new uint();
		}

		public function get hasHeroId():Boolean {
			return (hasField$0 & 0x1) != 0;
		}

		public function set heroId(value:uint):void {
			hasField$0 |= 0x1;
			hero_id$field = value;
		}

		public function get heroId():uint {
			return hero_id$field;
		}

		/**
		 *  @private
		 */
		public static const BASE:FieldDescriptor$TYPE_MESSAGE = new FieldDescriptor$TYPE_MESSAGE("com.gamehero.sxd2.pro.PRO_Hero.base", "base", (2 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return com.gamehero.sxd2.pro.PRO_PlayerBase; });

		private var base$field:com.gamehero.sxd2.pro.PRO_PlayerBase;

		public function clearBase():void {
			base$field = null;
		}

		public function get hasBase():Boolean {
			return base$field != null;
		}

		public function set base(value:com.gamehero.sxd2.pro.PRO_PlayerBase):void {
			base$field = value;
		}

		public function get base():com.gamehero.sxd2.pro.PRO_PlayerBase {
			return base$field;
		}

		/**
		 *  @private
		 */
		public static const RING:FieldDescriptor$TYPE_UINT64 = new FieldDescriptor$TYPE_UINT64("com.gamehero.sxd2.pro.PRO_Hero.ring", "ring", (3 << 3) | com.netease.protobuf.WireType.VARINT);

		private var ring$field:UInt64;

		public function clearRing():void {
			ring$field = null;
		}

		public function get hasRing():Boolean {
			return ring$field != null;
		}

		public function set ring(value:UInt64):void {
			ring$field = value;
		}

		public function get ring():UInt64 {
			return ring$field;
		}

		/**
		 *  @private
		 */
		public static const WEAPON:FieldDescriptor$TYPE_UINT64 = new FieldDescriptor$TYPE_UINT64("com.gamehero.sxd2.pro.PRO_Hero.weapon", "weapon", (4 << 3) | com.netease.protobuf.WireType.VARINT);

		private var weapon$field:UInt64;

		public function clearWeapon():void {
			weapon$field = null;
		}

		public function get hasWeapon():Boolean {
			return weapon$field != null;
		}

		public function set weapon(value:UInt64):void {
			weapon$field = value;
		}

		public function get weapon():UInt64 {
			return weapon$field;
		}

		/**
		 *  @private
		 */
		public static const NECK:FieldDescriptor$TYPE_UINT64 = new FieldDescriptor$TYPE_UINT64("com.gamehero.sxd2.pro.PRO_Hero.neck", "neck", (5 << 3) | com.netease.protobuf.WireType.VARINT);

		private var neck$field:UInt64;

		public function clearNeck():void {
			neck$field = null;
		}

		public function get hasNeck():Boolean {
			return neck$field != null;
		}

		public function set neck(value:UInt64):void {
			neck$field = value;
		}

		public function get neck():UInt64 {
			return neck$field;
		}

		/**
		 *  @private
		 */
		public static const HEAD:FieldDescriptor$TYPE_UINT64 = new FieldDescriptor$TYPE_UINT64("com.gamehero.sxd2.pro.PRO_Hero.head", "head", (6 << 3) | com.netease.protobuf.WireType.VARINT);

		private var head$field:UInt64;

		public function clearHead():void {
			head$field = null;
		}

		public function get hasHead():Boolean {
			return head$field != null;
		}

		public function set head(value:UInt64):void {
			head$field = value;
		}

		public function get head():UInt64 {
			return head$field;
		}

		/**
		 *  @private
		 */
		public static const CLOTH:FieldDescriptor$TYPE_UINT64 = new FieldDescriptor$TYPE_UINT64("com.gamehero.sxd2.pro.PRO_Hero.cloth", "cloth", (7 << 3) | com.netease.protobuf.WireType.VARINT);

		private var cloth$field:UInt64;

		public function clearCloth():void {
			cloth$field = null;
		}

		public function get hasCloth():Boolean {
			return cloth$field != null;
		}

		public function set cloth(value:UInt64):void {
			cloth$field = value;
		}

		public function get cloth():UInt64 {
			return cloth$field;
		}

		/**
		 *  @private
		 */
		public static const SHOES:FieldDescriptor$TYPE_UINT64 = new FieldDescriptor$TYPE_UINT64("com.gamehero.sxd2.pro.PRO_Hero.shoes", "shoes", (8 << 3) | com.netease.protobuf.WireType.VARINT);

		private var shoes$field:UInt64;

		public function clearShoes():void {
			shoes$field = null;
		}

		public function get hasShoes():Boolean {
			return shoes$field != null;
		}

		public function set shoes(value:UInt64):void {
			shoes$field = value;
		}

		public function get shoes():UInt64 {
			return shoes$field;
		}

		/**
		 *  @private
		 */
		public static const INDEX:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.PRO_Hero.index", "index", (9 << 3) | com.netease.protobuf.WireType.VARINT);

		private var index$field:uint;

		public function clearIndex():void {
			hasField$0 &= 0xfffffffd;
			index$field = new uint();
		}

		public function get hasIndex():Boolean {
			return (hasField$0 & 0x2) != 0;
		}

		public function set index(value:uint):void {
			hasField$0 |= 0x2;
			index$field = value;
		}

		public function get index():uint {
			return index$field;
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			if (hasHeroId) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 1);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, hero_id$field);
			}
			if (hasBase) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 2);
				com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, base$field);
			}
			if (hasRing) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 3);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT64(output, ring$field);
			}
			if (hasWeapon) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 4);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT64(output, weapon$field);
			}
			if (hasNeck) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 5);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT64(output, neck$field);
			}
			if (hasHead) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 6);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT64(output, head$field);
			}
			if (hasCloth) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 7);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT64(output, cloth$field);
			}
			if (hasShoes) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 8);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT64(output, shoes$field);
			}
			if (hasIndex) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 9);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, index$field);
			}
			for (var fieldKey:* in this) {
				super.writeUnknown(output, fieldKey);
			}
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function readFromSlice(input:flash.utils.IDataInput, bytesAfterSlice:uint):void {
			var hero_id$count:uint = 0;
			var base$count:uint = 0;
			var ring$count:uint = 0;
			var weapon$count:uint = 0;
			var neck$count:uint = 0;
			var head$count:uint = 0;
			var cloth$count:uint = 0;
			var shoes$count:uint = 0;
			var index$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					if (hero_id$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_Hero.heroId cannot be set twice.');
					}
					++hero_id$count;
					this.heroId = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 2:
					if (base$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_Hero.base cannot be set twice.');
					}
					++base$count;
					this.base = new com.gamehero.sxd2.pro.PRO_PlayerBase();
					com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, this.base);
					break;
				case 3:
					if (ring$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_Hero.ring cannot be set twice.');
					}
					++ring$count;
					this.ring = com.netease.protobuf.ReadUtils.read$TYPE_UINT64(input);
					break;
				case 4:
					if (weapon$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_Hero.weapon cannot be set twice.');
					}
					++weapon$count;
					this.weapon = com.netease.protobuf.ReadUtils.read$TYPE_UINT64(input);
					break;
				case 5:
					if (neck$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_Hero.neck cannot be set twice.');
					}
					++neck$count;
					this.neck = com.netease.protobuf.ReadUtils.read$TYPE_UINT64(input);
					break;
				case 6:
					if (head$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_Hero.head cannot be set twice.');
					}
					++head$count;
					this.head = com.netease.protobuf.ReadUtils.read$TYPE_UINT64(input);
					break;
				case 7:
					if (cloth$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_Hero.cloth cannot be set twice.');
					}
					++cloth$count;
					this.cloth = com.netease.protobuf.ReadUtils.read$TYPE_UINT64(input);
					break;
				case 8:
					if (shoes$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_Hero.shoes cannot be set twice.');
					}
					++shoes$count;
					this.shoes = com.netease.protobuf.ReadUtils.read$TYPE_UINT64(input);
					break;
				case 9:
					if (index$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_Hero.index cannot be set twice.');
					}
					++index$count;
					this.index = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
