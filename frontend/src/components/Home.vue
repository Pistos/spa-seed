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
import store from '../store'

export default {
  components: {
    NewThing,
    Thing,
  },
  computed: {
    things: store.getters.things,
  },
  route: {
    data: function (transition) {
      /* TODO: This data load probably belongs elsewhere, in some
      earlier global initialization code */
      backend.thingsLoad()
    },
  },
}
</script>

<style>
</style>
