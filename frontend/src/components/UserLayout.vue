<template>
  <div class="flex flex-col bg-[#2C2C2C]">
    <div>
      <Navbar/>
      <div class="grid grid-cols-[1fr_5fr]">
        <User />
        <router-view class="bg-[#232323] h-screen w-full" :key="$route.path"></router-view>
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
