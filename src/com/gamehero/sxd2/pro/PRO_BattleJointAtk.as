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
	public final class PRO_BattleJointAtk extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const ATTACKER:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.gamehero.sxd2.pro.PRO_BattleJointAtk.attacker", "attacker", (1 << 3) | com.netease.protobuf.WireType.VARINT);

		private var attacker$field:int;

		private var hasField$0:uint = 0;

		public function clearAttacker():void {
			hasField$0 &= 0xfffffffe;
			attacker$field = new int();
		}

		public function get hasAttacker():Boolean {
			return (hasField$0 & 0x1) != 0;
		}

		public function set attacker(value:int):void {
			hasField$0 |= 0x1;
			attacker$field = value;
		}

		public function get attacker():int {
			return attacker$field;
		}

		/**
		 *  @private
		 */
		public static const DMG:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.gamehero.sxd2.pro.PRO_BattleJointAtk.dmg", "dmg", (2 << 3) | com.netease.protobuf.WireType.VARINT);

		private var dmg$field:int;

		public function clearDmg():void {
			hasField$0 &= 0xfffffffd;
			dmg$field = new int();
		}

		public function get hasDmg():Boolean {
			return (hasField$0 & 0x2) != 0;
		}

		public function set dmg(value:int):void {
			hasField$0 |= 0x2;
			dmg$field = value;
		}

		public function get dmg():int {
			return dmg$field;
		}

		/**
		 *  @private
		 */
		public static const DMGSHOW:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.gamehero.sxd2.pro.PRO_BattleJointAtk.dmgShow", "dmgShow", (3 << 3) | com.netease.protobuf.WireType.VARINT);

		private var dmgShow$field:int;

		public function clearDmgShow():void {
			hasField$0 &= 0xfffffffb;
			dmgShow$field = new int();
		}

		public function get hasDmgShow():Boolean {
			return (hasField$0 & 0x4) != 0;
		}

		public function set dmgShow(value:int):void {
			hasField$0 |= 0x4;
			dmgShow$field = value;
		}

		public function get dmgShow():int {
			return dmgShow$field;
		}

		/**
		 *  @private
		 */
		public static const SKILLID:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.gamehero.sxd2.pro.PRO_BattleJointAtk.skillID", "skillID", (4 << 3) | com.netease.protobuf.WireType.VARINT);

		private var skillID$field:int;

		public function clearSkillID():void {
			hasField$0 &= 0xfffffff7;
			skillID$field = new int();
		}

		public function get hasSkillID():Boolean {
			return (hasField$0 & 0x8) != 0;
		}

		public function set skillID(value:int):void {
			hasField$0 |= 0x8;
			skillID$field = value;
		}

		public function get skillID():int {
			return skillID$field;
		}

		/**
		 *  @private
		 */
		public static const CRT:FieldDescriptor$TYPE_BOOL = new FieldDescriptor$TYPE_BOOL("com.gamehero.sxd2.pro.PRO_BattleJointAtk.crt", "crt", (5 << 3) | com.netease.protobuf.WireType.VARINT);

		private var crt$field:Boolean;

		public function clearCrt():void {
			hasField$0 &= 0xffffffef;
			crt$field = new Boolean();
		}

		public function get hasCrt():Boolean {
			return (hasField$0 & 0x10) != 0;
		}

		public function set crt(value:Boolean):void {
			hasField$0 |= 0x10;
			crt$field = value;
		}

		public function get crt():Boolean {
			return crt$field;
		}

		/**
		 *  @private
		 */
		public static const PENETRATION:FieldDescriptor$TYPE_BOOL = new FieldDescriptor$TYPE_BOOL("com.gamehero.sxd2.pro.PRO_BattleJointAtk.penetration", "penetration", (6 << 3) | com.netease.protobuf.WireType.VARINT);

		private var penetration$field:Boolean;

		public function clearPenetration():void {
			hasField$0 &= 0xffffffdf;
			penetration$field = new Boolean();
		}

		public function get hasPenetration():Boolean {
			return (hasField$0 & 0x20) != 0;
		}

		public function set penetration(value:Boolean):void {
			hasField$0 |= 0x20;
			penetration$field = value;
		}

		public function get penetration():Boolean {
			return penetration$field;
		}

		/**
		 *  @private
		 */
		public static const ABSORB:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.gamehero.sxd2.pro.PRO_BattleJointAtk.absorb", "absorb", (7 << 3) | com.netease.protobuf.WireType.VARINT);

		private var absorb$field:int;

		public function clearAbsorb():void {
			hasField$0 &= 0xffffffbf;
			absorb$field = new int();
		}

		public function get hasAbsorb():Boolean {
			return (hasField$0 & 0x40) != 0;
		}

		public function set absorb(value:int):void {
			hasField$0 |= 0x40;
			absorb$field = value;
		}

		public function get absorb():int {
			return absorb$field;
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			if (hasAttacker) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 1);
				com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, attacker$field);
			}
			if (hasDmg) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 2);
				com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, dmg$field);
			}
			if (hasDmgShow) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 3);
				com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, dmgShow$field);
			}
			if (hasSkillID) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 4);
				com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, skillID$field);
			}
			if (hasCrt) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 5);
				com.netease.protobuf.WriteUtils.write$TYPE_BOOL(output, crt$field);
			}
			if (hasPenetration) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 6);
				com.netease.protobuf.WriteUtils.write$TYPE_BOOL(output, penetration$field);
			}
			if (hasAbsorb) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 7);
				com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, absorb$field);
			}
			for (var fieldKey:* in this) {
				super.writeUnknown(output, fieldKey);
			}
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function readFromSlice(input:flash.utils.IDataInput, bytesAfterSlice:uint):void {
			var attacker$count:uint = 0;
			var dmg$count:uint = 0;
			var dmgShow$count:uint = 0;
			var skillID$count:uint = 0;
			var crt$count:uint = 0;
			var penetration$count:uint = 0;
			var absorb$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					if (attacker$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_BattleJointAtk.attacker cannot be set twice.');
					}
					++attacker$count;
					this.attacker = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 2:
					if (dmg$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_BattleJointAtk.dmg cannot be set twice.');
					}
					++dmg$count;
					this.dmg = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 3:
					if (dmgShow$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_BattleJointAtk.dmgShow cannot be set twice.');
					}
					++dmgShow$count;
					this.dmgShow = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 4:
					if (skillID$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_BattleJointAtk.skillID cannot be set twice.');
					}
					++skillID$count;
					this.skillID = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 5:
					if (crt$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_BattleJointAtk.crt cannot be set twice.');
					}
					++crt$count;
					this.crt = com.netease.protobuf.ReadUtils.read$TYPE_BOOL(input);
					break;
				case 6:
					if (penetration$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_BattleJointAtk.penetration cannot be set twice.');
					}
					++penetration$count;
					this.penetration = com.netease.protobuf.ReadUtils.read$TYPE_BOOL(input);
					break;
				case 7:
					if (absorb$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_BattleJointAtk.absorb cannot be set twice.');
					}
					++absorb$count;
					this.absorb = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
