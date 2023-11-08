<template>
  <div class="bg-[#242424] flex justify-between min-h-screen">
    <Navbar/>
    <div class="flex flex-col w-full min-h-screen">
      <User/>
      <router-view class="w-full" :key="$route.path"></router-view>
    </div>
  </div>
</template>

<script>
import User from "@/components/User.vue";
import Navbar from "@/components/Navbar.vue";
import {authentication_service} from "@/services/authentication.service";
import {users_service} from "@/services/users.service";

export default {
  components: {
    Navbar,
    User,
  },
  mounted() {
    if (!authentication_service.is_logged()) {
      this.$route.push("/login");
    }
  }
};
</script>
