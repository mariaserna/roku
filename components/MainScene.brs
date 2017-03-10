Sub init()
  m.myrowlist = m.top.findNode("myRowList")
  m.video = m.top.findNode("VideoItem")
  'Observe when a row item is focused and selected
  m.dataTask = createObject("RoSGNode", "GetDataTask")
  m.dataTask.functionName = "initTask"
  m.dataTask.control = "RUN"
  m.dataTask.observeField("responseContentNode", "onLoadedData")
end Sub


Sub onLoadedData()
  m.myrowlist.setFocus(true)
  m.myrowlist.content = m.dataTask.responseContentNode
  m.top.observeField("rowItemFocused","SetCurrentVideo")
  m.top.observeField("rowItemSelected", "PlayCurrentVideo")
End Sub

Sub SetCurrentVideo()
  itemFocused = m.myrowlist.rowItemFocused
  videoContent = createObject("RoSGNode", "ContentNode")
  row = m.myrowlist.content.getChild(itemFocused[0])
  videoContent.streamformat = "hls"

  if row <> invalid
      item = row.getChild(itemFocused[1])

      if item <> invalid
          videoContent.url = item.video
      end if
  end if

  m.video.content = videoContent
  m.video.control = "prebuffer"
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
