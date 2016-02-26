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
      let resource = this.$resource('http://'+window.location.hostname+':8082/api/users/authentications')
      let data = {
        username: this.username,
        password: this.password,
      }

      resource.save(data).then(
        function (response) {
          JwtInterface.actions.set(response.data.jwt)
          this.$router.go('/home')
        },
        function (response) {
          console.log('Failed to authenticate.')
        }
      )
    },
  },
}

</script>

<style lang="sass">
</style>
