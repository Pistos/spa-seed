<template>
  <div id="sign-in">
    <h1>Sign In</h1>
    <table>
      <tr>
        <td><label for="username">Username</label></td>
        <td><input type="text" name="username" v-model="username" placeholder="username"/></td>
      </tr>
      <tr>
        <td><label for="password">Password</label></td>
        <td><input type="password" name="password" v-model="password" placeholder="password"/></td>
      </tr>
      <tr>
        <td></td>
        <td><input type="button" value="Sign In" v-on:click="submit"/></td>
      </tr>
    </table>
  </div>
</template>

<script>
import backend from '../backend'
import JwtInterface from '../JwtInterface'

export default {
  data () {
    return {
      username: '',
      password: '',
    }
  },
  methods: {
    submit: function (ev) {
      let self = this
      backend.actions.userAuthenticationCreate(
        this.username,
        this.password,
        function (response) {
          if( response.error ) {
            console.log('Sign in error: ' + response.error)
          } else {
            console.log('Sign in successful')
            JwtInterface.actions.set(response.jwt)
            self.$router.go('/home')
          }
        }
      )
    },
  },
}

</script>

<style lang="sass">
</style>
