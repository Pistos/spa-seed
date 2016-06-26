import Vue from 'vue'
import VueRouter from 'vue-router'

Vue.use(require('vue-router'))
Vue.config.debug = true

import './Array.prototype.find'
import App from './App'
import Home from './components/Home'
import SignIn from './components/SignIn'
import SignUp from './components/SignUp'
import Splash from './components/Splash'

let router = new VueRouter()
router.map({
  '/': { component: Splash },
  '/home': { component: Home },
  '/sign-in': { component: SignIn },
  '/sign-up': { component: SignUp },
})
router.start(App, 'app')
