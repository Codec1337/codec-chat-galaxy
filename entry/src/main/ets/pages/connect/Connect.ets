import { IUserInfoModel } from "../../models/user.type"
import ChatGalaxyStore from "../../utils/ChatGalaxyStore"
import { router } from "@kit.ArkUI"

@Preview
@Component
struct Connect {
  @State
  userList: IUserInfoModel[] = []

  @State
  filterUserList: IUserInfoModel[] = []

  @State
  @Watch("updateFilterUserList")
  searchText: string = ""

  aboutToAppear(): void {
    this.getUserList()
  }

  getUserList() {
    this.userList = ChatGalaxyStore.getUserConnectSync()
    this.updateFilterUserList()
  }

  updateFilterUserList() {
    if (this.searchText) {
      this.filterUserList = this.userList.filter(u => {
        return u.username.includes(this.searchText)
      })
      return
    }
    this.filterUserList = this.userList
  }

  build() {
    Column() {
      Row() {
        Search({ placeholder: "搜索", value: $$this.searchText })
          .height(40)
          .borderRadius(4)
          .backgroundColor($r("app.color.white"))
          .fontColor($r("app.color.text_primary"))
      }.padding({
        left: 10,
        right: 10
      })
      .height(50)
      List() {
        ForEach(this.filterUserList, (userItem: IUserInfoModel) => {
          ListItem() {
            Row({ space: 10 }) {
              Image(userItem.avatar)
                .width(30)
                .height(30)
                .borderRadius(2)
              Text(userItem.username)
            }.width("100%")
          }.height(60)
          .width("100%")
          .stateStyles({
            pressed: {
              .backgroundColor(Color.Gray)
            },
            normal: {
              .backgroundColor($r("app.color.white"))
            }
          })
          .onClick(() => {
            router.pushUrl({
              url: "pages/ChatDetail/ChatDetail",
              params: userItem
            })
          })
        })
      }.width("100%")
      .height("100%")
      .padding({
        left: 10,
        right: 10
      })
      .divider({
        strokeWidth: 1,
        color: $r("app.color.border_color")
      })
      .backgroundColor($r("app.color.white"))
    }.width("100%")
    .height("100%")
    .backgroundColor($r("app.color.back_color"))
  }
}

export default Connect
