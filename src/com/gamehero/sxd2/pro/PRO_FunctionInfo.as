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
	public final class PRO_FunctionInfo extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const ID:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.gamehero.sxd2.pro.PRO_FunctionInfo.id", "id", (1 << 3) | com.netease.protobuf.WireType.VARINT);

		private var id$field:int;

		private var hasField$0:uint = 0;

		public function clearId():void {
			hasField$0 &= 0xfffffffe;
			id$field = new int();
		}

		public function get hasId():Boolean {
			return (hasField$0 & 0x1) != 0;
		}

		public function set id(value:int):void {
			hasField$0 |= 0x1;
			id$field = value;
		}

		public function get id():int {
			return id$field;
		}

		/**
		 *  @private
		 */
		public static const IS_OPEN:FieldDescriptor$TYPE_BOOL = new FieldDescriptor$TYPE_BOOL("com.gamehero.sxd2.pro.PRO_FunctionInfo.is_open", "isOpen", (2 << 3) | com.netease.protobuf.WireType.VARINT);

		private var is_open$field:Boolean;

		public function clearIsOpen():void {
			hasField$0 &= 0xfffffffd;
			is_open$field = new Boolean();
		}

		public function get hasIsOpen():Boolean {
			return (hasField$0 & 0x2) != 0;
		}

		public function set isOpen(value:Boolean):void {
			hasField$0 |= 0x2;
			is_open$field = value;
		}

		public function get isOpen():Boolean {
			return is_open$field;
		}

		/**
		 *  @private
		 */
		public static const FUNCTION_NUM:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("com.gamehero.sxd2.pro.PRO_FunctionInfo.function_num", "functionNum", (3 << 3) | com.netease.protobuf.WireType.VARINT);

		private var function_num$field:int;

		public function clearFunctionNum():void {
			hasField$0 &= 0xfffffffb;
			function_num$field = new int();
		}

		public function get hasFunctionNum():Boolean {
			return (hasField$0 & 0x4) != 0;
		}

		public function set functionNum(value:int):void {
			hasField$0 |= 0x4;
			function_num$field = value;
		}

		public function get functionNum():int {
			return function_num$field;
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			if (hasId) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 1);
				com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, id$field);
			}
			if (hasIsOpen) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 2);
				com.netease.protobuf.WriteUtils.write$TYPE_BOOL(output, is_open$field);
			}
			if (hasFunctionNum) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 3);
				com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, function_num$field);
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
			var is_open$count:uint = 0;
			var function_num$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					if (id$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_FunctionInfo.id cannot be set twice.');
					}
					++id$count;
					this.id = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 2:
					if (is_open$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_FunctionInfo.isOpen cannot be set twice.');
					}
					++is_open$count;
					this.isOpen = com.netease.protobuf.ReadUtils.read$TYPE_BOOL(input);
					break;
				case 3:
					if (function_num$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_FunctionInfo.functionNum cannot be set twice.');
					}
					++function_num$count;
					this.functionNum = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
