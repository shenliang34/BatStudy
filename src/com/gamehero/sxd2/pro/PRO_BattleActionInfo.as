package com.gamehero.sxd2.pro {
	import com.netease.protobuf.*;
	use namespace com.netease.protobuf.used_by_generated_code;
	import com.netease.protobuf.fieldDescriptors.*;
	import flash.utils.Endian;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.errors.IOError;
	import com.gamehero.sxd2.pro.PRO_BattleBuff;
	import com.gamehero.sxd2.pro.PRO_BattleCounter;
	// @@protoc_insertion_point(imports)

	// @@protoc_insertion_point(class_metadata)
	public final class PRO_BattleActionInfo extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const TARGET:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.gamehero.sxd2.pro.PRO_BattleActionInfo.target", "target", (1 << 3) | com.netease.protobuf.WireType.VARINT);

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
		public static const DMG:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.gamehero.sxd2.pro.PRO_BattleActionInfo.dmg", "dmg", (2 << 3) | com.netease.protobuf.WireType.VARINT);

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
		public static const SELFDMG:RepeatedFieldDescriptor$TYPE_INT32 = new RepeatedFieldDescriptor$TYPE_INT32("com.gamehero.sxd2.pro.PRO_BattleActionInfo.selfdmg", "selfdmg", (3 << 3) | com.netease.protobuf.WireType.VARINT);

		[ArrayElementType("int")]
		public var selfdmg:Array = [];

		/**
		 *  @private
		 */
		public static const DMGSHOW:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.gamehero.sxd2.pro.PRO_BattleActionInfo.dmgShow", "dmgShow", (4 << 3) | com.netease.protobuf.WireType.VARINT);

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
		public static const SKILLID:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.gamehero.sxd2.pro.PRO_BattleActionInfo.skillID", "skillID", (5 << 3) | com.netease.protobuf.WireType.VARINT);

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
		public static const CRT:FieldDescriptor$TYPE_BOOL = new FieldDescriptor$TYPE_BOOL("com.gamehero.sxd2.pro.PRO_BattleActionInfo.crt", "crt", (6 << 3) | com.netease.protobuf.WireType.VARINT);

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
		public static const AVD:FieldDescriptor$TYPE_BOOL = new FieldDescriptor$TYPE_BOOL("com.gamehero.sxd2.pro.PRO_BattleActionInfo.avd", "avd", (7 << 3) | com.netease.protobuf.WireType.VARINT);

		private var avd$field:Boolean;

		public function clearAvd():void {
			hasField$0 &= 0xffffffdf;
			avd$field = new Boolean();
		}

		public function get hasAvd():Boolean {
			return (hasField$0 & 0x20) != 0;
		}

		public function set avd(value:Boolean):void {
			hasField$0 |= 0x20;
			avd$field = value;
		}

		public function get avd():Boolean {
			return avd$field;
		}

		/**
		 *  @private
		 */
		public static const PENETRATION:FieldDescriptor$TYPE_BOOL = new FieldDescriptor$TYPE_BOOL("com.gamehero.sxd2.pro.PRO_BattleActionInfo.penetration", "penetration", (8 << 3) | com.netease.protobuf.WireType.VARINT);

		private var penetration$field:Boolean;

		public function clearPenetration():void {
			hasField$0 &= 0xffffffbf;
			penetration$field = new Boolean();
		}

		public function get hasPenetration():Boolean {
			return (hasField$0 & 0x40) != 0;
		}

		public function set penetration(value:Boolean):void {
			hasField$0 |= 0x40;
			penetration$field = value;
		}

		public function get penetration():Boolean {
			return penetration$field;
		}

		/**
		 *  @private
		 */
		public static const PARRY:FieldDescriptor$TYPE_BOOL = new FieldDescriptor$TYPE_BOOL("com.gamehero.sxd2.pro.PRO_BattleActionInfo.parry", "parry", (9 << 3) | com.netease.protobuf.WireType.VARINT);

		private var parry$field:Boolean;

		public function clearParry():void {
			hasField$0 &= 0xffffff7f;
			parry$field = new Boolean();
		}

		public function get hasParry():Boolean {
			return (hasField$0 & 0x80) != 0;
		}

		public function set parry(value:Boolean):void {
			hasField$0 |= 0x80;
			parry$field = value;
		}

		public function get parry():Boolean {
			return parry$field;
		}

		/**
		 *  @private
		 */
		public static const ABSORB:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.gamehero.sxd2.pro.PRO_BattleActionInfo.absorb", "absorb", (10 << 3) | com.netease.protobuf.WireType.VARINT);

		private var absorb$field:int;

		public function clearAbsorb():void {
			hasField$0 &= 0xfffffeff;
			absorb$field = new int();
		}

		public function get hasAbsorb():Boolean {
			return (hasField$0 & 0x100) != 0;
		}

		public function set absorb(value:int):void {
			hasField$0 |= 0x100;
			absorb$field = value;
		}

		public function get absorb():int {
			return absorb$field;
		}

		/**
		 *  @private
		 */
		public static const ANGER:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.gamehero.sxd2.pro.PRO_BattleActionInfo.anger", "anger", (11 << 3) | com.netease.protobuf.WireType.VARINT);

		private var anger$field:int;

		public function clearAnger():void {
			hasField$0 &= 0xfffffdff;
			anger$field = new int();
		}

		public function get hasAnger():Boolean {
			return (hasField$0 & 0x200) != 0;
		}

		public function set anger(value:int):void {
			hasField$0 |= 0x200;
			anger$field = value;
		}

		public function get anger():int {
			return anger$field;
		}

		/**
		 *  @private
		 */
		public static const STEP:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.gamehero.sxd2.pro.PRO_BattleActionInfo.step", "step", (12 << 3) | com.netease.protobuf.WireType.VARINT);

		private var step$field:int;

		public function clearStep():void {
			hasField$0 &= 0xfffffbff;
			step$field = new int();
		}

		public function get hasStep():Boolean {
			return (hasField$0 & 0x400) != 0;
		}

		public function set step(value:int):void {
			hasField$0 |= 0x400;
			step$field = value;
		}

		public function get step():int {
			return step$field;
		}

		/**
		 *  @private
		 */
		public static const BUFFS:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("com.gamehero.sxd2.pro.PRO_BattleActionInfo.buffs", "buffs", (13 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return com.gamehero.sxd2.pro.PRO_BattleBuff; });

		[ArrayElementType("com.gamehero.sxd2.pro.PRO_BattleBuff")]
		public var buffs:Array = [];

		/**
		 *  @private
		 */
		public static const COUNTER:FieldDescriptor$TYPE_MESSAGE = new FieldDescriptor$TYPE_MESSAGE("com.gamehero.sxd2.pro.PRO_BattleActionInfo.counter", "counter", (14 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return com.gamehero.sxd2.pro.PRO_BattleCounter; });

		private var counter$field:com.gamehero.sxd2.pro.PRO_BattleCounter;

		public function clearCounter():void {
			counter$field = null;
		}

		public function get hasCounter():Boolean {
			return counter$field != null;
		}

		public function set counter(value:com.gamehero.sxd2.pro.PRO_BattleCounter):void {
			counter$field = value;
		}

		public function get counter():com.gamehero.sxd2.pro.PRO_BattleCounter {
			return counter$field;
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
			for (var selfdmg$index:uint = 0; selfdmg$index < this.selfdmg.length; ++selfdmg$index) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 3);
				com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, this.selfdmg[selfdmg$index]);
			}
			if (hasDmgShow) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 4);
				com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, dmgShow$field);
			}
			if (hasSkillID) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 5);
				com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, skillID$field);
			}
			if (hasCrt) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 6);
				com.netease.protobuf.WriteUtils.write$TYPE_BOOL(output, crt$field);
			}
			if (hasAvd) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 7);
				com.netease.protobuf.WriteUtils.write$TYPE_BOOL(output, avd$field);
			}
			if (hasPenetration) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 8);
				com.netease.protobuf.WriteUtils.write$TYPE_BOOL(output, penetration$field);
			}
			if (hasParry) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 9);
				com.netease.protobuf.WriteUtils.write$TYPE_BOOL(output, parry$field);
			}
			if (hasAbsorb) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 10);
				com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, absorb$field);
			}
			if (hasAnger) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 11);
				com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, anger$field);
			}
			if (hasStep) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 12);
				com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, step$field);
			}
			for (var buffs$index:uint = 0; buffs$index < this.buffs.length; ++buffs$index) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 13);
				com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, this.buffs[buffs$index]);
			}
			if (hasCounter) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 14);
				com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, counter$field);
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
			var crt$count:uint = 0;
			var avd$count:uint = 0;
			var penetration$count:uint = 0;
			var parry$count:uint = 0;
			var absorb$count:uint = 0;
			var anger$count:uint = 0;
			var step$count:uint = 0;
			var counter$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					if (target$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_BattleActionInfo.target cannot be set twice.');
					}
					++target$count;
					this.target = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 2:
					if (dmg$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_BattleActionInfo.dmg cannot be set twice.');
					}
					++dmg$count;
					this.dmg = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 3:
					if ((tag & 7) == com.netease.protobuf.WireType.LENGTH_DELIMITED) {
						com.netease.protobuf.ReadUtils.readPackedRepeated(input, com.netease.protobuf.ReadUtils.read$TYPE_INT32, this.selfdmg);
						break;
					}
					this.selfdmg.push(com.netease.protobuf.ReadUtils.read$TYPE_INT32(input));
					break;
				case 4:
					if (dmgShow$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_BattleActionInfo.dmgShow cannot be set twice.');
					}
					++dmgShow$count;
					this.dmgShow = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 5:
					if (skillID$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_BattleActionInfo.skillID cannot be set twice.');
					}
					++skillID$count;
					this.skillID = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 6:
					if (crt$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_BattleActionInfo.crt cannot be set twice.');
					}
					++crt$count;
					this.crt = com.netease.protobuf.ReadUtils.read$TYPE_BOOL(input);
					break;
				case 7:
					if (avd$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_BattleActionInfo.avd cannot be set twice.');
					}
					++avd$count;
					this.avd = com.netease.protobuf.ReadUtils.read$TYPE_BOOL(input);
					break;
				case 8:
					if (penetration$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_BattleActionInfo.penetration cannot be set twice.');
					}
					++penetration$count;
					this.penetration = com.netease.protobuf.ReadUtils.read$TYPE_BOOL(input);
					break;
				case 9:
					if (parry$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_BattleActionInfo.parry cannot be set twice.');
					}
					++parry$count;
					this.parry = com.netease.protobuf.ReadUtils.read$TYPE_BOOL(input);
					break;
				case 10:
					if (absorb$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_BattleActionInfo.absorb cannot be set twice.');
					}
					++absorb$count;
					this.absorb = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 11:
					if (anger$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_BattleActionInfo.anger cannot be set twice.');
					}
					++anger$count;
					this.anger = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 12:
					if (step$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_BattleActionInfo.step cannot be set twice.');
					}
					++step$count;
					this.step = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 13:
					this.buffs.push(com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, new com.gamehero.sxd2.pro.PRO_BattleBuff()));
					break;
				case 14:
					if (counter$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_BattleActionInfo.counter cannot be set twice.');
					}
					++counter$count;
					this.counter = new com.gamehero.sxd2.pro.PRO_BattleCounter();
					com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, this.counter);
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
