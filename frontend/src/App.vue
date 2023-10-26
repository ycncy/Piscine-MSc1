<template>
  <header>
  </header>

  <main>
    <Line/>
    <router-view></router-view>
  </main>
  <router-link to="/workingtimes">Working times</router-link>
</template>

<script>
import Line from './components/Line.vue'
export default {
  name: 'App',
  components: { Line }
}
</script>
