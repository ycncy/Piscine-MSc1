<script setup>
import Chart from './components/Chart.vue'

</script>

<template>
  <main>
    <User />
    <router-view></router-view>
    <div class="canvas">
    </div>
  </main>
</template>

<<<<<<< HEAD

=======
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
>>>>>>> e15263d42d3938f96c2fa43cb749f4444f07b325
