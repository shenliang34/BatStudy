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
	import com.gamehero.sxd2.pro.PRO_PlayerBase;
	import com.gamehero.sxd2.pro.PRO_Item;
	// @@protoc_insertion_point(imports)

	// @@protoc_insertion_point(class_metadata)
	public final class PRO_Notice extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const ID:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.PRO_Notice.id", "id", (1 << 3) | com.netease.protobuf.WireType.VARINT);

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
		public static const PLAYER:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("com.gamehero.sxd2.pro.PRO_Notice.player", "player", (2 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return com.gamehero.sxd2.pro.PRO_PlayerBase; });

		[ArrayElementType("com.gamehero.sxd2.pro.PRO_PlayerBase")]
		public var player:Array = [];

		/**
		 *  @private
		 */
		public static const ITEM:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("com.gamehero.sxd2.pro.PRO_Notice.item", "item", (3 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return com.gamehero.sxd2.pro.PRO_Item; });

		[ArrayElementType("com.gamehero.sxd2.pro.PRO_Item")]
		public var item:Array = [];

		/**
		 *  @private
		 */
		public static const HERO:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("com.gamehero.sxd2.pro.PRO_Notice.hero", "hero", (4 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return com.gamehero.sxd2.pro.PRO_Hero; });

		[ArrayElementType("com.gamehero.sxd2.pro.PRO_Hero")]
		public var hero:Array = [];

		/**
		 *  @private
		 */
		public static const PARAM:RepeatedFieldDescriptor$TYPE_STRING = new RepeatedFieldDescriptor$TYPE_STRING("com.gamehero.sxd2.pro.PRO_Notice.param", "param", (5 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED);

		[ArrayElementType("String")]
		public var param:Array = [];

		/**
		 *  @private
		 */
		public static const LINK:RepeatedFieldDescriptor$TYPE_STRING = new RepeatedFieldDescriptor$TYPE_STRING("com.gamehero.sxd2.pro.PRO_Notice.link", "link", (6 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED);

		[ArrayElementType("String")]
		public var link:Array = [];

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			if (hasId) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 1);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, id$field);
			}
			for (var player$index:uint = 0; player$index < this.player.length; ++player$index) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 2);
				com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, this.player[player$index]);
			}
			for (var item$index:uint = 0; item$index < this.item.length; ++item$index) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 3);
				com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, this.item[item$index]);
			}
			for (var hero$index:uint = 0; hero$index < this.hero.length; ++hero$index) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 4);
				com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, this.hero[hero$index]);
			}
			for (var param$index:uint = 0; param$index < this.param.length; ++param$index) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 5);
				com.netease.protobuf.WriteUtils.write$TYPE_STRING(output, this.param[param$index]);
			}
			for (var link$index:uint = 0; link$index < this.link.length; ++link$index) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 6);
				com.netease.protobuf.WriteUtils.write$TYPE_STRING(output, this.link[link$index]);
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
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					if (id$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_Notice.id cannot be set twice.');
					}
					++id$count;
					this.id = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 2:
					this.player.push(com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, new com.gamehero.sxd2.pro.PRO_PlayerBase()));
					break;
				case 3:
					this.item.push(com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, new com.gamehero.sxd2.pro.PRO_Item()));
					break;
				case 4:
					this.hero.push(com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, new com.gamehero.sxd2.pro.PRO_Hero()));
					break;
				case 5:
					this.param.push(com.netease.protobuf.ReadUtils.read$TYPE_STRING(input));
					break;
				case 6:
					this.link.push(com.netease.protobuf.ReadUtils.read$TYPE_STRING(input));
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
