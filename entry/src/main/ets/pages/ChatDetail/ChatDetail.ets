import { router } from '@kit.ArkUI'
import { ChatGalaxyCurrentUserKey } from '../../constants'
import { IMessageInfo, IMessageInfoModel } from '../../models/message.type'
import { IUserInfo, IUserInfoModel } from '../../models/user.type'
import ChatGalaxyStore from '../../utils/ChatGalaxyStore'
import { getChatMessage } from '../../utils/request'
import BottomInput from './components/BottomInput'
import Message from './components/Message'

@Entry
@Component
struct ChatDetail {

  @StorageProp(ChatGalaxyCurrentUserKey)
  currentUser: IUserInfoModel = new IUserInfoModel({} as IUserInfo)

  @Provide
  talkUser: IUserInfoModel = new IUserInfoModel({} as IUserInfo)

  @State
  messageList: IMessageInfoModel[] = []

  listScroller: Scroller = new Scroller()

  aboutToAppear(): void {
    this.getTalkUser()
  }

  getTalkerUserMessageList() {
    const messageList = ChatGalaxyStore.getUserChatRecordsSync(this.talkUser)
    this.messageList = messageList
  }

  getTalkUser() {
    this.talkUser = router.getParams() as IUserInfoModel
    this.getTalkerUserMessageList()
  }

  async textInputContentSubmit(content: string) {
    const message = new IMessageInfoModel({
      messageContent: content,
      sendUser: this.currentUser,
      receiveUser: this.talkUser,
      messageOwner: this.talkUser
    } as IMessageInfo)
    this.messageList.push(message)
    this.listScroller.scrollEdge(Edge.Bottom)
    await ChatGalaxyStore.putUserChatRecords(this.talkUser, this.messageList)
    const res = await getChatMessage(content, this.currentUser)
    const resMessage = new IMessageInfoModel({
      messageContent: res?.data?.info?.text,
      sendUser: this.talkUser,
      receiveUser: this.currentUser,
      messageOwner: this.talkUser
    } as IMessageInfo)
    this.messageList.push(resMessage)
    this.listScroller.scrollEdge(Edge.Bottom)
    ChatGalaxyStore.putUserChatRecord(this.talkUser, resMessage)
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

      List({ scroller: this.listScroller }) {
        ForEach(this.messageList, (item: IMessageInfoModel) => {
          ListItem() {
            Message({
              messageInfo: item,
            })
          }
        })
      }.layoutWeight(1)
      .width("100%")
      .backgroundColor($r("app.color.second_back_color"))
      .onAreaChange(() => {
        this.listScroller.scrollEdge(Edge.Bottom)
      })

      BottomInput({
        textInputContentSubmit: (content: string) => {
          this.textInputContentSubmit(content)
        }
      })
    }
    .justifyContent(FlexAlign.SpaceBetween)
    .height('100%')
    .width('100%')
  }
}