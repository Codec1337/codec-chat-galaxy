@Preview
@Component
struct BottomInput {

  @State
  textInputContent: string = ""

  textInputContentSubmit: (content: string) => void = () => {}

  build() {
    Row({ space: 10 }) {
      Image($r("app.media.ic_public_sound"))
        .width(25)
      TextInput({ text: $$this.textInputContent })
        .layoutWeight(1)
        .backgroundColor($r("app.color.white"))
        .borderRadius(2)
        .onSubmit(() => {
          if (this.textInputContent) {
            this.textInputContentSubmit(this.textInputContent)
            this.textInputContent = ""
          }
        })

      Image($r("app.media.ic_public_add_norm"))
        .width(25)
    }.height(60)
    .width("100%")
    .backgroundColor($r("app.color.second_back_color"))
    .padding({
      left: 10,
      right: 10
    })
  }
}

export default BottomInput
