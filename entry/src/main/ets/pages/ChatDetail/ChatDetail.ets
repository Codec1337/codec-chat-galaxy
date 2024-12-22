import { router } from '@kit.ArkUI'
import { ChatGalaxyCurrentUserKey } from '../../constants'
import { IUserInfo, IUserInfoModel } from '../../models/user.type'

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
      Text(JSON.stringify(this.currentUser))
    }
    .height('100%')
    .width('100%')
  }
}