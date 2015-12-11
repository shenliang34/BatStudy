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
	public final class PRO_Property extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const ATTACK:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.PRO_Property.attack", "attack", (1 << 3) | com.netease.protobuf.WireType.VARINT);

		private var attack$field:uint;

		private var hasField$0:uint = 0;

		public function clearAttack():void {
			hasField$0 &= 0xfffffffe;
			attack$field = new uint();
		}

		public function get hasAttack():Boolean {
			return (hasField$0 & 0x1) != 0;
		}

		public function set attack(value:uint):void {
			hasField$0 |= 0x1;
			attack$field = value;
		}

		public function get attack():uint {
			return attack$field;
		}

		/**
		 *  @private
		 */
		public static const PDEF:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.PRO_Property.pdef", "pdef", (2 << 3) | com.netease.protobuf.WireType.VARINT);

		private var pdef$field:uint;

		public function clearPdef():void {
			hasField$0 &= 0xfffffffd;
			pdef$field = new uint();
		}

		public function get hasPdef():Boolean {
			return (hasField$0 & 0x2) != 0;
		}

		public function set pdef(value:uint):void {
			hasField$0 |= 0x2;
			pdef$field = value;
		}

		public function get pdef():uint {
			return pdef$field;
		}

		/**
		 *  @private
		 */
		public static const MDEF:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.PRO_Property.mdef", "mdef", (3 << 3) | com.netease.protobuf.WireType.VARINT);

		private var mdef$field:uint;

		public function clearMdef():void {
			hasField$0 &= 0xfffffffb;
			mdef$field = new uint();
		}

		public function get hasMdef():Boolean {
			return (hasField$0 & 0x4) != 0;
		}

		public function set mdef(value:uint):void {
			hasField$0 |= 0x4;
			mdef$field = value;
		}

		public function get mdef():uint {
			return mdef$field;
		}

		/**
		 *  @private
		 */
		public static const DOG:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.PRO_Property.dog", "dog", (4 << 3) | com.netease.protobuf.WireType.VARINT);

		private var dog$field:uint;

		public function clearDog():void {
			hasField$0 &= 0xfffffff7;
			dog$field = new uint();
		}

		public function get hasDog():Boolean {
			return (hasField$0 & 0x8) != 0;
		}

		public function set dog(value:uint):void {
			hasField$0 |= 0x8;
			dog$field = value;
		}

		public function get dog():uint {
			return dog$field;
		}

		/**
		 *  @private
		 */
		public static const CRIT:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.PRO_Property.crit", "crit", (5 << 3) | com.netease.protobuf.WireType.VARINT);

		private var crit$field:uint;

		public function clearCrit():void {
			hasField$0 &= 0xffffffef;
			crit$field = new uint();
		}

		public function get hasCrit():Boolean {
			return (hasField$0 & 0x10) != 0;
		}

		public function set crit(value:uint):void {
			hasField$0 |= 0x10;
			crit$field = value;
		}

		public function get crit():uint {
			return crit$field;
		}

		/**
		 *  @private
		 */
		public static const ARP:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.PRO_Property.arp", "arp", (6 << 3) | com.netease.protobuf.WireType.VARINT);

		private var arp$field:uint;

		public function clearArp():void {
			hasField$0 &= 0xffffffdf;
			arp$field = new uint();
		}

		public function get hasArp():Boolean {
			return (hasField$0 & 0x20) != 0;
		}

		public function set arp(value:uint):void {
			hasField$0 |= 0x20;
			arp$field = value;
		}

		public function get arp():uint {
			return arp$field;
		}

		/**
		 *  @private
		 */
		public static const PARRY:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.PRO_Property.parry", "parry", (7 << 3) | com.netease.protobuf.WireType.VARINT);

		private var parry$field:uint;

		public function clearParry():void {
			hasField$0 &= 0xffffffbf;
			parry$field = new uint();
		}

		public function get hasParry():Boolean {
			return (hasField$0 & 0x40) != 0;
		}

		public function set parry(value:uint):void {
			hasField$0 |= 0x40;
			parry$field = value;
		}

		public function get parry():uint {
			return parry$field;
		}

		/**
		 *  @private
		 */
		public static const SKILL_ATT:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.PRO_Property.skill_att", "skillAtt", (8 << 3) | com.netease.protobuf.WireType.VARINT);

		private var skill_att$field:uint;

		public function clearSkillAtt():void {
			hasField$0 &= 0xffffff7f;
			skill_att$field = new uint();
		}

		public function get hasSkillAtt():Boolean {
			return (hasField$0 & 0x80) != 0;
		}

		public function set skillAtt(value:uint):void {
			hasField$0 |= 0x80;
			skill_att$field = value;
		}

		public function get skillAtt():uint {
			return skill_att$field;
		}

		/**
		 *  @private
		 */
		public static const FORCE:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.PRO_Property.force", "force", (9 << 3) | com.netease.protobuf.WireType.VARINT);

		private var force$field:uint;

		public function clearForce():void {
			hasField$0 &= 0xfffffeff;
			force$field = new uint();
		}

		public function get hasForce():Boolean {
			return (hasField$0 & 0x100) != 0;
		}

		public function set force(value:uint):void {
			hasField$0 |= 0x100;
			force$field = value;
		}

		public function get force():uint {
			return force$field;
		}

		/**
		 *  @private
		 */
		public static const INTELLECT:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.PRO_Property.intellect", "intellect", (10 << 3) | com.netease.protobuf.WireType.VARINT);

		private var intellect$field:uint;

		public function clearIntellect():void {
			hasField$0 &= 0xfffffdff;
			intellect$field = new uint();
		}

		public function get hasIntellect():Boolean {
			return (hasField$0 & 0x200) != 0;
		}

		public function set intellect(value:uint):void {
			hasField$0 |= 0x200;
			intellect$field = value;
		}

		public function get intellect():uint {
			return intellect$field;
		}

		/**
		 *  @private
		 */
		public static const SKELETON:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.PRO_Property.skeleton", "skeleton", (11 << 3) | com.netease.protobuf.WireType.VARINT);

		private var skeleton$field:uint;

		public function clearSkeleton():void {
			hasField$0 &= 0xfffffbff;
			skeleton$field = new uint();
		}

		public function get hasSkeleton():Boolean {
			return (hasField$0 & 0x400) != 0;
		}

		public function set skeleton(value:uint):void {
			hasField$0 |= 0x400;
			skeleton$field = value;
		}

		public function get skeleton():uint {
			return skeleton$field;
		}

		/**
		 *  @private
		 */
		public static const ATT_EFFECT:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.PRO_Property.att_effect", "attEffect", (12 << 3) | com.netease.protobuf.WireType.VARINT);

		private var att_effect$field:uint;

		public function clearAttEffect():void {
			hasField$0 &= 0xfffff7ff;
			att_effect$field = new uint();
		}

		public function get hasAttEffect():Boolean {
			return (hasField$0 & 0x800) != 0;
		}

		public function set attEffect(value:uint):void {
			hasField$0 |= 0x800;
			att_effect$field = value;
		}

		public function get attEffect():uint {
			return att_effect$field;
		}

		/**
		 *  @private
		 */
		public static const DOG_EFFECT:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.PRO_Property.dog_effect", "dogEffect", (13 << 3) | com.netease.protobuf.WireType.VARINT);

		private var dog_effect$field:uint;

		public function clearDogEffect():void {
			hasField$0 &= 0xffffefff;
			dog_effect$field = new uint();
		}

		public function get hasDogEffect():Boolean {
			return (hasField$0 & 0x1000) != 0;
		}

		public function set dogEffect(value:uint):void {
			hasField$0 |= 0x1000;
			dog_effect$field = value;
		}

		public function get dogEffect():uint {
			return dog_effect$field;
		}

		/**
		 *  @private
		 */
		public static const PARRY_EFFECT:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.PRO_Property.parry_effect", "parryEffect", (14 << 3) | com.netease.protobuf.WireType.VARINT);

		private var parry_effect$field:uint;

		public function clearParryEffect():void {
			hasField$0 &= 0xffffdfff;
			parry_effect$field = new uint();
		}

		public function get hasParryEffect():Boolean {
			return (hasField$0 & 0x2000) != 0;
		}

		public function set parryEffect(value:uint):void {
			hasField$0 |= 0x2000;
			parry_effect$field = value;
		}

		public function get parryEffect():uint {
			return parry_effect$field;
		}

		/**
		 *  @private
		 */
		public static const CRIT_EFFECT:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.PRO_Property.crit_effect", "critEffect", (15 << 3) | com.netease.protobuf.WireType.VARINT);

		private var crit_effect$field:uint;

		public function clearCritEffect():void {
			hasField$0 &= 0xffffbfff;
			crit_effect$field = new uint();
		}

		public function get hasCritEffect():Boolean {
			return (hasField$0 & 0x4000) != 0;
		}

		public function set critEffect(value:uint):void {
			hasField$0 |= 0x4000;
			crit_effect$field = value;
		}

		public function get critEffect():uint {
			return crit_effect$field;
		}

		/**
		 *  @private
		 */
		public static const ARP_EFFECT:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.PRO_Property.arp_effect", "arpEffect", (16 << 3) | com.netease.protobuf.WireType.VARINT);

		private var arp_effect$field:uint;

		public function clearArpEffect():void {
			hasField$0 &= 0xffff7fff;
			arp_effect$field = new uint();
		}

		public function get hasArpEffect():Boolean {
			return (hasField$0 & 0x8000) != 0;
		}

		public function set arpEffect(value:uint):void {
			hasField$0 |= 0x8000;
			arp_effect$field = value;
		}

		public function get arpEffect():uint {
			return arp_effect$field;
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			if (hasAttack) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 1);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, attack$field);
			}
			if (hasPdef) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 2);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, pdef$field);
			}
			if (hasMdef) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 3);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, mdef$field);
			}
			if (hasDog) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 4);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, dog$field);
			}
			if (hasCrit) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 5);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, crit$field);
			}
			if (hasArp) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 6);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, arp$field);
			}
			if (hasParry) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 7);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, parry$field);
			}
			if (hasSkillAtt) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 8);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, skill_att$field);
			}
			if (hasForce) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 9);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, force$field);
			}
			if (hasIntellect) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 10);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, intellect$field);
			}
			if (hasSkeleton) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 11);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, skeleton$field);
			}
			if (hasAttEffect) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 12);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, att_effect$field);
			}
			if (hasDogEffect) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 13);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, dog_effect$field);
			}
			if (hasParryEffect) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 14);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, parry_effect$field);
			}
			if (hasCritEffect) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 15);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, crit_effect$field);
			}
			if (hasArpEffect) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 16);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, arp_effect$field);
			}
			for (var fieldKey:* in this) {
				super.writeUnknown(output, fieldKey);
			}
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function readFromSlice(input:flash.utils.IDataInput, bytesAfterSlice:uint):void {
			var attack$count:uint = 0;
			var pdef$count:uint = 0;
			var mdef$count:uint = 0;
			var dog$count:uint = 0;
			var crit$count:uint = 0;
			var arp$count:uint = 0;
			var parry$count:uint = 0;
			var skill_att$count:uint = 0;
			var force$count:uint = 0;
			var intellect$count:uint = 0;
			var skeleton$count:uint = 0;
			var att_effect$count:uint = 0;
			var dog_effect$count:uint = 0;
			var parry_effect$count:uint = 0;
			var crit_effect$count:uint = 0;
			var arp_effect$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					if (attack$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_Property.attack cannot be set twice.');
					}
					++attack$count;
					this.attack = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 2:
					if (pdef$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_Property.pdef cannot be set twice.');
					}
					++pdef$count;
					this.pdef = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 3:
					if (mdef$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_Property.mdef cannot be set twice.');
					}
					++mdef$count;
					this.mdef = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 4:
					if (dog$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_Property.dog cannot be set twice.');
					}
					++dog$count;
					this.dog = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 5:
					if (crit$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_Property.crit cannot be set twice.');
					}
					++crit$count;
					this.crit = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 6:
					if (arp$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_Property.arp cannot be set twice.');
					}
					++arp$count;
					this.arp = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 7:
					if (parry$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_Property.parry cannot be set twice.');
					}
					++parry$count;
					this.parry = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 8:
					if (skill_att$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_Property.skillAtt cannot be set twice.');
					}
					++skill_att$count;
					this.skillAtt = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 9:
					if (force$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_Property.force cannot be set twice.');
					}
					++force$count;
					this.force = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 10:
					if (intellect$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_Property.intellect cannot be set twice.');
					}
					++intellect$count;
					this.intellect = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 11:
					if (skeleton$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_Property.skeleton cannot be set twice.');
					}
					++skeleton$count;
					this.skeleton = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 12:
					if (att_effect$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_Property.attEffect cannot be set twice.');
					}
					++att_effect$count;
					this.attEffect = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 13:
					if (dog_effect$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_Property.dogEffect cannot be set twice.');
					}
					++dog_effect$count;
					this.dogEffect = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 14:
					if (parry_effect$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_Property.parryEffect cannot be set twice.');
					}
					++parry_effect$count;
					this.parryEffect = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 15:
					if (crit_effect$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_Property.critEffect cannot be set twice.');
					}
					++crit_effect$count;
					this.critEffect = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 16:
					if (arp_effect$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_Property.arpEffect cannot be set twice.');
					}
					++arp_effect$count;
					this.arpEffect = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
