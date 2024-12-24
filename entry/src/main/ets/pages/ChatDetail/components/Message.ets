import { ChatGalaxyCurrentUserKey } from "../../../constants"
import { IMessageInfo, IMessageInfoModel } from "../../../models/message.type"
import { IUserInfo, IUserInfoModel } from "../../../models/user.type"

@Preview
@Component
struct Message {


  @StorageProp(ChatGalaxyCurrentUserKey)
  currentUser: IUserInfoModel = new IUserInfoModel({} as IUserInfo)

  @Require
  @Prop
  messageInfo: IMessageInfoModel = new IMessageInfoModel({} as IMessageInfo)

  @State
  isCurrentUserMessage: boolean = this.messageInfo?.sendUser?.user_id === this.currentUser?.user_id

  build() {
    Row({ space: 6 }) {
      Image("https://q1.itc.cn/q_70/images03/20240414/d477378709494a9e8adf154fb5200feb.jpeg")
        .width(25)
        .height(25)
        .borderRadius(2)
      Row() {
        Text("你好呀你好呀你好呀你好呀你好呀你好呀你好呀你好呀你好呀你好呀你好呀你好呀你好呀你好呀")
          .fontSize(14)
          .backgroundColor(this.isCurrentUserMessage ? $r("app.color.second_primary") : $r("app.color.white"))
          .padding({
            left: 10,
            right: 10,
            top: 6,
            bottom: 6
          })
          .lineHeight(18)
          .borderRadius(4)
      }.layoutWeight(7)
      .justifyContent(this.isCurrentUserMessage ? FlexAlign.End : FlexAlign.Start)
      Row()
        .layoutWeight(1)
    }.width("100%")
    .padding({
      left: 20,
      right: 20,
      top: 10,
      bottom: 10
    })
    .alignItems(VerticalAlign.Top)
    .direction(this.isCurrentUserMessage ? Direction.Rtl : Direction.Ltr)
  }
}

export default Message
