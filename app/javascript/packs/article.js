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
})
