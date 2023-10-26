<script setup>
import Chart from './components/Chart.vue'

</script>

<template>
  <header>
    <user/>
  </header>

  <main>
    <User />  
    <div class="canvas">
      <!-- <Line/> -->
    </div>
    <router-view></router-view>
  </main>
</template>

<<<<<<< HEAD

=======
<script>
import User from './components/User.vue'
import Line from './components/Line.vue';
import User from './components/User.vue';
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
