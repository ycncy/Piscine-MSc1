<template>
  <div v-if="authentication_service.is_logged()" class="bg-[#242424] flex justify-between min-h-screen">
    <Sidebar/>
    <div class="flex flex-col w-full min-h-screen">
      <router-view class="w-full" :key="$route.path"></router-view>
    </div>
  </div>
</template>

<script>
import User from "@/components/User.vue";
import {authentication_service} from "@/services/authentication.service";
import Sidebar from "@/components/Sidebar.vue";

export default {
  computed: {
    authentication_service() {
      return authentication_service
    }
  },
  components: {
    Sidebar,
    User,
  },
  beforeMount() {
    if (!authentication_service.is_logged()) {
      this.$router.push("/login");
    }
  }
};
</script>
