sub init()
  m.myrowlist = m.top.findNode("myRowList")
  m.video = m.top.findNode("VideoItem")

  'Observe when a row item is focused and selected

  m.dataTask = createObject("RoSGNode", "GetDataTask")
  m.dataTask.functionName = "initTask"
  m.dataTask.control = "RUN"
  m.dataTask.observeField("responseAssocArray", "onLoadedData")
  m.dataTask.observeField("responseVideoContent", "onLoadedVideoData")
end sub


Sub onLoadedData()
  '?"Loaded data "m.dataTask.responseAssocArray
  m.myrowlist.content = m.dataTask.responseAssocArray
  m.myrowlist.setFocus(true)
End Sub

Sub onLoadedVideoData()
  'Load first time video
  SetCurrentVideo()

  m.top.observeField("rowItemFocused","SetCurrentVideo")
  m.top.observeField("rowItemSelected", "PlayCurrentVideo")
End sub

Sub SetCurrentVideo()
  itemFocused = m.myrowlist.rowItemFocused
  ''?m.dataTask.responseVideoContent[itemFocused[0]][itemFocused[1]]

  videoContent = createObject("RoSGNode", "ContentNode")
  videoContent.url = m.dataTask.responseVideoContent[itemFocused[0]][itemFocused[1]]
  videoContent.streamformat = "hls"
  m.video.content = videoContent
  m.video.control = "prebuffer"
  '?m.top.rowItemFocused

End Sub

Sub PlayCurrentVideo()
    m.video.control = "play"
    m.video.visible = true
    m.video.setFocus(true)
End Sub


function onKeyEvent(key as String, press as Boolean) as Boolean
  handled = false
  if press
    if key = "back"
      backToRowlist()
      handled = true
    else if key = "right"
      handled = true
    end if
  end if
  return handled
end function

Sub backToRowlist()
  m.video.visible = false
  m.myrowlist.setFocus(true)
  m.video.control = "stop"
End Sub
