Sub init()
  m.myrowlist = m.top.findNode("myRowList")
  m.video = m.top.findNode("VideoItem")
  m.playButton = m.top.findNode("PauseButtonPoster")
  m.pauseButton = m.top.findNode("PlayButtonPoster")
  m.totalTime = m.top.findNode("totalTime")
  m.currentTime = m.top.findNode("currentTime")

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
    if key = "back" OR key = "OK"
      backToRowlist()
      handled = true
    else if key = "play"
      handled = true
      pauseVideo()
    else if key = "fastforward"
      handled = true
      forwardedPosition = m.video.position + 10
      m.video.seek = forwardedPosition
      m.currentTime.text = forwardedPosition
    else if key = "rewind"
      handled = true
      rewardedPosition = m.video.position - 10
      m.video.seek = rewardedPosition
      m.currentTime.text = rewardedPosition
    end if
  end if
  return handled
end function

Sub backToRowlist()
  m.video.visible = false
  m.myrowlist.setFocus(true)
  m.video.control = "stop"
  m.totalTime.text = "0 s"
End Sub

Sub pauseVideo()
  if m.video.control = "pause"
    m.video.control = "resume"
  else
    m.video.control = "pause"
  end if
End Sub

Sub stateHasChanged()
  if m.video.state = "playing"
    m.totalTime.text = m.video.duration.ToStr() + " s"
  end if

  if m.video.state = "paused"
    m.playButton.visible = "false"
    m.pauseButton.visible = "true"
  else
    m.playButton.visible = "true"
    m.pauseButton.visible = "false"
  end if
end Sub

Sub positionHasChanged()
  m.currentTime.text = m.video.position.ToStr().Left(4) + " s"
end Sub
