sendFile = (files, toSummernote) ->
  data = new FormData
  for file in files
    data.append 'upload[images][]', file
  $.ajax
    data: data
    type: 'POST'
    url: '/uploads'
    cache: false
    contentType: false
    processData: false
    success: (data) ->
      picUrls = data.url.split ","
      picIds = data.upload_id.split ","
      count = data.count
      for i in [0...count]
        img = document.createElement('IMG')
        img.src = picUrls[i]
        console.log data
        img.setAttribute('id', "sn-image-#{picIds[i]}")
        toSummernote.summernote 'insertNode', img

deleteFile = (file_id, file_name) ->
  data = new FormData
  data.append 'file_name', file_name
  $.ajax
    data: data
    type: 'DELETE'
    url: "/uploads/#{file_id}"
    cache: false
    contentType: false
    processData: false

$(document).on 'turbolinks:load', ->
  $('[data-provider="summernote"]').each ->
    $(this).summernote
      lang: 'ko-KR'
      height: 400
      placeholder: '이미지 삭제 시 휴지통 아이콘을 이용해주세요.
      한 번 삭제된 이미지는 복원이 불가능합니다.
      다시 이미지를 첨부해주세요.'
      callbacks:
        onImageUpload: (files) ->
            sendFile files, $(this)
        onMediaDelete: (target, editor, editable) ->
          upload_id = target[0].id.split('-').slice(-1)[0]
          file_name = target[0].src.split('/').slice(-1)[0]
          console.log upload_id
          console.log file_name
          if !!upload_id
            deleteFile upload_id, file_name
          target.remove()
