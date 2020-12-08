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

const appendNewComment = (comment) => {
  $('.comments-container').append(
    `<div class="comment-card">
      <div class="comment-user-img"><img src="${comment.user.author_image}"></div>
      <div class="comment-user-info">
        <div class="comment-user-name"><p>${comment.user.account_name}</p></div>
        <div class="comment-user-content"><p>${comment.content}</p></div>
      </div>
    </div>`
  )
}




document.addEventListener('DOMContentLoaded', () => {
  // いいね機能
  $('.cards').each( function (index, card) {
    console.log($(card.children))
    $(card.children).each( function (index, child) {
      var id = $(child).attr('data-article-id')
      const handleHeartDisplay = (hasLiked) => {
        if (hasLiked) {
          $(`#${id}.active-heart`).removeClass('hidden')
        } else {
          $(`#${id}.inactive-heart`).removeClass('hidden')
        }
      }
      axios.get(`/articles/${id}/like`)
        .then((response) => {
          const hasLiked = response.data.hasLiked
          handleHeartDisplay(hasLiked)
        })

      axios.get(`/articles/${id}/comments`)
        .then((response) => {
          const comments = response.data
          comments.forEach((comment) => {
            appendNewComment(comment)
          })
        })

      })

      

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
  
  
  
  
  // コメント機能
  const id = $('.comments-container').attr('id') || $('.article-btn-comment').attr('id')
  // commentsリクエストのidがundifindになるエラーの対応
  if (typeof id !== 'undefined') {
    axios.get(`/articles/${id}/comments`)
      .then((response) => {
        const comments = response.data
        comments.forEach((comment) => {
          appendNewComment(comment)
        })
      })
  }
  
  $('.comment-submit-btn').on('click', function() {
    const content = $('#comment_content').val()
    if (!content) {
      window.alert('コメントを入力してください')
    } else {
      axios.post(`/articles/${id}/comments`, {
        comment: {content: content}
      })
        .then((res) => {
          const comment = res.data
          appendNewComment(comment)
          $('#comment_content').val('')
        })
    }
  })


  // フォロー機能
  const accountId = $('.profile').data('id')
  const myId = $('.container').data('id')
  if (typeof (accountId && myId) !== 'undefined') {
    axios.get(`/accounts/${accountId}/follows/${myId}`)
      .then((response) => {
        if( response.data.followStatus === true) {
          $('.unfollow-btn').removeClass('hidden')
        } else {
          $('.follow-btn').removeClass('hidden')
        }
      })
  }

  $('.follow-btn').on('click', function () {
    const accountId = $(this).attr('id')
    axios.post(`/accounts/${accountId}/follows`)
      .then((response) => {
        if(response.data.status === 'ok') {
          $('.follow-btn').addClass('hidden')
          $('.unfollow-btn').removeClass('hidden')
        } else {
          $('.follow-btn').removeClass('hidden')
          $('.unfollow-btn').addClass('hidden')
        }
      })
      .catch((e) => {
        window.alert('Error')
        console.log(e)
      })
  })

  // アンフォロー機能
  if (typeof (accountId && myId) !== 'undefined') {
    axios.get(`/accounts/${accountId}/unfollows/${myId}`)
      .then((response) => {
        if( response.data.followStatus === true) {
          $('.unfollow-btn').removeClass('hidden')
        } else {
          $('.follow-btn').removeClass('hidden')
        }
      })
  }

  $('.unfollow-btn').on('click', function () {
    const accountId = $(this).attr('id')
    axios.post(`/accounts/${accountId}/unfollows`)
      .then((response) => {
        if(response.data.status === 'ok') {
          $('.follow-btn').removeClass('hidden')
          $('.unfollow-btn').addClass('hidden')
        } else {
          $('.follow-btn').addClass('hidden')
          $('.unfollow-btn').removeClass('hidden')
        }
      })
      .catch((e) => {
        window.alert('Error')
        console.log(e)
      })
  })



})

