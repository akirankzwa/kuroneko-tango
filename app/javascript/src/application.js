import Vue from 'vue/dist/vue.esm'

const axios = require('axios');

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    el: '#flashcardNew',
    data: {
    },
    methods: {
      createFlashcard: function(event) {
        axios.post('/flashcards.json', {
          term: this.$refs.input.value,
          definition: this.$refs.textarea.value,
          group: this.$refs.group.value
        }).then(function (response) {
          document.getElementById('a1').value = response['data']['term']
          document.getElementById('a2').value = response['data']['definition']
          document.getElementById('a3').src = response['data']['speech']
        }).catch(function (error) {
          document.getElementById('a0').textContent = error.response['data']['term']
        }).then(function () {
        });
      }
    }
  })
})
