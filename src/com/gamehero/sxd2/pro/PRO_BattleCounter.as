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
	public final class PRO_BattleCounter extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const TARGET:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.gamehero.sxd2.pro.PRO_BattleCounter.target", "target", (1 << 3) | com.netease.protobuf.WireType.VARINT);

		private var target$field:int;

		private var hasField$0:uint = 0;

		public function clearTarget():void {
			hasField$0 &= 0xfffffffe;
			target$field = new int();
		}

		public function get hasTarget():Boolean {
			return (hasField$0 & 0x1) != 0;
		}

		public function set target(value:int):void {
			hasField$0 |= 0x1;
			target$field = value;
		}

		public function get target():int {
			return target$field;
		}

		/**
		 *  @private
		 */
		public static const DMG:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.gamehero.sxd2.pro.PRO_BattleCounter.dmg", "dmg", (2 << 3) | com.netease.protobuf.WireType.VARINT);

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
		public static const DMGSHOW:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.gamehero.sxd2.pro.PRO_BattleCounter.dmgShow", "dmgShow", (3 << 3) | com.netease.protobuf.WireType.VARINT);

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
		public static const SKILLID:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.gamehero.sxd2.pro.PRO_BattleCounter.skillID", "skillID", (4 << 3) | com.netease.protobuf.WireType.VARINT);

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
		public static const ABSORB:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.gamehero.sxd2.pro.PRO_BattleCounter.absorb", "absorb", (5 << 3) | com.netease.protobuf.WireType.VARINT);

		private var absorb$field:int;

		public function clearAbsorb():void {
			hasField$0 &= 0xffffffef;
			absorb$field = new int();
		}

		public function get hasAbsorb():Boolean {
			return (hasField$0 & 0x10) != 0;
		}

		public function set absorb(value:int):void {
			hasField$0 |= 0x10;
			absorb$field = value;
		}

		public function get absorb():int {
			return absorb$field;
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			if (hasTarget) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 1);
				com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, target$field);
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
			if (hasAbsorb) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 5);
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
			var target$count:uint = 0;
			var dmg$count:uint = 0;
			var dmgShow$count:uint = 0;
			var skillID$count:uint = 0;
			var absorb$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					if (target$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_BattleCounter.target cannot be set twice.');
					}
					++target$count;
					this.target = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 2:
					if (dmg$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_BattleCounter.dmg cannot be set twice.');
					}
					++dmg$count;
					this.dmg = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 3:
					if (dmgShow$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_BattleCounter.dmgShow cannot be set twice.');
					}
					++dmgShow$count;
					this.dmgShow = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 4:
					if (skillID$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_BattleCounter.skillID cannot be set twice.');
					}
					++skillID$count;
					this.skillID = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 5:
					if (absorb$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_BattleCounter.absorb cannot be set twice.');
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
