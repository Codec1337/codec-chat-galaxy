import { preferences } from "@kit.ArkData";
import { ChatGalaxyCurrentUserKey, ChatGalaxyStoreKey, ChatGalaxyUserConnectKey } from "../constants";
import { defaultConnectList, defaultCurrentUser } from "../models/user";
import { IUserInfoModel } from "../models/user.type";

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
}