<template >
  <div class="grid grid-cols-[1fr_5fr] h-screen">
    <Navbar/>
    <router-view :key="$route.path"></router-view>
  </div>
</template>

<script>
import User from './components/User.vue'
import Navbar from "@/components/Navbar.vue";

export default {
  name: 'App',
  components: {
    Navbar,
    User,
  }
}
</script>
