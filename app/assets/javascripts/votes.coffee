$(document).bind 'ajax:success', (e, data, status, xhr) ->
  json = $.parseJSON(xhr.responseText)
  votable = json.votable
  type = json.resource
  vote = json.vote
  vote_value = json.vote_value
  votable_with_id = type + '-' + votable.id
  if vote
    $('#vote-' + votable_with_id).html("You " + vote_value + " it")
  else
    $('#vote-' + votable_with_id).html('')
  $('#rate-' + votable_with_id).html(votable.rating)
  $('form#vote-' + votable_with_id).toggle()
  $('form#cancel-vote-' + votable_with_id).toggle()
