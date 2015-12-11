package com.gamehero.sxd2.pro {
	import com.netease.protobuf.*;
	use namespace com.netease.protobuf.used_by_generated_code;
	import com.netease.protobuf.fieldDescriptors.*;
	import flash.utils.Endian;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.errors.IOError;
	import com.gamehero.sxd2.pro.PRO_Hero;
	import com.gamehero.sxd2.pro.PRO_Formation;
	// @@protoc_insertion_point(imports)

	// @@protoc_insertion_point(class_metadata)
	public final class MSG_UPDATE_FORMATION_ACK extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const FORMATION:FieldDescriptor$TYPE_MESSAGE = new FieldDescriptor$TYPE_MESSAGE("com.gamehero.sxd2.pro.MSG_UPDATE_FORMATION_ACK.formation", "formation", (1 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return com.gamehero.sxd2.pro.PRO_Formation; });

		private var formation$field:com.gamehero.sxd2.pro.PRO_Formation;

		public function clearFormation():void {
			formation$field = null;
		}

		public function get hasFormation():Boolean {
			return formation$field != null;
		}

		public function set formation(value:com.gamehero.sxd2.pro.PRO_Formation):void {
			formation$field = value;
		}

		public function get formation():com.gamehero.sxd2.pro.PRO_Formation {
			return formation$field;
		}

		/**
		 *  @private
		 */
		public static const HERO:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("com.gamehero.sxd2.pro.MSG_UPDATE_FORMATION_ACK.hero", "hero", (2 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return com.gamehero.sxd2.pro.PRO_Hero; });

		[ArrayElementType("com.gamehero.sxd2.pro.PRO_Hero")]
		public var hero:Array = [];

		/**
		 *  @private
		 */
		public static const ACTIVE_FORMATION_ID:RepeatedFieldDescriptor$TYPE_UINT32 = new RepeatedFieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.MSG_UPDATE_FORMATION_ACK.active_formation_id", "activeFormationId", (3 << 3) | com.netease.protobuf.WireType.VARINT);

		[ArrayElementType("uint")]
		public var activeFormationId:Array = [];

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			if (hasFormation) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 1);
				com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, formation$field);
			}
			for (var hero$index:uint = 0; hero$index < this.hero.length; ++hero$index) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 2);
				com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, this.hero[hero$index]);
			}
			for (var activeFormationId$index:uint = 0; activeFormationId$index < this.activeFormationId.length; ++activeFormationId$index) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 3);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, this.activeFormationId[activeFormationId$index]);
			}
			for (var fieldKey:* in this) {
				super.writeUnknown(output, fieldKey);
			}
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function readFromSlice(input:flash.utils.IDataInput, bytesAfterSlice:uint):void {
			var formation$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					if (formation$count != 0) {
						throw new flash.errors.IOError('Bad data format: MSG_UPDATE_FORMATION_ACK.formation cannot be set twice.');
					}
					++formation$count;
					this.formation = new com.gamehero.sxd2.pro.PRO_Formation();
					com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, this.formation);
					break;
				case 2:
					this.hero.push(com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, new com.gamehero.sxd2.pro.PRO_Hero()));
					break;
				case 3:
					if ((tag & 7) == com.netease.protobuf.WireType.LENGTH_DELIMITED) {
						com.netease.protobuf.ReadUtils.readPackedRepeated(input, com.netease.protobuf.ReadUtils.read$TYPE_UINT32, this.activeFormationId);
						break;
					}
					this.activeFormationId.push(com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input));
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
