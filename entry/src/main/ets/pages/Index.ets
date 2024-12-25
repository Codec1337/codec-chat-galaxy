import { TabBarItemModel } from '../models/TabBar.type';
import ChatGalaxyStore from '../utils/ChatGalaxyStore';
import Chat from './chat/Chat';
import Connect from './connect/Connect';

@Entry
@Component
struct Index {
  @State message: string = 'Hello World';

  tabList: TabBarItemModel[] = [{
    icon: $r('app.media.ic_public_message'),
    name: 'chat',
    title: '聊天',
    selectIcon: $r('app.media.ic_public_message_filled')
  }, {
    icon: $r('app.media.ic_public_contacts_group'),
    name: 'connect',
    title: '联系人',
    selectIcon:  $r('app.media.ic_public_contacts_group_filled')
  }, {
    icon: $r('app.media.ic_gallery_discover'),
    name: 'discover',
    title: '发现',
    selectIcon: $r('app.media.ic_gallery_discover_filled')
  }, {
    icon: $r('app.media.ic_public_contacts'),
    name: 'my',
    title: '我的',
    selectIcon: $r('app.media.ic_public_contacts_filled')
  }]
  @State selectTabIndex: number = 0

  @Builder
  TabBarBuilder(item: TabBarItemModel) {
    Column({ space: 4 }) {
      Image(item.name === this.tabList[this.selectTabIndex].name ? item.selectIcon : item.icon)
        .width(20)
        .height(20)
      Text(item.title)
        .fontColor(item.name === this.tabList[this.selectTabIndex].name ? $r('app.color.primary') : $r('app.color.text_primary'))
    }
  }

  build() {
    Column() {
      Tabs({ barPosition: BarPosition.End, index: $$this.selectTabIndex }) {
        ForEach(this.tabList, (item: TabBarItemModel, index: number) => {
          TabContent() {
            if (item.name === 'connect') {
              Connect()
            } else if (item.name === 'chat') {
              Chat()
            } else {
              Text(item.name)
            }
          }.tabBar(this.TabBarBuilder(item))
        })
      }.animationDuration(100)
    }.height("100%")
    .width('100%')
  }
}