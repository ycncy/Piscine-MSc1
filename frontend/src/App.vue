<script setup>
import Chart from './components/Chart.vue'

</script>

<template>
  <header>
  </header>

  <main>
    <Chart/>
    <router-view></router-view>
  </main>
  <router-link to="/workingtimes">Working times</router-link>
</template>


