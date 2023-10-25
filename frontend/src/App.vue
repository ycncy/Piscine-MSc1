<template>
  <header>
  </header>

  <main>
  <Radar/>
    <router-view></router-view>
  </main>
</template>

<script>
import Radar from './components/Radar.vue'
export default {
  name: 'App',
  components: { Radar }
}
</script>
