Sub init()
  m.video = m.top
  m.timerFd = m.top.findNode("timerForward")
  m.timerRw = m.top.findNode("timerRewind")
  'm.timer.duration = 1
  m.timerFd.repeat = true
  m.timerRw.repeat = true

  m.playButton = m.top.findNode("PauseButtonPoster")
  m.pauseButton = m.top.findNode("PlayButtonPoster")
  m.forwardButton = m.top.findNode("ForwardButtonPoster")
  m.rewindButton = m.top.findNode("RewindButtonPoster")
  m.totalTime = m.top.findNode("totalTime")
  m.currentTime = m.top.findNode("currentTime")
  m.video.observeField("position", "positionHasChanged")
  m.video.observeField("state", "stateHasChanged")
end Sub

function onKeyEvent(key as String, press as Boolean) as Boolean
  handled = false
  if press

    if key = "play"
      pauseVideo()
      handled = true
    else if key = "fastforward"
      m.timerFd.control = "start"
      m.videoPosition = m.video.position
      forwardVideo()
      m.timerFd.ObserveField("fire","forwardVideo")
      handled = true
    else if key = "rewind"
      m.timerRw.control = "start"
      m.videoPosition = m.video.position
      rewindVideo()
      m.timerRw.ObserveField("fire","rewindVideo")
      handled = true
    end if
  end if

  if NOT press
    if key = "fastforward"
      m.timerFd.control = "stop"
      m.forwardButton.opacity = "1"
      handled = true
    else if key = "rewind"
      m.timerRw.control = "stop"
      m.rewindButton.opacity = "1"
      handled = true
    end if
  end if
  return handled
end function

Sub pauseVideo()
  if m.video.control = "pause"
    m.video.control = "resume"
  else
    m.video.control = "pause"
  end if
End Sub

Sub forwardVideo()
  m.forwardButton.opacity = "0.4"
  m.videoPosition = m.videoPosition + 10
  m.video.seek = m.videoPosition
End Sub

Sub rewindVideo()
  m.rewindButton.opacity = "0.4"
  m.videoPosition = m.videoPosition - 10
  m.video.seek = m.videoPosition
End Sub

Sub stateHasChanged()
  ?m.video.state

  if m.video.state = "playing"
    'set total time when video started playing
    m.totalTime.text = formatTime(m.video.duration)

  else if m.video.state = "stopped"
    'restore total time when video stoped.
    m.totalTime.text = "00:00:00"
  end if

  if m.video.state = "paused"
    m.playButton.visible = false
    m.pauseButton.visible = true
  else
    m.playButton.visible = true
    m.pauseButton.visible = false
  end if
end Sub

Sub positionHasChanged()
  m.currentTime.text = formatTime(m.video.position)
end Sub

Function formatTime(time As Integer)

  currentTimeFormat = time

  hours = Int(currentTimeFormat / 3600).ToStr()
  rest = currentTimeFormat Mod 3600
  minutes = Int(rest / 60).ToStr()
  rest = rest Mod 60
  seconds = rest.ToStr()
  timeString = hours + ":" + minutes + ":" + seconds
  return timeString

End Function
