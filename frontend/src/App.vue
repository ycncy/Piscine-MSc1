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

<script>
import User from './components/User.vue'
import Line from './components/Line.vue';
import User from './components/User.vue';
export default {
  name: 'App',
  components: { User }
  components: {
    Line,
    User
  }
}
</script>
<style>
</style>
