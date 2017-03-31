Sub init()
  m.itemposter = m.top.findNode("rowListPoster")
  m.itemtitle = m.top.findNode("rowListTitle")
  m.itemSubtitle = m.top.findNode("rowListSubitle")
  m.itemdescription = m.top.findNode("rowListDescription")
  m.posterInfo = m.top.findNode("posterInfo")
  m.itemposter.observeField("loadStatus", "loadedImages")
  m.itemOpacity = 0.2
end Sub


Sub loadedImages()
  brokenImage = "https://cdn2.iconfinder.com/data/icons/antivirus-internet-security/33/broken_shortcut-128.png"
  if m.itemposter.loadStatus = "failed"
    m.itemposter.uri = brokenImage
  end if
end Sub


Sub showcontent()

  m.itemcontent = m.top.itemContent
  m.itemposter.uri = m.itemcontent.image
  m.itemtitle.text = m.itemcontent.title
  m.itemdescription.text = m.itemcontent.description
  m.itemSubtitle.text = m.itemcontent.Subtitle
  m.itemposter.width = m.top.width
  m.itemposter.height = m.top.height

  if m.top.rowIndex = 0
    m.posterInfo.visible = true
    m.top.opacity = m.itemOpacity
  end if

end Sub


Sub focusPercentChanged()
  if m.top.rowIndex = 0
    m.top.opacity = m.itemOpacity + (m.top.focusPercent * 0.8)
  end if
end Sub
