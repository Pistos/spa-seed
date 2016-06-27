import Vue from 'vue'
import VueRouter from 'vue-router'

Vue.use(require('vue-router'))

import Home from './components/Home'
import SignIn from './components/SignIn'
import SignUp from './components/SignUp'
import Splash from './components/Splash'
import User from './components/User'

let router = new VueRouter()
router.map({
  '/': { component: Splash },
  '/home': { component: Home },
  '/sign-in': { component: SignIn },
  '/sign-up': { component: SignUp },
  '/users/:user_id': { component: User },
})

export default router
