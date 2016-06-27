<template>
  <!-- /!\ See index.html in root dir.  This id="app" may not be right. -->
  <div id="app">
    <img class="logo" src="./assets/logo.png">
    <div id="nav">
      <a v-link="{ path: '/sign-in' }" v-if="! jwt">Sign In</a>
      <a v-link="{ path: '/sign-up' }" v-if="! jwt">Sign Up</a>
      <a v-link="{ path: '/home' }" v-if="jwt">Home</a>
      <a v-link="{ path: '/users/'+userId }" v-if="jwt">Account</a>
      <a v-on:click="signOut" v-if="jwt">Sign Out</a>
    </div>
    <router-view></router-view>
  </div>
</template>

<script>
import JwtInterface from './JwtInterface'
import backend from './backend'
import store from './store'

import userById from './functions/user-by-id'

export default {
  store,
  vuex: {
    getters: {
      userId: state => state.userId,
      users: state => state.users,
    },
  },
  computed: {
    jwt: function () {
      return JwtInterface.state.jwt
    },
    user: function () {
      return userById( this.userId )
    },
  },
  ready: function () {
    backend.usersLoad()
    backend.usersOwnId()
    backend.thingsLoad()
  },
  methods: {
    jwtClear: function () {
      JwtInterface.dispatch('CLEAR')
    },
    signOut: function (ev) {
      this.jwtClear()
      this.$router.go('/')
    },
  },
}
</script>

<style>
body {
  font-family: Helvetica, sans-serif;
}
</style>
