sub Main()
  port = CreateObject("roMessagePort")
  screen = CreateObject("roSGScreen")
  scene = screen.CreateScene("MainScene")


  screen.setMessagePort(port)
  screen.show()

  'scene.setFocus(true)
  scene.backgroundUri = ""
  scene.backgroundColor = "0x000000"
  scene.id = "myScene"

  while true
      msg = wait(0, port)

      if type(msg) = "roSGScreenEvent"
          if msg.isScreenClosed() then return
      end if
  end while
end sub
