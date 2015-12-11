package com.gamehero.sxd2.pro {
	import com.netease.protobuf.*;
	use namespace com.netease.protobuf.used_by_generated_code;
	import com.netease.protobuf.fieldDescriptors.*;
	import flash.utils.Endian;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.errors.IOError;
	import com.gamehero.sxd2.pro.PRO_Notice;
	// @@protoc_insertion_point(imports)

	// @@protoc_insertion_point(class_metadata)
	public final class PRO_Mail_Detail extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const ID:FieldDescriptor$TYPE_UINT64 = new FieldDescriptor$TYPE_UINT64("com.gamehero.sxd2.pro.PRO_Mail_Detail.id", "id", (1 << 3) | com.netease.protobuf.WireType.VARINT);

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
		public static const TITLE:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.PRO_Mail_Detail.title", "title", (2 << 3) | com.netease.protobuf.WireType.VARINT);

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
		public static const CONTENT:FieldDescriptor$TYPE_MESSAGE = new FieldDescriptor$TYPE_MESSAGE("com.gamehero.sxd2.pro.PRO_Mail_Detail.content", "content", (3 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return com.gamehero.sxd2.pro.PRO_Notice; });

		private var content$field:com.gamehero.sxd2.pro.PRO_Notice;

		public function clearContent():void {
			content$field = null;
		}

		public function get hasContent():Boolean {
			return content$field != null;
		}

		public function set content(value:com.gamehero.sxd2.pro.PRO_Notice):void {
			content$field = value;
		}

		public function get content():com.gamehero.sxd2.pro.PRO_Notice {
			return content$field;
		}

		/**
		 *  @private
		 */
		public static const ITEM_ID1:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.PRO_Mail_Detail.item_id1", "itemId1", (4 << 3) | com.netease.protobuf.WireType.VARINT);

		private var item_id1$field:uint;

		public function clearItemId1():void {
			hasField$0 &= 0xfffffffd;
			item_id1$field = new uint();
		}

		public function get hasItemId1():Boolean {
			return (hasField$0 & 0x2) != 0;
		}

		public function set itemId1(value:uint):void {
			hasField$0 |= 0x2;
			item_id1$field = value;
		}

		public function get itemId1():uint {
			return item_id1$field;
		}

		/**
		 *  @private
		 */
		public static const ITEM_NUM1:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.PRO_Mail_Detail.item_num1", "itemNum1", (5 << 3) | com.netease.protobuf.WireType.VARINT);

		private var item_num1$field:uint;

		public function clearItemNum1():void {
			hasField$0 &= 0xfffffffb;
			item_num1$field = new uint();
		}

		public function get hasItemNum1():Boolean {
			return (hasField$0 & 0x4) != 0;
		}

		public function set itemNum1(value:uint):void {
			hasField$0 |= 0x4;
			item_num1$field = value;
		}

		public function get itemNum1():uint {
			return item_num1$field;
		}

		/**
		 *  @private
		 */
		public static const ITEM_ID2:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.PRO_Mail_Detail.item_id2", "itemId2", (6 << 3) | com.netease.protobuf.WireType.VARINT);

		private var item_id2$field:uint;

		public function clearItemId2():void {
			hasField$0 &= 0xfffffff7;
			item_id2$field = new uint();
		}

		public function get hasItemId2():Boolean {
			return (hasField$0 & 0x8) != 0;
		}

		public function set itemId2(value:uint):void {
			hasField$0 |= 0x8;
			item_id2$field = value;
		}

		public function get itemId2():uint {
			return item_id2$field;
		}

		/**
		 *  @private
		 */
		public static const ITEM_NUM2:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.PRO_Mail_Detail.item_num2", "itemNum2", (7 << 3) | com.netease.protobuf.WireType.VARINT);

		private var item_num2$field:uint;

		public function clearItemNum2():void {
			hasField$0 &= 0xffffffef;
			item_num2$field = new uint();
		}

		public function get hasItemNum2():Boolean {
			return (hasField$0 & 0x10) != 0;
		}

		public function set itemNum2(value:uint):void {
			hasField$0 |= 0x10;
			item_num2$field = value;
		}

		public function get itemNum2():uint {
			return item_num2$field;
		}

		/**
		 *  @private
		 */
		public static const ITEM_ID3:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.PRO_Mail_Detail.item_id3", "itemId3", (8 << 3) | com.netease.protobuf.WireType.VARINT);

		private var item_id3$field:uint;

		public function clearItemId3():void {
			hasField$0 &= 0xffffffdf;
			item_id3$field = new uint();
		}

		public function get hasItemId3():Boolean {
			return (hasField$0 & 0x20) != 0;
		}

		public function set itemId3(value:uint):void {
			hasField$0 |= 0x20;
			item_id3$field = value;
		}

		public function get itemId3():uint {
			return item_id3$field;
		}

		/**
		 *  @private
		 */
		public static const ITEM_NUM3:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.PRO_Mail_Detail.item_num3", "itemNum3", (9 << 3) | com.netease.protobuf.WireType.VARINT);

		private var item_num3$field:uint;

		public function clearItemNum3():void {
			hasField$0 &= 0xffffffbf;
			item_num3$field = new uint();
		}

		public function get hasItemNum3():Boolean {
			return (hasField$0 & 0x40) != 0;
		}

		public function set itemNum3(value:uint):void {
			hasField$0 |= 0x40;
			item_num3$field = value;
		}

		public function get itemNum3():uint {
			return item_num3$field;
		}

		/**
		 *  @private
		 */
		public static const ITEM_ID4:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.PRO_Mail_Detail.item_id4", "itemId4", (10 << 3) | com.netease.protobuf.WireType.VARINT);

		private var item_id4$field:uint;

		public function clearItemId4():void {
			hasField$0 &= 0xffffff7f;
			item_id4$field = new uint();
		}

		public function get hasItemId4():Boolean {
			return (hasField$0 & 0x80) != 0;
		}

		public function set itemId4(value:uint):void {
			hasField$0 |= 0x80;
			item_id4$field = value;
		}

		public function get itemId4():uint {
			return item_id4$field;
		}

		/**
		 *  @private
		 */
		public static const ITEM_NUM4:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.PRO_Mail_Detail.item_num4", "itemNum4", (11 << 3) | com.netease.protobuf.WireType.VARINT);

		private var item_num4$field:uint;

		public function clearItemNum4():void {
			hasField$0 &= 0xfffffeff;
			item_num4$field = new uint();
		}

		public function get hasItemNum4():Boolean {
			return (hasField$0 & 0x100) != 0;
		}

		public function set itemNum4(value:uint):void {
			hasField$0 |= 0x100;
			item_num4$field = value;
		}

		public function get itemNum4():uint {
			return item_num4$field;
		}

		/**
		 *  @private
		 */
		public static const ITEM_ID5:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.PRO_Mail_Detail.item_id5", "itemId5", (12 << 3) | com.netease.protobuf.WireType.VARINT);

		private var item_id5$field:uint;

		public function clearItemId5():void {
			hasField$0 &= 0xfffffdff;
			item_id5$field = new uint();
		}

		public function get hasItemId5():Boolean {
			return (hasField$0 & 0x200) != 0;
		}

		public function set itemId5(value:uint):void {
			hasField$0 |= 0x200;
			item_id5$field = value;
		}

		public function get itemId5():uint {
			return item_id5$field;
		}

		/**
		 *  @private
		 */
		public static const ITEM_NUM5:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.PRO_Mail_Detail.item_num5", "itemNum5", (13 << 3) | com.netease.protobuf.WireType.VARINT);

		private var item_num5$field:uint;

		public function clearItemNum5():void {
			hasField$0 &= 0xfffffbff;
			item_num5$field = new uint();
		}

		public function get hasItemNum5():Boolean {
			return (hasField$0 & 0x400) != 0;
		}

		public function set itemNum5(value:uint):void {
			hasField$0 |= 0x400;
			item_num5$field = value;
		}

		public function get itemNum5():uint {
			return item_num5$field;
		}

		/**
		 *  @private
		 */
		public static const ITEM_ID6:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.PRO_Mail_Detail.item_id6", "itemId6", (14 << 3) | com.netease.protobuf.WireType.VARINT);

		private var item_id6$field:uint;

		public function clearItemId6():void {
			hasField$0 &= 0xfffff7ff;
			item_id6$field = new uint();
		}

		public function get hasItemId6():Boolean {
			return (hasField$0 & 0x800) != 0;
		}

		public function set itemId6(value:uint):void {
			hasField$0 |= 0x800;
			item_id6$field = value;
		}

		public function get itemId6():uint {
			return item_id6$field;
		}

		/**
		 *  @private
		 */
		public static const ITEM_NUM6:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.PRO_Mail_Detail.item_num6", "itemNum6", (15 << 3) | com.netease.protobuf.WireType.VARINT);

		private var item_num6$field:uint;

		public function clearItemNum6():void {
			hasField$0 &= 0xffffefff;
			item_num6$field = new uint();
		}

		public function get hasItemNum6():Boolean {
			return (hasField$0 & 0x1000) != 0;
		}

		public function set itemNum6(value:uint):void {
			hasField$0 |= 0x1000;
			item_num6$field = value;
		}

		public function get itemNum6():uint {
			return item_num6$field;
		}

		/**
		 *  @private
		 */
		public static const STATUS:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.PRO_Mail_Detail.status", "status", (16 << 3) | com.netease.protobuf.WireType.VARINT);

		private var status$field:uint;

		public function clearStatus():void {
			hasField$0 &= 0xffffdfff;
			status$field = new uint();
		}

		public function get hasStatus():Boolean {
			return (hasField$0 & 0x2000) != 0;
		}

		public function set status(value:uint):void {
			hasField$0 |= 0x2000;
			status$field = value;
		}

		public function get status():uint {
			return status$field;
		}

		/**
		 *  @private
		 */
		public static const SEND_TIME:FieldDescriptor$TYPE_UINT32 = new FieldDescriptor$TYPE_UINT32("com.gamehero.sxd2.pro.PRO_Mail_Detail.send_time", "sendTime", (17 << 3) | com.netease.protobuf.WireType.VARINT);

		private var send_time$field:uint;

		public function clearSendTime():void {
			hasField$0 &= 0xffffbfff;
			send_time$field = new uint();
		}

		public function get hasSendTime():Boolean {
			return (hasField$0 & 0x4000) != 0;
		}

		public function set sendTime(value:uint):void {
			hasField$0 |= 0x4000;
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
			if (hasContent) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 3);
				com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, content$field);
			}
			if (hasItemId1) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 4);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, item_id1$field);
			}
			if (hasItemNum1) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 5);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, item_num1$field);
			}
			if (hasItemId2) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 6);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, item_id2$field);
			}
			if (hasItemNum2) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 7);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, item_num2$field);
			}
			if (hasItemId3) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 8);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, item_id3$field);
			}
			if (hasItemNum3) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 9);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, item_num3$field);
			}
			if (hasItemId4) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 10);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, item_id4$field);
			}
			if (hasItemNum4) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 11);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, item_num4$field);
			}
			if (hasItemId5) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 12);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, item_id5$field);
			}
			if (hasItemNum5) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 13);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, item_num5$field);
			}
			if (hasItemId6) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 14);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, item_id6$field);
			}
			if (hasItemNum6) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 15);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, item_num6$field);
			}
			if (hasStatus) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 16);
				com.netease.protobuf.WriteUtils.write$TYPE_UINT32(output, status$field);
			}
			if (hasSendTime) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 17);
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
			var content$count:uint = 0;
			var item_id1$count:uint = 0;
			var item_num1$count:uint = 0;
			var item_id2$count:uint = 0;
			var item_num2$count:uint = 0;
			var item_id3$count:uint = 0;
			var item_num3$count:uint = 0;
			var item_id4$count:uint = 0;
			var item_num4$count:uint = 0;
			var item_id5$count:uint = 0;
			var item_num5$count:uint = 0;
			var item_id6$count:uint = 0;
			var item_num6$count:uint = 0;
			var status$count:uint = 0;
			var send_time$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					if (id$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_Mail_Detail.id cannot be set twice.');
					}
					++id$count;
					this.id = com.netease.protobuf.ReadUtils.read$TYPE_UINT64(input);
					break;
				case 2:
					if (title$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_Mail_Detail.title cannot be set twice.');
					}
					++title$count;
					this.title = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 3:
					if (content$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_Mail_Detail.content cannot be set twice.');
					}
					++content$count;
					this.content = new com.gamehero.sxd2.pro.PRO_Notice();
					com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, this.content);
					break;
				case 4:
					if (item_id1$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_Mail_Detail.itemId1 cannot be set twice.');
					}
					++item_id1$count;
					this.itemId1 = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 5:
					if (item_num1$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_Mail_Detail.itemNum1 cannot be set twice.');
					}
					++item_num1$count;
					this.itemNum1 = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 6:
					if (item_id2$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_Mail_Detail.itemId2 cannot be set twice.');
					}
					++item_id2$count;
					this.itemId2 = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 7:
					if (item_num2$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_Mail_Detail.itemNum2 cannot be set twice.');
					}
					++item_num2$count;
					this.itemNum2 = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 8:
					if (item_id3$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_Mail_Detail.itemId3 cannot be set twice.');
					}
					++item_id3$count;
					this.itemId3 = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 9:
					if (item_num3$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_Mail_Detail.itemNum3 cannot be set twice.');
					}
					++item_num3$count;
					this.itemNum3 = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 10:
					if (item_id4$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_Mail_Detail.itemId4 cannot be set twice.');
					}
					++item_id4$count;
					this.itemId4 = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 11:
					if (item_num4$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_Mail_Detail.itemNum4 cannot be set twice.');
					}
					++item_num4$count;
					this.itemNum4 = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 12:
					if (item_id5$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_Mail_Detail.itemId5 cannot be set twice.');
					}
					++item_id5$count;
					this.itemId5 = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 13:
					if (item_num5$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_Mail_Detail.itemNum5 cannot be set twice.');
					}
					++item_num5$count;
					this.itemNum5 = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 14:
					if (item_id6$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_Mail_Detail.itemId6 cannot be set twice.');
					}
					++item_id6$count;
					this.itemId6 = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 15:
					if (item_num6$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_Mail_Detail.itemNum6 cannot be set twice.');
					}
					++item_num6$count;
					this.itemNum6 = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 16:
					if (status$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_Mail_Detail.status cannot be set twice.');
					}
					++status$count;
					this.status = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
					break;
				case 17:
					if (send_time$count != 0) {
						throw new flash.errors.IOError('Bad data format: PRO_Mail_Detail.sendTime cannot be set twice.');
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
