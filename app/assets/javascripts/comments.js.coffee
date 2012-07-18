$(document).ready ->

  reply_button  = $('.btn-reply')
  cancel_button = $('.btn-cancel-reply')
  upvote = $('.comment .up')
  downvote = $('.comment .down')

  reply_button.on 'ajax:complete', (e, xhr)->
    e.preventDefault
    $(this).hide(0)
    $(this).parent('p').prev('.reply-field').html(xhr.responseText)

  cancel_button.live 'click', (e)->
    e.preventDefault
    $('.reply-field').empty()
    reply_button.show(0)

  upvote.on 'ajax:complete', (e, xhr)->
    response = $.parseJSON(xhr.responseText)
    votePanel = $(this).closest('.vote-panel')
    votePanel.children('.count').html(response.updated_count)
    if response.status == 'success'
      votePanel.children('.down').removeClass('voted')
      $(this).addClass('voted')

  downvote.on 'ajax:complete', (e, xhr)->
    response = $.parseJSON(xhr.responseText)
    votePanel = $(this).closest('.vote-panel')
    votePanel.children('.count').html(response.updated_count)
    if response.status == 'success'
      votePanel.children('.up').removeClass('voted')
      $(this).addClass('voted')

