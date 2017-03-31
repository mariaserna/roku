Sub initTask()
  requestData = createObject("roUrlTransfer")
  requestData.SetCertificatesFile("common:/certs/ca-bundle.crt")
  requestData.AddHeader("X-Roku-Reserved-Dev-Id", "")
  requestData.InitClientCertificates()
  requestData.setUrl("https://ratiointeractive.github.io/Roku-DeveloperDocs/api.json")
  m.responseData = ParseJson(requestData.GetToString())
  m.top.responseContentNode = rowListContent()
End Sub

function rowListContent() as object
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
        end for
    end for
    return data
end function
