import Vue from 'vue/dist/vue.esm'
import App from '../app.vue'

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    el: '#tangoapp',
    data: {
      message: "Can you say hello?",
      counter: 0
    },
    components: { App }
  })
})
