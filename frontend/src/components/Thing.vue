<template>
<li class="cmp-thing">
  <div>
    <label>Name: <span>{{thing.name}}</span></label>
  </div>
  <div>
    <label>Description: <span>{{thing.description}}</span></label>
  </div>
  <div>
    <button v-on:click.stop="deleteThis">delete</button>
  </div>
</li>
</template>

<script>
import backend from '../backend'

export default {
  data () {
    return {}
  },
  props: ['thing'],
  methods: {
    deleteThis: function () {
      backend.thingDelete(this.thing.id)
    },
  },
}
</script>

<style lang="sass">
</style>
