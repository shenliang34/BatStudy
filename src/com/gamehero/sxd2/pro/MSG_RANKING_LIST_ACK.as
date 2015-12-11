package com.gamehero.sxd2.pro {
	import com.netease.protobuf.*;
	use namespace com.netease.protobuf.used_by_generated_code;
	import com.netease.protobuf.fieldDescriptors.*;
	import flash.utils.Endian;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.errors.IOError;
	import com.gamehero.sxd2.pro.PRO_RankingInfo;
	import com.gamehero.sxd2.pro.PRO_RankingType;
	// @@protoc_insertion_point(imports)

	// @@protoc_insertion_point(class_metadata)
	public final class MSG_RANKING_LIST_ACK extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const TYPE:FieldDescriptor$TYPE_ENUM = new FieldDescriptor$TYPE_ENUM("com.gamehero.sxd2.pro.MSG_RANKING_LIST_ACK.type", "type", (1 << 3) | com.netease.protobuf.WireType.VARINT, com.gamehero.sxd2.pro.PRO_RankingType);

		private var type$field:int;

		private var hasField$0:uint = 0;

		public function clearType():void {
			hasField$0 &= 0xfffffffe;
			type$field = new int();
		}

		public function get hasType():Boolean {
			return (hasField$0 & 0x1) != 0;
		}

		public function set type(value:int):void {
			hasField$0 |= 0x1;
			type$field = value;
		}

		public function get type():int {
			return type$field;
		}

		/**
		 *  @private
		 */
		public static const INFOS:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("com.gamehero.sxd2.pro.MSG_RANKING_LIST_ACK.infos", "infos", (2 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return com.gamehero.sxd2.pro.PRO_RankingInfo; });

		[ArrayElementType("com.gamehero.sxd2.pro.PRO_RankingInfo")]
		public var infos:Array = [];

		/**
		 *  @private
		 */
		public static const MY_RANK:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.MSG_RANKING_LIST_ACK.my_rank", "myRank", (3 << 3) | com.netease.protobuf.WireType.VARINT);

		private var my_rank$field:uint;

		public function clearMyRank():void {
			hasField$0 &= 0xfffffffd;
			my_rank$field = new uint();
		}

		public function get hasMyRank():Boolean {
			return (hasField$0 & 0x2) != 0;
		}

		public function set myRank(value:uint):void {
			hasField$0 |= 0x2;
			my_rank$field = value;
		}

		public function get myRank():uint {
			return my_rank$field;
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			if (hasType) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 1);
				com.netease.protobuf.WriteUtils.write$TYPE_ENUM(output, type$field);
			}
			for (var infos$index:uint = 0; infos$index < this.infos.length; ++infos$index) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 2);
				com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, this.infos[infos$index]);
			}
			if (hasMyRank) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 3);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, my_rank$field);
			}
			for (var fieldKey:* in this) {
				super.writeUnknown(output, fieldKey);
			}
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function readFromSlice(input:flash.utils.IDataInput, bytesAfterSlice:uint):void {
			var type$count:uint = 0;
			var my_rank$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					if (type$count != 0) {
						throw new flash.errors.IOError('Bad data format: MSG_RANKING_LIST_ACK.type cannot be set twice.');
					}
					++type$count;
					this.type = com.netease.protobuf.ReadUtils.read$TYPE_ENUM(input);
					break;
				case 2:
					this.infos.push(com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, new com.gamehero.sxd2.pro.PRO_RankingInfo()));
					break;
				case 3:
					if (my_rank$count != 0) {
						throw new flash.errors.IOError('Bad data format: MSG_RANKING_LIST_ACK.myRank cannot be set twice.');
					}
					++my_rank$count;
					this.myRank = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
