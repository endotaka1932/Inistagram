import $ from 'jquery'
import axios from 'axios'
import { csrfToken } from '@rails/ujs'

axios.defaults.headers.common['X-CSRF-Token'] = csrfToken()


const handleHeartDisplay = (hasLiked) => {
    if (hasLiked) {
        $('.active_heart').removeClass('hidden')
    } else {
        $('.inactive_heart').removeClass('hidden')
    }
}

document.addEventListener('DOMContentLoaded', () => {
        const dataset = $('#article').data()
        const articleId = dataset.articleId
        axios.get(`/articles/${articleId}/like`)
            .then((response) => {
                const hasLiked = response.data.hasLiked
                handleHeartDisplay(hasLiked)
        })

        $('.inactive_heart').on('click', () => {
            axios.post(`/articles/${articleId}/like`)
                .then((response) => {
                    if (response === 'ok'){
                        $('.active_heart').removeClass('hidden')
                        $('.inactive_heart').addClass('hidden')
                    }  
                })
                .catch((e) => {
                    window.alert('error')
                    console.log(e)
                })
        })

        $('.active_heart').on('click', () => {
            axios.delete(`/articles/${articleId}/like`)
                .then((response) => {
                    if (response === 'ok'){
                        $('.inactive_heart').removeClass('hidden')
                        $('.active_heart').addClass('hidden')
                    }  
                })
                .catch((e) => {
                    window.alert('error')
                    console.log(e)
                })
        })
        
        axios.get(`/articles/${articleId}/comments`)
            .then((res) => {
                const comments = res.data
                comments.forEach((comment) => {
                    $('.comments_container').append(
                        `<div class="article_comment"><p>${comment.content}</p></div>`
                    )
                })
            })

        $('.show_comment_form').on('click', () => {
            $('.comment_text_area').removeClass('hidden')
            $('.show_comment_form').addClass('hidden')
        })

        $('.add_comment_button').on('click', () => {
            const content = $('#comment_content').val()
            if (!content) {
                window.alert('コメントを入力してください')
            } else {
                axios.post(`/articles/${articleId}/comments`, {
                    comment: {content: content}
                })
                    .then((res) => {
                        const comment = res.data
                        $('.comments_container').append(
                            `<div class="article_comment"><p>${comment.content}</p></div>`
                        )                        
                        $('#comment_content').val('')
                })            
            }
        })
})
