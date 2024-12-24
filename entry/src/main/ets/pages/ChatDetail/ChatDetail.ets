import { router } from '@kit.ArkUI'
import { ChatGalaxyCurrentUserKey } from '../../constants'
import { IUserInfo, IUserInfoModel } from '../../models/user.type'
import BottomInput from './components/BottomInput'
import Message from './components/Message'

@Entry
@Component
struct ChatDetail {

  @StorageProp(ChatGalaxyCurrentUserKey)
  currentUser: IUserInfoModel = new IUserInfoModel({} as IUserInfo)

  @Provide
  talkUser: IUserInfoModel = new IUserInfoModel({} as IUserInfo)

  aboutToAppear(): void {
    this.getTalkUser()
  }

  getTalkUser() {
    this.talkUser = router.getParams() as IUserInfoModel
  }

  build() {
    Column () {
      Stack({ alignContent: Alignment.Start }) {
        Image($r("app.media.ic_public_arrow_left"))
          .width(30)
          .height(30)
          .zIndex(2)
          .onClick(() => {
            router.back()
          })

        Text(this.talkUser.username)
          .fontColor($r("app.color.text_primary"))
          .fontSize(20)
          .width("100%")
          .textAlign(TextAlign.Center)
          .height(30)
      }.height(50)
      .width("100%")

      List() {
        ForEach([1,2,3], () => {
          Message()
        })
      }.layoutWeight(1)
      .width("100%")
      .backgroundColor($r("app.color.second_back_color"))

      BottomInput()
    }
    .justifyContent(FlexAlign.SpaceBetween)
    .height('100%')
    .width('100%')
  }
}