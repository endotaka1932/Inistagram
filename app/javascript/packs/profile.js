import $ from 'jquery'
import axios from 'axios'
import { csrfToken } from '@rails/ujs'

axios.defaults.headers.common['X-CSRF-Token'] = csrfToken()

const relationshipDisplay = (hasFollow) => {
    if (hasFollow) {
        $('.unfollow').removeClass('hidden')
    } else {
        $('.follow').removeClass('hidden')
    }
}


document.addEventListener('DOMContentLoaded', () => {
    const dataset = $('#profile').data()
    const userId = dataset.userId
    axios.get(`/accounts/${userId}/follows/${userId}`)
        .then((response) => {
            const hasFollow = response.data.hasFollow
            relationshipDisplay((hasFollow))
        })

    $('.follow').on('click', () => {
        axios.post(`/accounts/${userId}/follows`)
        .then((res) => {
            if (res === 'ok'){
                $('.follow').addClass('.hidden')
                $('.unfollow').removeClass('.hidden')
            }
        })
        .catch((e) => {
            window.alert('error')
            console.log(e)
        })
    })

    $('.unfollow').on('click', () => {
        axios.post(`/accounts/${userId}/unfollows`)
        .then((res) => {
            if (res === 'ok'){
                $('.unfollow').addClass('.hidden')
                $('.follow').removeClass('.hidden')
            }
        })
        .catch((e) => {
            window.alert('error')
            console.log(e)
        })        
    })

})