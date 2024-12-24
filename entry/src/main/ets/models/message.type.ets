import { IUserInfo, IUserInfoModel } from "./user.type"
import { util } from "@kit.ArkTS"

export interface IMessageInfo {
  id: string
  sendUser: IUserInfo
  receiveUser: IUserInfo
  messageOwner: IUserInfo // message归属者
  sendTime: number
  messageContent: string
  messageType: MessageTypeEnum
  sourceFilePath: string // 音视频，图片等文件地址
  sourceDuration: number // 音视频时长，单位秒
}

export enum MessageTypeEnum {
  TEXT,
  IMAGE,
  AUDIO,
  VIDEO,
  LOCATION,
  LINK
}
export class IMessageInfoModel implements IMessageInfo {
  id: string = ''
  messageContent: string = ''
  sendUser: IUserInfo = new IUserInfoModel({} as IUserInfo)
  receiveUser: IUserInfo = new IUserInfoModel({} as IUserInfo)
  messageOwner: IUserInfo = new IUserInfoModel({} as IUserInfo)
  sendTime: number = 0
  messageType: MessageTypeEnum = MessageTypeEnum.TEXT
  sourceFilePath: string = ''
  sourceDuration: number = 0

  constructor(model: IMessageInfo) {
    this.id = model.id || util.generateRandomUUID()
    this.messageContent = model.messageContent
    this.sendUser = model.sendUser
    this.receiveUser = model.receiveUser
    this.messageOwner = model.messageOwner
    this.sendTime = model.sendTime || Date.now()
    this.messageType = model.messageType || MessageTypeEnum.TEXT
    this.sourceFilePath = model.sourceFilePath
    this.sourceDuration = model.sourceDuration
  }
}
