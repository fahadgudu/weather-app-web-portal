#= require active_admin/base
#= require active_admin/select2
#= require activeadmin-sortable

readURL = (input) ->

  if input.files and input.files[0]
    reader = new FileReader

    reader.onload = (e) ->
      $('.inline-hints img').attr 'src', e.target.result
      $('.inline-hints img').removeClass 'hide'
      return
    reader.readAsDataURL input.files[0]
  return


$(document).ready ->
  $('#product_image, #category_banner_attributes_image, #company_banner_attributes_image, ' +
      '#growing_guide_banner_attributes_image, #problem_solver_banner_attributes_image, ' +
      '#promotion_banner_attributes_image, ' + '#video_playlist_cover_image').on 'change', ->
        readURL this
        return
  jQuery ->
    $('a.fancybox').fancybox()