import Vue from 'vue'
import Vuex from 'vuex'
Vue.use(Vuex)

import * as actions from './actions'
import mutations from './mutations'
import getters from './getters'

const state = {
  things: [],
}

export default new Vuex.Store({
  state,
  actions,
  mutations,
  getters,
})
