$(document).ready ->

  reply_button  = $('.btn-reply')
  cancel_button = $('.btn-cancel-reply')

  reply_button.on 'ajax:complete', (e, xhr)->
    e.preventDefault
    $(this).hide(0)
    $(this).parent('p').prev('.reply-field').html(xhr.responseText)

  cancel_button.live 'click', (e)->
    e.preventDefault
    $('.reply-field').empty()
    reply_button.show(0)