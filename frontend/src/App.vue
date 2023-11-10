<template >
  <router-view></router-view>
</template>

<script>
import User from './components/User.vue'
import Navbar from "@/components/Sidebar.vue";

export default {
  name: 'App',
  components: {
    Navbar,
    User,
  }
}

</script>
