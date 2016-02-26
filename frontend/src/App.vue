<template>
  <div>
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

export default {
  computed: {
    jwt: function () {
      return JwtInterface.getters.jwt()
    },
  },
  methods: {
    signOut: function (ev) {
      JwtInterface.actions.clear()
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
