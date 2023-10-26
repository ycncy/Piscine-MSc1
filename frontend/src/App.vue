<template >
  <div class="grid grid-cols-[1fr_3fr] h-screen w-screen">
    <div>
      <User />
    </div>
    <div class="h-screen">
      <Navbar/>
      <Dashboard/>
    </div>
  </div>
</template>

<script>
import User from './components/User.vue'
import Line from './components/ChartManager/Line.vue';
import Home from './components/Home.vue';
import Navbar from "@/components/Navbar.vue";
import Dashboard from "@/components/Dashboard.vue";

export default {
  name: 'App',
  components: {
    Dashboard,
    Navbar,
    Line,
    User,
    Home
  }
}
</script>
