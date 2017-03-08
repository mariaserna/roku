Sub initTask()

  requestData = createObject("roUrlTransfer")

  requestData.SetCertificatesFile("common:/certs/ca-bundle.crt")
  requestData.AddHeader("X-Roku-Reserved-Dev-Id", "")
  requestData.InitClientCertificates()

  requestData.setUrl("https://ratiointeractive.github.io/Roku-DeveloperDocs/api.json")

  m.responseData = ParseJson(requestData.GetToString())

  m.top.responseAssocArray = setRowListContent()
  m.top.responseVideoContent = setVideoContent()
  '?"setVideoContent()";setVideoContent()

End Sub

function setRowListContent() as object
    data = CreateObject("roSGNode", "ContentNode")

    for each key in m.responseData
      row = data.CreateChild("ContentNode")
      row.title = key

        for each item in m.responseData[key].items
          rowItem = row.CreateChild("RowListItemData")

          rowItem.title = item.title
          rowItem.subtitle = item.subtitle
          rowItem.description = item.description
          rowItem.image = item.image
          rowItem.video = item.video
          rowItem.parentCategory = m.responseData[key].title
        end for
    end for
    
    return data
end function

function setVideoContent() as object

  videoContent = []

  for each key in m.responseData
        rowItems = []
        for each item in m.responseData[key].items
          rowItems.push(item.video)
        end for
        videoContent.push(rowItems)
  end for

  return videoContent
end function
