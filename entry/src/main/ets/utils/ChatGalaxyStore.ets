import { preferences } from "@kit.ArkData";
import { ChatGalaxyCurrentUserKey, ChatGalaxyStoreKey, ChatGalaxyUserConnectKey,
  ChatGalaxyUserRecordPrefixKey } from "../constants";
import { IMessageInfoModel } from "../models/message.type";
import { defaultConnectList, defaultCurrentUser } from "../models/user";
import { IUserInfoModel } from "../models/user.type";
import { hilog } from "@kit.PerformanceAnalysisKit";

export default class ChatGalaxyStore {
  static getChatGalaxyStoreSync(context?: Context | null, name?: string) {
    return preferences.getPreferencesSync(context || getContext(), {
      name: name || ChatGalaxyStoreKey
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
  static getUserLatestChatRecordSync (key: string) {
    const store = ChatGalaxyStore.getChatGalaxyStoreSync(null, key)
    const records = store.getAllSync() as object;
    const arr = Object.values(records).sort((a: IMessageInfoModel, b: IMessageInfoModel) => b.sendTime - a.sendTime) as IMessageInfoModel[]
    return arr[0] as IMessageInfoModel
  }
  // 获取和某一用户聊天信息列表
  static getUserChatRecordsSync(user: IUserInfoModel) {
    const store = ChatGalaxyStore.getChatGalaxyStoreSync(null, ChatGalaxyStoreKey + user.user_id)
    const records = store.getAllSync() as object;
    return Object.values(records).sort((a: IMessageInfoModel, b: IMessageInfoModel) => a.sendTime - b.sendTime) as IMessageInfoModel[]
  }
  // 存储和某一用户聊天信息列表
  static async putUserChatRecords(user: IUserInfoModel, messageList: IMessageInfoModel[]) {
    let index = 0
    while (index < messageList.length) {
      await ChatGalaxyStore.putUserChatRecord(user, messageList[index])
      index += 1
    }
    return user
  }
  // 存储和某一用户聊天信息
  static async putUserChatRecord(user: IUserInfoModel, message: IMessageInfoModel) {
    const store = ChatGalaxyStore.getChatGalaxyStoreSync(null, ChatGalaxyStoreKey + user.user_id)
    store.putSync(`${ChatGalaxyUserRecordPrefixKey}_${message.id}`, message)
    await store.flush()
  }
  // 获取和所有用户的最新的聊天记录
  static getAllUserLastRecordSync() {
    const users = ChatGalaxyStore.getUserConnectSync()
    const arr: IMessageInfoModel[] = []

    let index = 0;
    while (index < users.length) {
      const record = ChatGalaxyStore.getUserLatestChatRecordSync(ChatGalaxyStoreKey + users[index].user_id)
      if (record) {
        arr.push(record)
      }
      index += 1
    }
    return arr.sort((a: IMessageInfoModel, b: IMessageInfoModel) => {
      return b.sendTime - a.sendTime
    })
  }
}