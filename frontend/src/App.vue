<template>
  <main>
    <User />
    <router-view></router-view>
    <div class="canvas">
    </div>
  </main>
</template>

<script>
import User from './components/User.vue'
import Line from './components/Line.vue';
export default {
  name: 'App',
  components: {
    Line,
    User
  }
}
</script>
<style>
</style>
