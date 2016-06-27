import Vue from 'vue'
import Vuex from 'vuex'
Vue.use(Vuex)

import mutations from './mutations'

const state = {
  things: [],
  userId: null,
  users: [],
}

export default new Vuex.Store({
  state,
  mutations,
})
