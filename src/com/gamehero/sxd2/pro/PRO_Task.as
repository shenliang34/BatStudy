package com.gamehero.sxd2.pro {
	import com.netease.protobuf.*;
	use namespace com.netease.protobuf.used_by_generated_code;
	import com.netease.protobuf.fieldDescriptors.*;
	import flash.utils.Endian;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.errors.IOError;
	import com.gamehero.sxd2.pro.TaskStatus;
	// @@protoc_insertion_point(imports)

	// @@protoc_insertion_point(class_metadata)
	public final class PRO_Task extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const ID:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.PRO_Task.id", "id", (1 << 3) | com.netease.protobuf.WireType.VARINT);

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
		public static const STATUS:FieldDescriptor$TYPE_ENUM = new FieldDescriptor$TYPE_ENUM("com.gamehero.sxd2.pro.PRO_Task.status", "status", (2 << 3) | com.netease.protobuf.WireType.VARINT, com.gamehero.sxd2.pro.TaskStatus);

		private var status$field:int;

		public function clearStatus():void {
			hasField$0 &= 0xfffffffd;
			status$field = new int();
		}

		public function get hasStatus():Boolean {
			return (hasField$0 & 0x2) != 0;
		}

		public function set status(value:int):void {
			hasField$0 |= 0x2;
			status$field = value;
		}

		public function get status():int {
			return status$field;
		}

		/**
		 *  @private
		 */
		public static const COUNT:RepeatedFieldDescriptor$TYPE_UINT32 = new RepeatedFieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.PRO_Task.count", "count", (3 << 3) | com.netease.protobuf.WireType.VARINT);

		[ArrayElementType("uint")]
		public var count:Array = [];

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			if (hasId) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 1);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, id$field);
			}
			if (hasStatus) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 2);
				com.netease.protobuf.WriteUtils.write$TYPE_ENUM(output, status$field);
			}
			for (var count$index:uint = 0; count$index < this.count.length; ++count$index) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 3);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, this.count[count$index]);
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
			var status$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					if (id$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_Task.id cannot be set twice.');
					}
					++id$count;
					this.id = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 2:
					if (status$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_Task.status cannot be set twice.');
					}
					++status$count;
					this.status = com.netease.protobuf.ReadUtils.read$TYPE_ENUM(input);
					break;
				case 3:
					if ((tag & 7) == com.netease.protobuf.WireType.LENGTH_DELIMITED) {
						com.netease.protobuf.ReadUtils.readPackedRepeated(input, com.netease.protobuf.ReadUtils.read$TYPE_UINT32, this.count);
						break;
					}
					this.count.push(com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input));
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
