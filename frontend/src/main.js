import Vue from 'vue'

Vue.config.debug = true

import './Array.prototype.find'

import App from './App'

import router from './router'

router.start(App, 'app')
