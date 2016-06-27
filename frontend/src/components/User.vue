<template>
<div id="cmp-user">
  <h3>User: {{user.username}}</h3>
</div>
</template>

<script>
import userById from '../functions/user-by-id'

export default {
  vuex: {
    getters: {
      users: state => state.users,
    },
  },
  computed: {
    user: function () {
      return userById( parseInt(this.$route.params.user_id, 10), this )
    },
  },
}
</script>

<style>
</style>
