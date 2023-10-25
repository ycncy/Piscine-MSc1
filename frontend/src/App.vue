<template>
  <header>
  </header>

  <main>
  <Radar/>
    <router-view></router-view>
  </main>
  <router-link to="/workingtimes">Working times</router-link>
</template>

<script>
import Radar from './components/Radar.vue'
export default {
  name: 'App',
  components: { Radar }
}
</script>
