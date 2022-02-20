import $ from 'jquery'
import axios from 'axios'
import { csrfToken } from '@rails/ujs'

axios.defaults.headers.common['X-CSRF-Token'] = csrfToken()


document.addEventListener('DOMContentLoaded', () => {
    const dataset = $('#profile').data()
    const userId = dataset.userId
    axios.get(`/accounts/${userId}/follows/${userId}`)
        .then((response) => {
            const hasFollow = response.data.hasFollow
            if (hasFollow) {
                $('.unfollow').removeClass('hidden')
            } else {
                $('.follow').removeClass('hidden')
            }
        })
})