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
	public final class PRO_Formation extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const ID:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.PRO_Formation.id", "id", (1 << 3) | com.netease.protobuf.WireType.VARINT);

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
		public static const HERO_ID_1:FieldDescriptor$TYPE_UINT64 = new FieldDescriptor$TYPE_UINT64("com.gamehero.sxd2.pro.PRO_Formation.hero_id_1", "heroId_1", (2 << 3) | com.netease.protobuf.WireType.VARINT);

		private var hero_id_1$field:UInt64;

		public function clearHeroId_1():void {
			hero_id_1$field = null;
		}

		public function get hasHeroId_1():Boolean {
			return hero_id_1$field != null;
		}

		public function set heroId_1(value:UInt64):void {
			hero_id_1$field = value;
		}

		public function get heroId_1():UInt64 {
			return hero_id_1$field;
		}

		/**
		 *  @private
		 */
		public static const HERO_ID_2:FieldDescriptor$TYPE_UINT64 = new FieldDescriptor$TYPE_UINT64("com.gamehero.sxd2.pro.PRO_Formation.hero_id_2", "heroId_2", (3 << 3) | com.netease.protobuf.WireType.VARINT);

		private var hero_id_2$field:UInt64;

		public function clearHeroId_2():void {
			hero_id_2$field = null;
		}

		public function get hasHeroId_2():Boolean {
			return hero_id_2$field != null;
		}

		public function set heroId_2(value:UInt64):void {
			hero_id_2$field = value;
		}

		public function get heroId_2():UInt64 {
			return hero_id_2$field;
		}

		/**
		 *  @private
		 */
		public static const HERO_ID_3:FieldDescriptor$TYPE_UINT64 = new FieldDescriptor$TYPE_UINT64("com.gamehero.sxd2.pro.PRO_Formation.hero_id_3", "heroId_3", (4 << 3) | com.netease.protobuf.WireType.VARINT);

		private var hero_id_3$field:UInt64;

		public function clearHeroId_3():void {
			hero_id_3$field = null;
		}

		public function get hasHeroId_3():Boolean {
			return hero_id_3$field != null;
		}

		public function set heroId_3(value:UInt64):void {
			hero_id_3$field = value;
		}

		public function get heroId_3():UInt64 {
			return hero_id_3$field;
		}

		/**
		 *  @private
		 */
		public static const HERO_ID_4:FieldDescriptor$TYPE_UINT64 = new FieldDescriptor$TYPE_UINT64("com.gamehero.sxd2.pro.PRO_Formation.hero_id_4", "heroId_4", (5 << 3) | com.netease.protobuf.WireType.VARINT);

		private var hero_id_4$field:UInt64;

		public function clearHeroId_4():void {
			hero_id_4$field = null;
		}

		public function get hasHeroId_4():Boolean {
			return hero_id_4$field != null;
		}

		public function set heroId_4(value:UInt64):void {
			hero_id_4$field = value;
		}

		public function get heroId_4():UInt64 {
			return hero_id_4$field;
		}

		/**
		 *  @private
		 */
		public static const HERO_ID_5:FieldDescriptor$TYPE_UINT64 = new FieldDescriptor$TYPE_UINT64("com.gamehero.sxd2.pro.PRO_Formation.hero_id_5", "heroId_5", (6 << 3) | com.netease.protobuf.WireType.VARINT);

		private var hero_id_5$field:UInt64;

		public function clearHeroId_5():void {
			hero_id_5$field = null;
		}

		public function get hasHeroId_5():Boolean {
			return hero_id_5$field != null;
		}

		public function set heroId_5(value:UInt64):void {
			hero_id_5$field = value;
		}

		public function get heroId_5():UInt64 {
			return hero_id_5$field;
		}

		/**
		 *  @private
		 */
		public static const HERO_ID_6:FieldDescriptor$TYPE_UINT64 = new FieldDescriptor$TYPE_UINT64("com.gamehero.sxd2.pro.PRO_Formation.hero_id_6", "heroId_6", (7 << 3) | com.netease.protobuf.WireType.VARINT);

		private var hero_id_6$field:UInt64;

		public function clearHeroId_6():void {
			hero_id_6$field = null;
		}

		public function get hasHeroId_6():Boolean {
			return hero_id_6$field != null;
		}

		public function set heroId_6(value:UInt64):void {
			hero_id_6$field = value;
		}

		public function get heroId_6():UInt64 {
			return hero_id_6$field;
		}

		/**
		 *  @private
		 */
		public static const HERO_ID_7:FieldDescriptor$TYPE_UINT64 = new FieldDescriptor$TYPE_UINT64("com.gamehero.sxd2.pro.PRO_Formation.hero_id_7", "heroId_7", (8 << 3) | com.netease.protobuf.WireType.VARINT);

		private var hero_id_7$field:UInt64;

		public function clearHeroId_7():void {
			hero_id_7$field = null;
		}

		public function get hasHeroId_7():Boolean {
			return hero_id_7$field != null;
		}

		public function set heroId_7(value:UInt64):void {
			hero_id_7$field = value;
		}

		public function get heroId_7():UInt64 {
			return hero_id_7$field;
		}

		/**
		 *  @private
		 */
		public static const HERO_ID_8:FieldDescriptor$TYPE_UINT64 = new FieldDescriptor$TYPE_UINT64("com.gamehero.sxd2.pro.PRO_Formation.hero_id_8", "heroId_8", (9 << 3) | com.netease.protobuf.WireType.VARINT);

		private var hero_id_8$field:UInt64;

		public function clearHeroId_8():void {
			hero_id_8$field = null;
		}

		public function get hasHeroId_8():Boolean {
			return hero_id_8$field != null;
		}

		public function set heroId_8(value:UInt64):void {
			hero_id_8$field = value;
		}

		public function get heroId_8():UInt64 {
			return hero_id_8$field;
		}

		/**
		 *  @private
		 */
		public static const HERO_ID_9:FieldDescriptor$TYPE_UINT64 = new FieldDescriptor$TYPE_UINT64("com.gamehero.sxd2.pro.PRO_Formation.hero_id_9", "heroId_9", (10 << 3) | com.netease.protobuf.WireType.VARINT);

		private var hero_id_9$field:UInt64;

		public function clearHeroId_9():void {
			hero_id_9$field = null;
		}

		public function get hasHeroId_9():Boolean {
			return hero_id_9$field != null;
		}

		public function set heroId_9(value:UInt64):void {
			hero_id_9$field = value;
		}

		public function get heroId_9():UInt64 {
			return hero_id_9$field;
		}

		/**
		 *  @private
		 */
		public static const HERO_ID_10:FieldDescriptor$TYPE_UINT64 = new FieldDescriptor$TYPE_UINT64("com.gamehero.sxd2.pro.PRO_Formation.hero_id_10", "heroId_10", (11 << 3) | com.netease.protobuf.WireType.VARINT);

		private var hero_id_10$field:UInt64;

		public function clearHeroId_10():void {
			hero_id_10$field = null;
		}

		public function get hasHeroId_10():Boolean {
			return hero_id_10$field != null;
		}

		public function set heroId_10(value:UInt64):void {
			hero_id_10$field = value;
		}

		public function get heroId_10():UInt64 {
			return hero_id_10$field;
		}

		/**
		 *  @private
		 */
		public static const HERO_ID_11:FieldDescriptor$TYPE_UINT64 = new FieldDescriptor$TYPE_UINT64("com.gamehero.sxd2.pro.PRO_Formation.hero_id_11", "heroId_11", (12 << 3) | com.netease.protobuf.WireType.VARINT);

		private var hero_id_11$field:UInt64;

		public function clearHeroId_11():void {
			hero_id_11$field = null;
		}

		public function get hasHeroId_11():Boolean {
			return hero_id_11$field != null;
		}

		public function set heroId_11(value:UInt64):void {
			hero_id_11$field = value;
		}

		public function get heroId_11():UInt64 {
			return hero_id_11$field;
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			if (hasId) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 1);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, id$field);
			}
			if (hasHeroId_1) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 2);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT64(output, hero_id_1$field);
			}
			if (hasHeroId_2) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 3);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT64(output, hero_id_2$field);
			}
			if (hasHeroId_3) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 4);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT64(output, hero_id_3$field);
			}
			if (hasHeroId_4) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 5);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT64(output, hero_id_4$field);
			}
			if (hasHeroId_5) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 6);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT64(output, hero_id_5$field);
			}
			if (hasHeroId_6) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 7);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT64(output, hero_id_6$field);
			}
			if (hasHeroId_7) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 8);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT64(output, hero_id_7$field);
			}
			if (hasHeroId_8) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 9);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT64(output, hero_id_8$field);
			}
			if (hasHeroId_9) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 10);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT64(output, hero_id_9$field);
			}
			if (hasHeroId_10) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 11);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT64(output, hero_id_10$field);
			}
			if (hasHeroId_11) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 12);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT64(output, hero_id_11$field);
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
			var hero_id_1$count:uint = 0;
			var hero_id_2$count:uint = 0;
			var hero_id_3$count:uint = 0;
			var hero_id_4$count:uint = 0;
			var hero_id_5$count:uint = 0;
			var hero_id_6$count:uint = 0;
			var hero_id_7$count:uint = 0;
			var hero_id_8$count:uint = 0;
			var hero_id_9$count:uint = 0;
			var hero_id_10$count:uint = 0;
			var hero_id_11$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					if (id$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_Formation.id cannot be set twice.');
					}
					++id$count;
					this.id = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 2:
					if (hero_id_1$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_Formation.heroId_1 cannot be set twice.');
					}
					++hero_id_1$count;
					this.heroId_1 = com.netease.protobuf.ReadUtils.read$TYPE_UINT64(input);
					break;
				case 3:
					if (hero_id_2$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_Formation.heroId_2 cannot be set twice.');
					}
					++hero_id_2$count;
					this.heroId_2 = com.netease.protobuf.ReadUtils.read$TYPE_UINT64(input);
					break;
				case 4:
					if (hero_id_3$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_Formation.heroId_3 cannot be set twice.');
					}
					++hero_id_3$count;
					this.heroId_3 = com.netease.protobuf.ReadUtils.read$TYPE_UINT64(input);
					break;
				case 5:
					if (hero_id_4$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_Formation.heroId_4 cannot be set twice.');
					}
					++hero_id_4$count;
					this.heroId_4 = com.netease.protobuf.ReadUtils.read$TYPE_UINT64(input);
					break;
				case 6:
					if (hero_id_5$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_Formation.heroId_5 cannot be set twice.');
					}
					++hero_id_5$count;
					this.heroId_5 = com.netease.protobuf.ReadUtils.read$TYPE_UINT64(input);
					break;
				case 7:
					if (hero_id_6$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_Formation.heroId_6 cannot be set twice.');
					}
					++hero_id_6$count;
					this.heroId_6 = com.netease.protobuf.ReadUtils.read$TYPE_UINT64(input);
					break;
				case 8:
					if (hero_id_7$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_Formation.heroId_7 cannot be set twice.');
					}
					++hero_id_7$count;
					this.heroId_7 = com.netease.protobuf.ReadUtils.read$TYPE_UINT64(input);
					break;
				case 9:
					if (hero_id_8$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_Formation.heroId_8 cannot be set twice.');
					}
					++hero_id_8$count;
					this.heroId_8 = com.netease.protobuf.ReadUtils.read$TYPE_UINT64(input);
					break;
				case 10:
					if (hero_id_9$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_Formation.heroId_9 cannot be set twice.');
					}
					++hero_id_9$count;
					this.heroId_9 = com.netease.protobuf.ReadUtils.read$TYPE_UINT64(input);
					break;
				case 11:
					if (hero_id_10$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_Formation.heroId_10 cannot be set twice.');
					}
					++hero_id_10$count;
					this.heroId_10 = com.netease.protobuf.ReadUtils.read$TYPE_UINT64(input);
					break;
				case 12:
					if (hero_id_11$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_Formation.heroId_11 cannot be set twice.');
					}
					++hero_id_11$count;
					this.heroId_11 = com.netease.protobuf.ReadUtils.read$TYPE_UINT64(input);
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
