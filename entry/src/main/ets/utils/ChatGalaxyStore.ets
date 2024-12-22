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
  static getUserConnectSync(context?: Context): IUserInfoModel[] {
    const store = ChatGalaxyStore.getChatGalaxyStoreSync(context)
    return JSON.parse(store.getSync(ChatGalaxyUserConnectKey, JSON.stringify(defaultConnectList) as string) as string) as IUserInfoModel[]
  }
  static getCurrentUserSync(context?: Context): IUserInfoModel {
    const store = ChatGalaxyStore.getChatGalaxyStoreSync(context)
    return JSON.parse(store.getSync(ChatGalaxyCurrentUserKey, JSON.stringify(defaultCurrentUser) as string) as string) as IUserInfoModel
  }
}