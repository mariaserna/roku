Sub init()
  m.video = m.top
  m.timer = m.top.findNode("timerItem")
  m.timer.repeat = true
  m.ProgressBar = m.top.findNode("progressBarItem")
  m.playButton = m.top.findNode("PauseButtonPoster")
  m.pauseButton = m.top.findNode("PlayButtonPoster")
  m.forwardButton = m.top.findNode("ForwardButtonPoster")
  m.rewindButton = m.top.findNode("RewindButtonPoster")
  m.totalTime = m.top.findNode("totalTime")
  m.currentTime = m.top.findNode("currentTime")
  m.video.observeField("position", "positionHasChanged")
  m.video.observeField("state", "stateHasChanged")
End Sub

function onKeyEvent(key as String, press as Boolean) as Boolean
  handled = false
  if press
    if key = "play"
      pauseVideo()
      handled = true
    else if key = "fastforward"
      m.forward = true
      m.timer.control = "start"
      navigateVideo()
      m.timer.ObserveField("fire","navigateVideo")
      handled = true
    else if key = "rewind"
      m.forward = false
      m.timer.control = "start"
      navigateVideo()
      m.timer.ObserveField("fire","navigateVideo")
      handled = true
    end if
  end if

  if NOT press
    if key = "fastforward"
      m.forward = false
      m.timer.control = "stop"
      m.forwardButton.opacity = "1"
      handled = true
    else if key = "rewind"
      m.timer.control = "stop"
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

Sub navigateVideo()
  if m.forward = true
    m.forwardButton.opacity = "0.4"
    m.video.position = m.video.position + 10
  else
    m.rewindButton.opacity = "0.4"
    m.video.position = m.video.position - 10
  end if
  m.video.seek = m.video.position
  m.ProgressBar.width = (m.video.position * 600 ) / m.video.duration
  m.currentTime.text = formatTime(m.video.position)
End Sub

Sub stateHasChanged()
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

    if m.video.state = "finished"
      m.video.visible = false
      m.video.control = "stop"
    end if
End Sub

Sub positionHasChanged()
  m.currentTime.text = formatTime(m.video.position)
  m.ProgressBar.width = (m.video.position * 600 ) / m.video.duration
End Sub

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
