<template>
  <div>
    <div v-if="loading" class="h-screen w-full bg-[#232424] flex justify-center items-center">
      <Loader class="flex justify-center" />
    </div>
    <div v-if="authenticated && !loading" class="bg-[#242424] flex justify-between min-h-screen">
      <Sidebar/>
      <div class="flex flex-col w-full min-h-screen">
        <router-view class="w-full" :key="$route.path"></router-view>
      </div>
    </div>
  </div>
</template>

<script>
import User from "@/components/User.vue";
import { authentication_service } from "@/services/authentication.service";
import Sidebar from "@/components/Sidebar.vue";
import Loader from "@/components/Loader.vue";

export default {
  data() {
    return {
      authenticated: false,
      loading: true,
    };
  },
  components: {
    Loader,
    Sidebar,
    User,
  },
  async created() {
    const isAuthenticated = await authentication_service.is_logged();

    if (!isAuthenticated) {
      this.$router.push("/login");
    } else {
      this.authenticated = true;
    }

    this.loading = false;
  },
};
</script>
