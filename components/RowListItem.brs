sub init()
  m.itemposter = m.top.findNode("rowListPoster")
  m.itemtitle = m.top.findNode("rowListTitle")
  m.itemsubtitle = m.top.findNode("rowListSubitle")
  m.itemdescription = m.top.findNode("rowListDescription")
  m.posterInfo = m.top.findNode("posterInfo")

  m.itemposter.observeField("loadStatus", "loadedImages")
  'm.itemposter.observeField("focusPercent", "onFocusedChild")

  m.rowitemmask = m.top.findNode("rowItemMask")
end sub


sub loadedImages()
  brokenImage = "https://cdn2.iconfinder.com/data/icons/antivirus-internet-security/33/broken_shortcut-128.png"
  if m.itemposter.loadStatus = "failed"
    m.itemposter.uri = brokenImage
  end if
end sub


sub showcontent()

  m.itemcontent = m.top.itemContent

  m.itemposter.uri = m.itemcontent.image
  m.itemtitle.text = m.itemcontent.title
  m.itemdescription.text = m.itemcontent.description
  m.itemsubtitle.text = m.itemcontent.subtitle
  m.itemposter.width = m.top.width
  m.itemposter.height = m.top.height

  if m.itemcontent.parentCategory = "Bonanza"
    m.posterInfo.visible = true
  else
    m.rowitemmask.visible = false
  end if

end sub


sub focusPercentChanged()

  if not m.itemcontent = invalid
    if m.itemcontent.parentCategory = "Bonanza"
      m.rowitemmask.opacity = 0.75 - (m.top.focusPercent * 0.75)
    end if
  end if

end sub
