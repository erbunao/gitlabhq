formatLink = (str) ->
  "![" + str.alt + "](" + str.url + ")"

$(document).ready ->
  $("textarea.markdown-area").wrap "<div class=\"div-dropzone\"></div>"  
  
  $(".div-dropzone").parent().addClass "div-dropzone-wrapper"

  $(".div-dropzone").append "<div class=\"div-dropzone-hover\">" + "<i class=\"icon-picture div-dropzone-icon\"></i>" + "</div>"
  $(".div-dropzone").append "<div class=\"div-dropzone-spinner\">" + "<i class=\"icon-spinner icon-spin div-dropzone-icon\"></i>" + "</div>"


  dropzone = $(".div-dropzone").dropzone(
    url: project_image_path_upload
    dictDefaultMessage: ""
    clickable: true
    paramName: "markdown-img"
    maxFilesize: 10
    uploadMultiple: false
    acceptedFiles: "image/jpg,image/jpeg,image/gif,image/png"
    headers: 
      "X-CSRF-Token": $("meta[name=\"csrf-token\"]").attr("content")

    dragover: ->
      $(".div-dropzone > textarea").addClass "div-dropzone-focus"
      $(".div-dropzone-hover").css "opacity", 0.7
      return

    dragleave: ->
      $(".div-dropzone > textarea").removeClass "div-dropzone-focus"
      $(".div-dropzone-hover").css "opacity", 0
      return

    drop: ->
      $(".div-dropzone > textarea").removeClass "div-dropzone-focus"
      $(".div-dropzone-hover").css "opacity", 0
      $(".div-dropzone > textarea").focus()
      return

    success: (header, response) ->
      $(".div-dropzone-alert").alert "close"
      child = $(dropzone[0]).children("textarea")
      $(child).val $(child).val() + formatLink(response.link) + "\n"
      return

    error: (temp, errorMessage) ->
      $("p.hint.pull-right").after "<div class=\"alert alert-danger alert-dismissable div-dropzone-alert\">" + "<button type=\"button\" class=\"close\" data-dismiss=\"alert\"" + "aria-hidden=\"true\">&times;</button>" + errorMessage + "</div>"
      return

    sending: ->
      $(".div-dropzone-spinner").css "opacity", 0.7
      return

    complete: ->
      $(".dz-preview").remove()
      $(".markdown-area").trigger "input"
      $(".div-dropzone-spinner").css "opacity", 0
      return
  )

  $(".markdown-selector").click (e) ->
    e.preventDefault()
    $(".div-dropzone").click()
    return

  return