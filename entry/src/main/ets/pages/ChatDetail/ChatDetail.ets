@Entry
@Component
struct ChatDetail {

  build() {
    Column () {
      Stack({ alignContent: Alignment.Start }) {
        Image($r("app.media.ic_public_arrow_left"))
          .width(30)
          .height(30)
        Text("小果果")
          .fontColor($r("app.color.text_primary"))
          .fontSize(20)
          .width("100%")
          .textAlign(TextAlign.Center)
          .height(30)
      }.height(50)
      .width("100%")
    }
    .height('100%')
    .width('100%')
  }
}