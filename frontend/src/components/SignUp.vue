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
        <td><input type="text" name="password" v-model="password" placeholder="password"/></td>
      </tr>
      <tr>
        <td></td>
        <td><input type="button" value="Sign Up" v-on:click="submit"/></td>
      </tr>
    </table>
  </div>
</template>

<script>
export default {
  data () {
    return {
      username: '',
      password: '',
    }
  },
  methods: {
    submit: function (ev) {
      // let resource = this.$resource('http://'+window.location.hostname+':8082/api/users')

      let data = {
        username: this.username,
        password: this.password,
      }

      // resource.save(data).then(
      this.$http.jsonp(
        'http://'+window.location.hostname+':8082/api/users',
        data,
        {
          method: 'POST',
        }
      ).then(
        function (response) {
          console.log('Sign up successful')
          this.$router.go('/sign-in')
        },
        function (response) {
          console.log('Sign up error')
        }
      )
    },
  },
}

</script>

<style lang="sass">
</style>
