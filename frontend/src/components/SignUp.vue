<template>
  <div id="sign-up">
    <h1>Sign Up</h1>
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
        <td><input type="button" value="Sign Up" v-on:click="submit"/></td>
      </tr>
    </table>
  </div>
</template>

<script>
import backend from '../backend'

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
      backend.actions.userCreate(
        this.username,
        this.password,
        function (response) {
          console.log('Sign up successful')
          self.$router.go('/sign-in')
        }
      )
    },
  },
}

</script>

<style lang="sass">
</style>
