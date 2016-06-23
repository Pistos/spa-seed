<template>
  <!-- /!\ See index.html in root dir.  This id="app" may not be right. -->
  <div id="app">
    <img class="logo" src="./assets/logo.png">
    <div id="nav">
      <a v-link="{ path: '/sign-in' }" v-if="! jwt">Sign In</a>
      <a v-link="{ path: '/sign-up' }" v-if="! jwt">Sign Up</a>
      <a v-link="{ path: '/home' }" v-if="jwt">Home</a>
      <a v-on:click="signOut" v-if="jwt">Sign Out</a>
    </div>
    <router-view></router-view>
  </div>
</template>

<script>
import JwtInterface from './JwtInterface'
import store from './store'

export default {
  store,
  computed: {
    jwt: function () {
      /* TOOD: I assume we shouldn't reach in and access the state directly like this */
      return JwtInterface.state.jwt
    },
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
