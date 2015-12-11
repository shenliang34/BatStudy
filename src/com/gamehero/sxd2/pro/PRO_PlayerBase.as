package com.gamehero.sxd2.pro {
	import com.netease.protobuf.*;
	use namespace com.netease.protobuf.used_by_generated_code;
	import com.netease.protobuf.fieldDescriptors.*;
	import flash.utils.Endian;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.errors.IOError;
	import com.gamehero.sxd2.pro.PRO_Property;
	// @@protoc_insertion_point(imports)

	// @@protoc_insertion_point(class_metadata)
	public final class PRO_PlayerBase extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const ID:FieldDescriptor$TYPE_UINT64 = new FieldDescriptor$TYPE_UINT64("com.gamehero.sxd2.pro.PRO_PlayerBase.id", "id", (1 << 3) | com.netease.protobuf.WireType.VARINT);

		private var id$field:UInt64;

		public function clearId():void {
			id$field = null;
		}

		public function get hasId():Boolean {
			return id$field != null;
		}

		public function set id(value:UInt64):void {
			id$field = value;
		}

		public function get id():UInt64 {
			return id$field;
		}

		/**
		 *  @private
		 */
		public static const NAME:FieldDescriptor$TYPE_STRING = new FieldDescriptor$TYPE_STRING("com.gamehero.sxd2.pro.PRO_PlayerBase.name", "name", (2 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED);

		private var name$field:String;

		public function clearName():void {
			name$field = null;
		}

		public function get hasName():Boolean {
			return name$field != null;
		}

		public function set name(value:String):void {
			name$field = value;
		}

		public function get name():String {
			return name$field;
		}

		/**
		 *  @private
		 */
		public static const SEX_OR_JOB:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.PRO_PlayerBase.sex_or_job", "sexOrJob", (3 << 3) | com.netease.protobuf.WireType.VARINT);

		private var sex_or_job$field:uint;

		private var hasField$0:uint = 0;

		public function clearSexOrJob():void {
			hasField$0 &= 0xfffffffe;
			sex_or_job$field = new uint();
		}

		public function get hasSexOrJob():Boolean {
			return (hasField$0 & 0x1) != 0;
		}

		public function set sexOrJob(value:uint):void {
			hasField$0 |= 0x1;
			sex_or_job$field = value;
		}

		public function get sexOrJob():uint {
			return sex_or_job$field;
		}

		/**
		 *  @private
		 */
		public static const LEVEL:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.PRO_PlayerBase.level", "level", (4 << 3) | com.netease.protobuf.WireType.VARINT);

		private var level$field:uint;

		public function clearLevel():void {
			hasField$0 &= 0xfffffffd;
			level$field = new uint();
		}

		public function get hasLevel():Boolean {
			return (hasField$0 & 0x2) != 0;
		}

		public function set level(value:uint):void {
			hasField$0 |= 0x2;
			level$field = value;
		}

		public function get level():uint {
			return level$field;
		}

		/**
		 *  @private
		 */
		public static const HP:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.PRO_PlayerBase.hp", "hp", (6 << 3) | com.netease.protobuf.WireType.VARINT);

		private var hp$field:uint;

		public function clearHp():void {
			hasField$0 &= 0xfffffffb;
			hp$field = new uint();
		}

		public function get hasHp():Boolean {
			return (hasField$0 & 0x4) != 0;
		}

		public function set hp(value:uint):void {
			hasField$0 |= 0x4;
			hp$field = value;
		}

		public function get hp():uint {
			return hp$field;
		}

		/**
		 *  @private
		 */
		public static const MAXHP:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.PRO_PlayerBase.maxhp", "maxhp", (7 << 3) | com.netease.protobuf.WireType.VARINT);

		private var maxhp$field:uint;

		public function clearMaxhp():void {
			hasField$0 &= 0xfffffff7;
			maxhp$field = new uint();
		}

		public function get hasMaxhp():Boolean {
			return (hasField$0 & 0x8) != 0;
		}

		public function set maxhp(value:uint):void {
			hasField$0 |= 0x8;
			maxhp$field = value;
		}

		public function get maxhp():uint {
			return maxhp$field;
		}

		/**
		 *  @private
		 */
		public static const POWER:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.PRO_PlayerBase.power", "power", (8 << 3) | com.netease.protobuf.WireType.VARINT);

		private var power$field:uint;

		public function clearPower():void {
			hasField$0 &= 0xffffffef;
			power$field = new uint();
		}

		public function get hasPower():Boolean {
			return (hasField$0 & 0x10) != 0;
		}

		public function set power(value:uint):void {
			hasField$0 |= 0x10;
			power$field = value;
		}

		public function get power():uint {
			return power$field;
		}

		/**
		 *  @private
		 */
		public static const PROPERTY:FieldDescriptor$TYPE_MESSAGE = new FieldDescriptor$TYPE_MESSAGE("com.gamehero.sxd2.pro.PRO_PlayerBase.property", "property", (9 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return com.gamehero.sxd2.pro.PRO_Property; });

		private var property$field:com.gamehero.sxd2.pro.PRO_Property;

		public function clearProperty():void {
			property$field = null;
		}

		public function get hasProperty():Boolean {
			return property$field != null;
		}

		public function set property(value:com.gamehero.sxd2.pro.PRO_Property):void {
			property$field = value;
		}

		public function get property():com.gamehero.sxd2.pro.PRO_Property {
			return property$field;
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			if (hasId) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 1);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT64(output, id$field);
			}
			if (hasName) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 2);
				com.netease.protobuf.WriteUtils.write$TYPE_STRING(output, name$field);
			}
			if (hasSexOrJob) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 3);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, sex_or_job$field);
			}
			if (hasLevel) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 4);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, level$field);
			}
			if (hasHp) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 6);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, hp$field);
			}
			if (hasMaxhp) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 7);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, maxhp$field);
			}
			if (hasPower) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 8);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, power$field);
			}
			if (hasProperty) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 9);
				com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, property$field);
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
			var name$count:uint = 0;
			var sex_or_job$count:uint = 0;
			var level$count:uint = 0;
			var hp$count:uint = 0;
			var maxhp$count:uint = 0;
			var power$count:uint = 0;
			var property$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					if (id$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_PlayerBase.id cannot be set twice.');
					}
					++id$count;
					this.id = com.netease.protobuf.ReadUtils.read$TYPE_UINT64(input);
					break;
				case 2:
					if (name$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_PlayerBase.name cannot be set twice.');
					}
					++name$count;
					this.name = com.netease.protobuf.ReadUtils.read$TYPE_STRING(input);
					break;
				case 3:
					if (sex_or_job$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_PlayerBase.sexOrJob cannot be set twice.');
					}
					++sex_or_job$count;
					this.sexOrJob = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 4:
					if (level$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_PlayerBase.level cannot be set twice.');
					}
					++level$count;
					this.level = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 6:
					if (hp$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_PlayerBase.hp cannot be set twice.');
					}
					++hp$count;
					this.hp = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 7:
					if (maxhp$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_PlayerBase.maxhp cannot be set twice.');
					}
					++maxhp$count;
					this.maxhp = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 8:
					if (power$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_PlayerBase.power cannot be set twice.');
					}
					++power$count;
					this.power = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 9:
					if (property$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_PlayerBase.property cannot be set twice.');
					}
					++property$count;
					this.property = new com.gamehero.sxd2.pro.PRO_Property();
					com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, this.property);
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
