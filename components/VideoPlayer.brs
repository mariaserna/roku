Sub init()
  m.video = m.top
  m.timer = m.top.findNode("timerItem")
  m.timer.duration = 2

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
      m.timer.control = "start"
      m.timer.repeat = "true"
      m.videoPosition = m.video.position
      m.timer.ObserveField("fire","forwardVideo")

      handled = true
    else if key = "rewind"
      rewindVideo()
      handled = true
    end if
  end if

  if NOT press
    if key = "fastforward"
      m.timer.control = "stop"
      m.forwardButton.opacity = "1"
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
  m.videoPosition = m.videoPosition + 5
  m.video.seek = m.videoPosition
  m.forwardButton.opacity = "0.4"
  ?m.videoPosition
End Sub

Sub rewindVideo()
  rewardedPosition = m.video.position - 10
  m.video.seek = rewardedPosition
  m.rewindButton.opacity = "0.4"
End Sub

Sub stateHasChanged()
  ?m.video.state

  if m.video.state = "playing"
    'set total time when video started playing
    m.totalTime.text = formatTime(m.video.duration)
    'restore button opacity
    m.rewindButton.opacity = "1"

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
