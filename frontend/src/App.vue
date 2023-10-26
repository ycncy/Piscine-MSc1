<script setup>
import Chart from './components/Chart.vue'

</script>

<template>
  <header>
    <user/>
  </header>

  <main>
    <div class="canvas">
      <!-- <Line/> -->
    </div>
    <router-view></router-view>
  </main>
  <router-link to="/workingtimes">Working times</router-link>
</template>

<<<<<<< HEAD

=======
<script>
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
  body .canvas {
    width: 600px;
    height: 600px;
  }
</style>
>>>>>>> e15263d42d3938f96c2fa43cb749f4444f07b325
