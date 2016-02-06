jQuery ->
  $(document).on "upload:start", "form", (e) ->
    $(this).find("input[type=submit]").attr "disabled", true
    $("#image").text("Uploading...")

  $(document).on "upload:progress", "form", (e) ->
    detail          = e.originalEvent.detail
    percentComplete = Math.round(detail.loaded / detail.total * 100)
    $("#image").text("#{percentComplete}% uploaded")

  $(document).on "upload:success", "form", (e) ->
    $(this).find("input[type=submit]").removeAttr "disabled"  unless $(this).find("input.uploading").length

    image_value = JSON.parse $("[id$=_image_cache_id]").val()
    $("#image").html $("<img />").attr('src', "/attachments/cache/fit/150/150/#{image_value.id}/image")
