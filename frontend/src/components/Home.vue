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

export default {
  components: {
    NewThing,
    Thing,
  },
  vuex: {
    getters: {
      things: state => state.things,
    },
  },
}
</script>

<style>
</style>
