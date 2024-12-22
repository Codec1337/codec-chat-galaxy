export interface IUserInfo {
  username: string
  avatar: ResourceStr
  user_id: string
}
export class IUserInfoModel implements IUserInfo {
  username: string = ''
  avatar: ResourceStr = ''
  user_id: string = ''

  constructor(model: IUserInfo) {
    this.username = model.username
    this.avatar = model.avatar
    this.user_id = model.user_id
  }
}
