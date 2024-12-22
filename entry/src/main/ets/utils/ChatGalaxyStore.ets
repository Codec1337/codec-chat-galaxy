import { preferences } from "@kit.ArkData";
import { ChatGalaxyStoreKey, ChatGalaxyUserConnectKey } from "../constants";
import { defaultConnectList } from "../models/user";
import { IUserInfoModel } from "../models/user.type";

export default class ChatGalaxyStore {
  static getChatGalaxyStoreSync(context?: Context) {
    return preferences.getPreferencesSync(context || getContext(), {
      name: ChatGalaxyStoreKey
    })
  }
  static getUserConnectSync(): IUserInfoModel[] {
    const store = ChatGalaxyStore.getChatGalaxyStoreSync()
    return JSON.parse(store.getSync(ChatGalaxyUserConnectKey, JSON.stringify(defaultConnectList) as string) as string) as IUserInfoModel[]
  }
}