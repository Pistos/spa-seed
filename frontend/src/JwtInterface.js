import Vue from 'vue'
import Vuex from 'vuex'
Vue.use(Vuex)

const state = {
  jwt: window.localStorage.getItem('jwt'),
}

const mutations = {
  SET (state, newValue) {
    state.jwt = newValue
    window.localStorage.setItem('jwt', newValue)
  },
  CLEAR (state) {
    state.jwt = null
    window.localStorage.removeItem('jwt')
  },
}

export default new Vuex.Store({
  state,
  mutations,
})
