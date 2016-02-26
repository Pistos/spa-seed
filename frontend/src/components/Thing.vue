<template>
<li class="cmp-thing">
  <div>
    <label>Name: <span>{{thing.name}}</span></label>
  </div>
  <div>
    <label>Description: <span>{{thing.description}}</span></label>
  </div>
</li>
</template>

<script>
export default {
  data () {
    return {}
  },
  props: ['thing'],
}
</script>

<style lang="sass">
</style>
