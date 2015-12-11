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
	public final class PRO_Mail_Info extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const ID:FieldDescriptor$TYPE_UINT64 = new FieldDescriptor$TYPE_UINT64("com.gamehero.sxd2.pro.PRO_Mail_Info.id", "id", (1 << 3) | com.netease.protobuf.WireType.VARINT);

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
		public static const TITLE:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.PRO_Mail_Info.title", "title", (2 << 3) | com.netease.protobuf.WireType.VARINT);

		private var title$field:uint;

		private var hasField$0:uint = 0;

		public function clearTitle():void {
			hasField$0 &= 0xfffffffe;
			title$field = new uint();
		}

		public function get hasTitle():Boolean {
			return (hasField$0 & 0x1) != 0;
		}

		public function set title(value:uint):void {
			hasField$0 |= 0x1;
			title$field = value;
		}

		public function get title():uint {
			return title$field;
		}

		/**
		 *  @private
		 */
		public static const HAS_ATTACH:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.PRO_Mail_Info.has_attach", "hasAttach", (3 << 3) | com.netease.protobuf.WireType.VARINT);

		private var has_attach$field:uint;

		public function clearHasAttach():void {
			hasField$0 &= 0xfffffffd;
			has_attach$field = new uint();
		}

		public function get hasHasAttach():Boolean {
			return (hasField$0 & 0x2) != 0;
		}

		public function set hasAttach(value:uint):void {
			hasField$0 |= 0x2;
			has_attach$field = value;
		}

		public function get hasAttach():uint {
			return has_attach$field;
		}

		/**
		 *  @private
		 */
		public static const STATUS:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.PRO_Mail_Info.status", "status", (4 << 3) | com.netease.protobuf.WireType.VARINT);

		private var status$field:uint;

		public function clearStatus():void {
			hasField$0 &= 0xfffffffb;
			status$field = new uint();
		}

		public function get hasStatus():Boolean {
			return (hasField$0 & 0x4) != 0;
		}

		public function set status(value:uint):void {
			hasField$0 |= 0x4;
			status$field = value;
		}

		public function get status():uint {
			return status$field;
		}

		/**
		 *  @private
		 */
		public static const SEND_TIME:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.PRO_Mail_Info.send_time", "sendTime", (5 << 3) | com.netease.protobuf.WireType.VARINT);

		private var send_time$field:uint;

		public function clearSendTime():void {
			hasField$0 &= 0xfffffff7;
			send_time$field = new uint();
		}

		public function get hasSendTime():Boolean {
			return (hasField$0 & 0x8) != 0;
		}

		public function set sendTime(value:uint):void {
			hasField$0 |= 0x8;
			send_time$field = value;
		}

		public function get sendTime():uint {
			return send_time$field;
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			if (hasId) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 1);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT64(output, id$field);
			}
			if (hasTitle) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 2);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, title$field);
			}
			if (hasHasAttach) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 3);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, has_attach$field);
			}
			if (hasStatus) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 4);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, status$field);
			}
			if (hasSendTime) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 5);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, send_time$field);
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
			var title$count:uint = 0;
			var has_attach$count:uint = 0;
			var status$count:uint = 0;
			var send_time$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					if (id$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_Mail_Info.id cannot be set twice.');
					}
					++id$count;
					this.id = com.netease.protobuf.ReadUtils.read$TYPE_UINT64(input);
					break;
				case 2:
					if (title$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_Mail_Info.title cannot be set twice.');
					}
					++title$count;
					this.title = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 3:
					if (has_attach$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_Mail_Info.hasAttach cannot be set twice.');
					}
					++has_attach$count;
					this.hasAttach = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 4:
					if (status$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_Mail_Info.status cannot be set twice.');
					}
					++status$count;
					this.status = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 5:
					if (send_time$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_Mail_Info.sendTime cannot be set twice.');
					}
					++send_time$count;
					this.sendTime = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
