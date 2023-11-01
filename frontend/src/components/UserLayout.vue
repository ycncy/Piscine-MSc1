<template>
  <div class="bg-[#242424]">
    <div class="flex justify-between">
      <Navbar/>
      <div class="flex flex-col w-full h-screen">
        <User />
        <router-view class="h-screen w-full" :key="$route.path"></router-view>
      </div>
    </div>
  </div>
</template>

<script>
import User from "@/components/User.vue";
import Navbar from "@/components/Navbar.vue";

export default {
  components: {
    Navbar,
    User,
  },
};
</script>
