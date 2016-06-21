<template>
<form id="cmp-new-thing" v-on:submit="submit">
  <h3>Create a New Thing</h3>

  <label for="name">Name:</label>
  <input type="text" name="name" v-model="name"/>
  <br/>
  <label for="description">Description:</label>
  <input type="text" name="description" v-model="description"/>
  <br/>
  <input type="submit" value="Create"/>
</form>
</template>

<script>
import backend from '../backend'

export default {
  data () {
    return {
      name: null,
      description: null,
    }
  },
  methods: {
    submit: function (ev) {
      ev.preventDefault()

      backend.thingCreate(this.name, this.description)
      this.name = null
      this.description = null
      document.querySelector('[name="name"]').focus()

      return false
    },
  },
}
</script>

<style>
</style>
