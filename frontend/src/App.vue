<template>
  <header>
  </header>

  <main>
    <router-view></router-view>
  </main>
</template>

<script>
import Chart from './components/Chart.vue'
export default {
  name: 'App',
  components: { Chart }
}
</script>
