$ ->
  "use strict"

  if !document.addEventListener
    return

  document.addEventListener "change", (changeEvent)->
    input = changeEvent.target
    if input.tagName == "INPUT" && input.type == "file" && input.getAttribute("data-direct")
      if !input.files
        return

      file = input.files[0]
      metadataField = input.previousSibling

      dispatchEvent = (name, detail)->
        ev = document.createEvent('CustomEvent')
        ev.initCustomEvent(name, true, false, detail)
        input.dispatchEvent(ev)

      if file
        url = input.getAttribute("data-url")
        fields = JSON.parse(input.getAttribute("data-fields") || "null")

        data = new FormData()

        if fields
          Object.keys(fields).forEach (key)->
            data.append(key, fields[key])

        data.append(input.getAttribute("data-as"), file)

        xhr = new XMLHttpRequest()
        xhr.addEventListener "load", ()->
          input.classList.remove("uploading")
          dispatchEvent("upload:complete", xhr.responseText)
          if ((xhr.status >= 200 && xhr.status < 300) || xhr.status == 304)
            id = input.getAttribute("data-id") || JSON.parse(xhr.responseText).id
            if metadataField
              metadataField.value = JSON.stringify({ id: id, filename: file.name, content_type: file.type, size: file.size })
              input_id = input.getAttribute("data-remote-id")
              metadataField.setAttribute("id", input_id)
            input.removeAttribute("name")
            dispatchEvent("upload:success", xhr.responseText)
          else
            dispatchEvent("upload:failure", xhr.responseText)

        xhr.upload.addEventListener "progress", (progressEvent) ->
          if progressEvent.lengthComputable
            dispatchEvent("upload:progress", progressEvent)

        xhr.open("POST", url, true)
        xhr.send(data)

        input.classList.add("uploading")
        dispatchEvent("upload:start", xhr)
