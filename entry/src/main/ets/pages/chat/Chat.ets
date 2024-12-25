import { IMessageInfoModel } from "../../models/message.type"
import ChatGalaxyStore from "../../utils/ChatGalaxyStore"
import dayjs from "dayjs"
import { router } from "@kit.ArkUI"

@Component
struct Chat {
  @State recordList: IMessageInfoModel[] = []

  aboutToAppear(): void {
    this.getRecordList()
  }

  formatTime(timestamp: number): string {
    return dayjs(timestamp).format("HH:mm")
  }

  getRecordList() {
    this.recordList = ChatGalaxyStore.getAllUserLastRecordSync()
  }

  build() {
    Column() {
      Text("聊天")
        .width("100%")
        .textAlign(TextAlign.Center)
        .padding({
          top: 10,
          bottom: 10,
        })
      List({ space: 16 }) {
        ForEach(this.recordList, (item: IMessageInfoModel) => {
          ListItem() {
            Row({ space: 10 }) {
              Image(item.messageOwner.avatar)
                .width(36)
                .height(36)
                .borderRadius(2)
              Column({ space: 2 }) {
                Text(item.messageOwner.username)
                  .fontColor($r("app.color.text_primary"))

                Text(item.messageContent)
                  .fontSize(14)
                  .fontColor($r("app.color.text_second"))
                  .textOverflow({ overflow: TextOverflow.Ellipsis })
                  .maxLines(1)
              }.alignItems(HorizontalAlign.Start)
              .layoutWeight(1)
              Text(this.formatTime(item.sendTime))
                .fontSize(14)
                .fontColor($r("app.color.text_second"))
                .width(60)
                .textAlign(TextAlign.End)
            }.width("100%")

          }.width("100%")
          .padding({
            left: 10,
            right: 10,
          })
          .onClick(() => {
            router.pushUrl({
              url: "pages/ChatDetail/ChatDetail",
              params: item.messageOwner
            })
          })
        })
      }.layoutWeight(1)
      .width("100%")
      .divider({
        strokeWidth: 1,
        color: $r("app.color.border_color")
      })
    }.height("100%")
    .width("100%")
  }
}

export default Chat
