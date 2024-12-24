import { http } from "@kit.NetworkKit"
import { IUserInfo } from "../models/user.type"
import { JSON } from "@kit.ArkTS"
import { IMessageInfoModel } from "../models/message.type"
import { IChatMessageInfo } from "../models/chat.type"
import { promptAction } from "@kit.ArkUI"

const toastDuration = 3000

export const getChatMessage = async (content:string, user: IUserInfo) => {
  const req = http.createHttp()
  try {
    const res = await req.request(`https://api.ownthink.com/bot?userid=${user.user_id}_${Date.now()}&spoken=${encodeURIComponent(content)}`)
    return JSON.parse(res.result as string) as IChatMessageInfo

  } catch (error) {
    promptAction.showToast({
      message: error?.message,
      duration: toastDuration
    })
    return Promise.reject(error)
  } finally {
    req.destroy()
  }
}