<template>
<div id="cmp-home">
  <new-thing></new-thing>
  <ul>
    <thing
      v-for="thing in things"
      :thing="thing"
    ></thing>
  </ul>
</div>
</template>

<script>
import Thing from './Thing'
import NewThing from './NewThing'
import backend from '../backend'

export default {
  components: {
    NewThing,
    Thing,
  },
  computed: {
    things: backend.getters.things,
  },
  route: {
    data: function (transition) {
      backend.actions.thingsLoad()
    },
  },
}
</script>

<style>
</style>
