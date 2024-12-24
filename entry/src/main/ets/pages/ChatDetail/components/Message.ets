import { ChatGalaxyCurrentUserKey } from "../../../constants"
import { IUserInfo, IUserInfoModel } from "../../../models/user.type"

@Preview
@Component
struct Message {


  @StorageProp(ChatGalaxyCurrentUserKey)
  currentUser: IUserInfoModel = new IUserInfoModel({} as IUserInfo)

  @State
  isCurrentUserMessage: boolean = false

  build() {
    Row({ space: 6 }) {
      Image("https://q1.itc.cn/q_70/images03/20240414/d477378709494a9e8adf154fb5200feb.jpeg")
        .width(25)
        .height(25)
        .borderRadius(2)
      Row() {
        Text("你好呀")
          .fontSize(14)
          .backgroundColor(this.isCurrentUserMessage ? $r("app.color.second_primary") : $r("app.color.white"))
          .padding({
            left: 10,
            right: 10,
            top: 6,
            bottom: 6
          })
          .borderRadius(4)
      }.layoutWeight(1)
      .justifyContent(this.isCurrentUserMessage ? FlexAlign.End : FlexAlign.Start)
    }.width("100%")
    .padding({
      left: 20,
      right: 20,
      top: 10,
      bottom: 10
    })
    .direction(this.isCurrentUserMessage ? Direction.Rtl : Direction.Ltr)
  }
}

export default Message
