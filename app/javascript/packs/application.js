// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("@rails/activestorage").start()
require("channels")



// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

import axios from 'axios'
import $ from 'jquery'
import { csrfToken } from 'rails-ujs'

axios.defaults.headers.common[ 'X-CSRF-Token' ] = csrfToken()


const handleHeartDisplay = (hasLiked) => {
  if (hasLiked) {
    $('.active-heart').removeClass('hidden')
  } else {
    $('.inactive-heart').removeClass('hidden')
  }
}

document.addEventListener('DOMContentLoaded', () => {

  const dataset = $('#article-show').data()
  const articleId = dataset.articleId

  axios.get(`/articles/${articleId}/like`)
  .then((response) => {
    const hasLiked = response.data.hasLiked
    handleHeartDisplay(hasLiked)
    debugger
  })



  $('.inactive-heart').on('click', function () {
    const id = $(this).attr('id')

    axios.post(`/articles/${id}/like`)
      .then((response) => {
        if (response.data.status === 'ok') {
          $(`#${id}.active-heart`).removeClass('hidden')
          $(`#${id}.inactive-heart`).addClass('hidden')
        }
      })
      .catch((e) => {
        window.alert('Error')
        console.log(e)
      })
  })
  
  $('.active-heart').on('click', function () {
    const id = $(this).attr('id')
    
    axios.delete(`/articles/${id}/like`)
      .then((response) => {
        if (response.data.status === 'ok') {
          $(`#${id}.active-heart`).addClass('hidden')
          $(`#${id}.inactive-heart`).removeClass('hidden')
        }
      })
      .catch((e) => {
        window.alert('Error')
        console.log(e)
      })
  })

})


