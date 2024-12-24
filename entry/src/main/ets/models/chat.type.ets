
export interface IChatMessageInfo {
  success: string
  data: IChatDataInfo
}

export interface IChatDataInfo {
  type: number
  info: IChatInfo
}

export interface IChatInfo {
  text: string
}