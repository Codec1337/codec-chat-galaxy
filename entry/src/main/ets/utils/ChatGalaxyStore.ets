import { preferences } from "@kit.ArkData";
import { ChatGalaxyCurrentUserKey, ChatGalaxyStoreKey, ChatGalaxyUserConnectKey,
  ChatGalaxyUserRecordPrefixKey } from "../constants";
import { IMessageInfoModel } from "../models/message.type";
import { defaultConnectList, defaultCurrentUser } from "../models/user";
import { IUserInfoModel } from "../models/user.type";
import { promptAction } from "@kit.ArkUI";

export default class ChatGalaxyStore {
  static getChatGalaxyStoreSync(context?: Context) {
    return preferences.getPreferencesSync(context || getContext(), {
      name: ChatGalaxyStoreKey
    })
  }
  // 获取用户好友列表
  static getUserConnectSync(context?: Context): IUserInfoModel[] {
    const store = ChatGalaxyStore.getChatGalaxyStoreSync(context)
    return JSON.parse(store.getSync(ChatGalaxyUserConnectKey, JSON.stringify(defaultConnectList) as string) as string) as IUserInfoModel[]
  }
  // 获取当前用户信息
  static getCurrentUserSync(context?: Context): IUserInfoModel {
    const store = ChatGalaxyStore.getChatGalaxyStoreSync(context)
    return JSON.parse(store.getSync(ChatGalaxyCurrentUserKey, JSON.stringify(defaultCurrentUser) as string) as string) as IUserInfoModel
  }
  // 获取和某一用户聊天信息列表
  static getUserChatRecordsSync(user: IUserInfoModel) {
    const store = ChatGalaxyStore.getChatGalaxyStoreSync()
    return JSON.parse(store.getSync(`${ChatGalaxyUserRecordPrefixKey}_${user.user_id}`, "[]") as string) as IMessageInfoModel[]
  }
  // 存储和某一用户聊天信息列表
  static async putUserChatRecords(user: IUserInfoModel, messageList: IMessageInfoModel[]) {
    const store = ChatGalaxyStore.getChatGalaxyStoreSync()
    store.putSync(`${ChatGalaxyUserRecordPrefixKey}_${user.user_id}`, JSON.stringify(messageList))
    await store.flush()
  }
  // 存储和某一用户聊天信息
  static async putUserChatRecord(user: IUserInfoModel, message: IMessageInfoModel) {
    const store = ChatGalaxyStore.getChatGalaxyStoreSync()
    const records = ChatGalaxyStore.getUserChatRecordsSync(user)
    records.push(message)
    await ChatGalaxyStore.putUserChatRecords(user, records)
  }
  // 获取和所有用户的最新的聊天记录
  static getAllUserLastRecord() {
    const store = ChatGalaxyStore.getChatGalaxyStoreSync()
    const allRecord = store.getAllSync() as object
    const arr: IMessageInfoModel[] = []

    Object.keys(allRecord).forEach((key) => {
      if (key.startsWith(ChatGalaxyUserRecordPrefixKey)) {
        if (allRecord[key] as string) {
          // const record = JSON.parse(allRecord[key] as string)

          const records = JSON.parse(allRecord[key]) as IMessageInfoModel[]
          if (records.length > 0) {
            arr.push(records[(records.length - 1) as number] as IMessageInfoModel)
          }

        }
      }
    })
    return arr.sort((a: IMessageInfoModel, b: IMessageInfoModel) => {
      return b.sendTime - a.sendTime
    })
  }
}